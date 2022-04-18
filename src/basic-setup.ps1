# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal 
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows

function Write-Working
{
  Clear-Host
  Write-Host "running..."
}

function Exit-code
{
  if ( $? )
  {
    Throw "`nProgram exited with code: $? [1]`n"
  }
  else
  {
    Write-Host "`nProgram exited with code: $? [0]`n"
    
  }
}

# Define an array of software to install with winget
$pkgs=(
  'vim.vim',
  'Microsoft.PowerToys',
  'Microsoft.WindowsTerminal',
  'Microsoft.VisualStudioCode',
  'GnuWin32.Grep',
  'python'
)

$adminless_pkgs=(
  'Microsoft.VisualStudioCode'
)

$mingw_pkgs=(
  'gcc',
  'msys'
)

$ps_modules=(
  'ps2exe',
  'git'
)

function add_path 
{
  mkdir C:\bin\
  Copy-Item .\bin\* C:\bin\

  $old_path = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\`
  CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

  if ( $path -like ($env:path).split(";") )
  {
    exit 1
  }
  else 
  {
    $newpath = "$old_path;C:\local\bin;C:\MinGW\bin;C:\MinGw\msys\1.0\bin"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\`
    CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath
  }
}

function install_mingw
{ 
  mkdir .\tmp
  #Download mingw executable
  Invoke-WebRequest 'https://www.rose-hulman.edu/class/`
  csse/binaries/MinGW/mingw-get-inst-20110530.exe'`
   -o mingw-installer.exe
   # Run the executable
  .\tmp\mingw-installer.exe
  Start-Sleep 3
  Remove-Item .\tmp\ -recurse
}

function install_chocolatey
{
  # Install chocolatey 
  Set-ExecutionPolicy Bypass -Scope Process -Force;
  [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.ServicePointManager]::SecurityProtocol -bor 3072;
  Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

function client_install 
{
  if ($systemwide_installation)
  {
    ### feature Management ###
    
    # Enable NFS
    Enable-WindowsOptionalFeature -FeatureName ServicesForNFS-ClientOnly,`
    ClientForNFS-Infrastructure -Online -NoRestart
    
    ### Package Management ###
    
    # Install mingw
    Write-Working
    install_mingw

    # Install Chocolatey
    Write-Host
    install_chocolatey

    # Install winget packaget
    Foreach($pkg in $pkgs)
    {
      Write-Working
      Write-Host "Installing" $pkg"..."
      winget install -e --id $pkg
    }
    
    # Loop through powershell modules to install
    Foreach($module in $ps_modules)
    {
      Write-Working
      Write-Host "Installing $module"
      Install-Module -Name $module
    }
    
    # Loop through mingw package list and install each package
    Foreach($mingw_pkg in $mingw_pkgs)
    {
      Write-Working
      Write-Host "Installing" $mingw_pkg"..."
      mingw-get install $mingw_pkg
    }
  }
  elseif($user_installation)
  {
    Write-Host "Not enabling NFS on User installation."
    
    # Loop through powershell modules to install
    Foreach($module in $ps_modules)
    {
      Write-Working
      Write-Host "Installing Powershell module: $module"
      Install-Module -Name -Scope CurrentUser $module
    }
  }
}

function main 
{
  $scope = Read-Host "User installation[user] or Systemwide installation[admin]?"
  
  if ($scope -eq "user" -or $scope -eq "u")
  {
    $user_installation = $True
  }
  elseif ($scope -eq "admin" -or $scope -eq "a") 
  {
    $systemwide_installation = $True 
  }
  else
  {
    Write-Host "Inproper selection, exiting..."
    exit 1
  }

  $client = Read-Host "Start installation? y/n"
  if ( $client -eq "y" -or $client -eq "yes" -or $client -eq "" )
  {
    client_install
    if ($?)
    {
      return True
    }
    else
    {
      return False
    }
  }

  else
  {
    Write-Host "Exiting..."
    exit 0
  }
}

Clear-Host
Write-Host "Starting..."
Write-Working

main
Exit-Code
