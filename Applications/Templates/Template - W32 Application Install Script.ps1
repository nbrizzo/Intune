<#
.SYNOPSIS 
Created by Nick Brizzolara
Created on 11/27/2022

Intune W32 Application Install Template.

.Description
Script checks if temp directory exists and creates if it does not. Script then installs package silently with verbose logging enabled.

Rename Script to Install.ps1 when finished editing variables.
#>
$TempDirectory = "C:\Windows\Temp"
$TempExists = Test-Path $TempDirectory 
$Installer = "<Path to installer>"

If ($TempExists -eq $false) {

    New-Item $TempDirectory -ItemType Directory

    elseif ($TempExists -eq $true) {
        Write-Host "Temp Directory Already Exists"
    }{
    }
}

msiexec /i $Installer /qn /L*v "C:\Temp\LogName.Log"