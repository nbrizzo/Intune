<#
.SYNOPSIS
Created by Nick Brizzolara
Created on 12/1/2022

Script detects if Company Portal is installed via regkey and returns exit code based on path state.

#>

$Regpath = "HKCU:\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppModel\Repository\Packages\Microsoft.CompanyPortal*x64*"
$TestReg = Test-Path $Regpath

If ($TestReg -eq $true) {

Write-host "Company Portal is Installed"
Exit 0
}else {
    
    exit 1
}

