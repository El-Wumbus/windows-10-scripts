#!/usr/bin/env pwsh
# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal 
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows, Linux, MacOS

param (
  [Parameter(Mandatory=$true,
  ValueFromPipeline=$true)]
  [string]
  $target_directory
)

function Remove-Empty
{
  do
  {
    $dirs = Get-ChildItem $target_directory -directory -recurse | Where-Object { (Get-ChildItem $_.fullName).count -eq 0 } | Select-Object -expandproperty FullName
    $dirs | Foreach-Object { Remove-Item -Verbose $_ }
  }
  while ($dirs.count -gt 0) 
  return "Complete"
}

if ( Test-Path -Path $target_directory )
{
  Remove-Empty
}
else
{
  throw "Cannot find the suppiled path, did you enter it correctly?"
}