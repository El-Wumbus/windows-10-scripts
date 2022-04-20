#!/usr/bin/env pwsh
# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal 
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows, Linux, MacOS

<# The MIT License (MIT) <https://mit-license.org/>
Copyright © 2022 Aidan Neal

Permission is hereby granted, free of charge,
to any person obtaining a copy of this software and associated
documentation files (the “Software”), to deal in the Software
without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to
whom the Software is furnished to do so, subject to the
following conditions:

The above copyright notice and this permission notice shall
be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR
THE USE OR OTHER DEALINGS IN THE SOFTWARE
#>

param (
  [Parameter(Mandatory=$true,
  ValueFromPipeline=$true)]
  [string]
  $target_directory
)

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

function Remove-Empty
{
  do
  {
    $dirs = Get-ChildItem $target_directory -directory -recurse | Where-Object { (Get-ChildItem $_.fullName).count -eq 0 } | Select-Object -expandproperty FullName
    $dirs | Foreach-Object { Remove-Item $_ }
  }
  while ($dirs.count -gt 0) 
  Exit-Code
  
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