<#
.SYNOPSIS
Created by Nick Brizzolara
Created on 3/14/2023
Script automatically runs IntuneWinAppUtil to package W32 apps.

.DESCRIPTION

#>

#Static Variables
$OutputDirectory = "C:\Output_Files"
$SourceDirectory = "C:\Source_Files"
$SourceExists = Test-Path $SourceDirectory 
$OutputExists = Test-Path $OutputDirectory 
$InstallFiles = Get-ChildItem -Path $SourcePath | Where-Object {$_.Name -like '*.MSI' -or $_.Name -like '*.exe'}
$arguments = "-c $($SourceDirectory)" + " -s $($InstallFiles.Name)" + " -o $($OutputDirectory)"

#Check if Source & Output directories exist, if not then create them.
If ($SourceExists -eq $False) {
    New-Item $SourceDirectory -ItemType Directory
}
    elseif ($SourceExists -eq $True) {
        Write-Host "Path already exists"
        }

If ($OutputeExists -eq $false) {

    New-Item $OutputDirectory -ItemType Directory
}
    elseif ($OutputExists -eq $true) {
        Write-Host "Source Directory Already Exists" 
}

#Check if their are multiple installation files in the source directory, if there are then you must manually specify which file to use.
If ($InstallFiles.Count -eq 1){
    
    Start-Process -FilePath C:\IntuneWinAppUtil.exe -ArgumentList $arguments
}
Elseif ($installfiles.count -ge 2) {
   Write-Host "Too many installers are present in the directory, please specify the installer you wish to use."
   Write-Host $InstallFiles.Name
   $installfile = Read-Host
   $arguments = "-c $($SourceDirectory)" + " -s $($InstallFile)" + " -o $($OutputDirectory)"
   Start-Process -FilePath C:\IntuneWinAppUtil.exe -ArgumentList $arguments
}

