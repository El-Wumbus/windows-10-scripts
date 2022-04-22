#!/usr/bin/env pwsh

$c_code = (
  'yes',
  'Touch-File',
  'Random-Number',
  'Hello-World',
  'Echo-Input',
  'Get-File'
)

$cpp_code = (
  'which'
)

$python_code = (
  'Generate-Name',
  'Measure-InternetSpeed'
)

$powershell_scripts = (
  'Remove-Empty'
)

Set-Location .\src

Foreach($program in $c_code)
{
  Write-Host "Compiling ${program}..."
  gcc .\${program}.c -o ..\bin\bin\${program}.exe
  Write-Host "${program} compiled!"
}

Foreach($python_program in $python_code)
{
  Write-Host "Compiling ${python_program}..."
  pyinstaller --onefile -w .\${python_program}.py
  Copy-Item .\dist\${python_program}.exe ..\bin\bin\
  Write-Host "${python_program} compiled!"
}

Foreach($script in $powershell_scripts)
{
  Write-Host "Compiling ${script}..."
  ps2exe -inputFile .\${script}.ps1 -outputFile ..\bin\bin\${script}.exe -title ${script}
  Write-Host "${script} compiled!"
}

Foreach($program in $cpp_code)
{
  Write-Host "Compiling ${program}..."
  gcc ${program}.c -lstdc++ -o ..\bin\bin\${program}.exe
  Write-Host "${program} Compiled!"
}

Remove-Item .\build -recurse
Remove-Item .\dist -recurse
Remove-Item .\*.spec 
Set-Location ..\
