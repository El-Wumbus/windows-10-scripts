Clear-Host
Write-Host "Starting..."
$client = Read-Host "Client installation? y/n"

function add_path 
{
  mkdir \local\bin\
  Copy-Item .\* \local\bin\

  $old_path = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path

  if ( $path -like ($env:path).split(";") )
  {
    exit 1
  }
  else 
  {
    $newpath = "$old_path;C:\local\bin"
    Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newpath
  }
}
function client_install 
{
  #Enable NFS
  Enable-WindowsOptionalFeature -FeatureName ServicesForNFS-ClientOnly, ClientForNFS-Infrastructure -Online -NoRestart
}

if ( $client -eq "y" -or "Y" -or "yes" -or "Yes" -or "YES" )
{
client_install
}

else {
  Write-Host "This script is only for windows 10 Home/Pro editions (Client Installs)"
  exit 1
}

