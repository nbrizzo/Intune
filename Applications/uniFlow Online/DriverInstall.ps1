<#
.SYNOPSIS
uniFlow Online Universal Print Driver Install
Version 1.0
Created by Nick Brizzolara
Created on 3/29/2023

.DESCRIPTION

This script installs the uniFlow universal print driver since the W32 app will prompt users for admin consent to install the driver without this.

#>

#Static Variables

#Log file location setup | possibly read-host for a log path in the future?
$dateandtime = Get-Date -Format "yyyy_MM_dd_HH_mm"
$logfilelocation = "C:\Temp\uniFlow_Driver_Install_" + $dateandtime + '.log'
$DriverName = "uniFLOW Universal PclXL Driver"
$IsDriverInstalled = Get-PrinterDriver -Name $DriverName -ErrorAction SilentlyContinue

Function Write-LogMessage ([string]$message) {
    $messageToLog = (Get-Date -Format "yyyyMMdd-HH_mmss") + ": " + $message
    $messageToLog | Out-File -Append -FilePath $logFileLocation
}


If($IsDriverInstalled){
    
    Write-Host "$($DriverName) is already installed on this workstation."
    Write-LogMessage("$($DriverName) is already installed on this workstation.")

}
    else{
        
        Write-Host "Not Installed"
        pnputil.exe /add-driver "MomUdPclXl.inf" /install
        Add-PrinterDriver -Name $drivername
        Write-LogMessage("$($DriverName) is not installed on this workstaion, installing it.")

    }


