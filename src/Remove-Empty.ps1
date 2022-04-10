
param (
  [string]$p1
)

if ( $p1 -eq "" )
{
  Write-Host "No argument suppiled"
  exit 1
}

do
{
  $dirs = Get-ChildItem $p1 -directory -recurse | Where-Object { (Get-ChildItem $_.fullName).count -eq 0 } | Select-Object -expandproperty FullName
  $dirs | Foreach-Object { Remove-Item $_ }
}
while ($dirs.count -gt 0) 