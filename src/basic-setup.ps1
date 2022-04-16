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
$pkgs=
(
  'vim.vim',
  'Microsoft.PowerToys',
  'Microsoft.WindowsTerminal',
  'Microsoft.VisualStudioCode',
  'GnuWin32.Grep'
)

# Define an array of software to install with MinGW
$mingw_pkgs=
(
  'gcc',
  'msys'
)

# Define an array of modules to install with Install-Modules
$modules=
(
  'git',
  'ps2exe'
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
  rmdir .\tmp\ -recurse
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
  if ( $User_Installation )
  {
    Write-Host "Skipping admin-only features"
    
    ### Manage Packages ###

    # Loop through and install modules
    Foreach( $module in $modules )
    {
      Write-Working
      Write-Host "Installing $pkg"...""
      Install-Module $module -Scope CurrentUser
    }
  }
  elseif ( $Systemwide_Installation )
  {
    ### Manage Windows Features ###
    
    #Enable NFS
    Enable-WindowsOptionalFeature -FeatureName ServicesForNFS-ClientOnly,`
    ClientForNFS-Infrastructure -Online -NoRestart

    ### Manage Packages ###
    
    # Loop through and install winget packages
    Foreach( $pkg in $pkgs )
    {
      Write-Working
      Write-Host "Installing" $pkg"..."
      winget install -e --id $pkg
    }

    # Loop through and install modules
    Foreach( $module in $modules )
    {
      Write-Working
      Write-Host "Installing $pkg"...""
      Install-Module $module
    }
    
    # Install MinGW
    install_mingw
    
    # Loop through mingw package list and install each package
    Foreach($mingw_pkg in $mingw_pkgs)
    {
      Write-Working
      Write-Host "Installing" $mingw_pkg"..."
      mingw-get install $mingw_pkg
    }
  } 
  }
  else
  {
    exit 1
  }
  # Add included binaries to path
  add_path

function main 
{
  $scope = Read-Host "User installation[user] or Systemwide installation[admin]?"
  if ( $scope -eq 'user' -or $scope -eq 'u' )
  {
    $User_Installation = $true
  }
  elseif ( $scope -eq 'admin' -or $scope -eq 'a' )
  {
    $Systemwide_Installation = $True
  }
  else
  {
    $User_Installation = $True
  }

  $client = Read-Host "Start Client installation? y/n"
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
