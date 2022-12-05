<#
.SYNOPSIS
Created By Nick Brizzolara
Created on 11/27/2022

Script grabs GUID of software and calls MSIExec to silently uninstall

.DESCRIPTION

Script calls all installed packages through ComObject since querying Win32_Product causes a consistency check on all installed applications.
Output is then filtered for the specific application by name and the GUID is passed through string filtering to remove bloat.
MSIExex is then called to silently uninstall and log the uninstallation.

#>
#Check if temp directory exists, if not creates.
$TempDirectory = "C:\Temp"
$TempExists = Test-Path $TempDirectory 
If ($TempExists -eq $false) {

    New-Item $TempDirectory -ItemType Directory

    elseif ($TempExists -eq $true) {
        Write-Host "Temp Directory Already Exists"
    }{
    }
}

$Installer = New-Object -ComObject WindowsInstaller.Installer 
$InstallerProducts = $Installer.ProductsEx("", "", 7)
$InstalledProducts = ForEach($Product in $InstallerProducts){[PSCustomObject]@{ProductCode = $Product.ProductCode()
LocalPackage = $Product.InstallProperty("LocalPackage")
VersionString = $Product.InstallProperty("VersionString")
ProductPath = $Product.InstallProperty("ProductName")}}


$UninstallCode = $InstalledProducts | Where-Object ProductPath -like "Google Chrome" | Select-Object ProductCode
#Output is passed as a dirty string and needs to be trimmed twice.
$UninstallCode1 = $UninstallCode -replace "@{ProductCode="
#Second trim requires a regex to remove only the first instance of "}" since there are 2 at the end of the first trim.
[regex]$pattern2 = "}"
$TrueUninstallCode = $pattern2.Replace($UninstallCode1,"",1)

#MSIExec silently uninstalls and logs to temp.
msiexec /x $TrueUninstallCode /qn /l*v "C:\Temp\ChromeUninstall.Log"
