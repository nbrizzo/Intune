<#
Created by Nick Brizzolara

.SYNOPSIS 
Intune W32 Application Install Template.

.Description
Script checks if temp directory exists and creates if it does not. Script then installs package silently with verbose logging enabled.

Rename Script to Install.ps1 when finished editing variables.
#>
$TempDirectory = "C:\Windows\Temp"
$TempExists = Test-Path $TempDirectory 
$Installer = "AcroRdrDC2200320263_en_US.exe"

If ($TempExists -eq $false) {

    New-Item $TempDirectory -ItemType Directory

    elseif ($TempExists -eq $true) {
        Write-Host "Temp Directory Already Exists"
    }{
    }
}

msiexec /i $Installer /qn /L*v "C:\Temp\LogName.Log"