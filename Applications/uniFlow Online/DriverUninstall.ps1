<#
.SYNOPSIS
uniFlow Online Universal Print Driver Uninstall
Version 1.0
Created by Nick Brizzolara
Created on 3/29/2023

.DESCRIPTION

This script uninstalls the uniFlow universal print driver.

#>

$dateandtime = Get-Date -Format "yyyy_MM_dd_HH_mm"
$logfilelocation = "C:\Temp\uniFlow_Driver_uninstall_" + $dateandtime + '.log'
$DriverName = "uniFLOW Universal PclXL Driver"
$uniFlowPrinters = Get-Printer | Where-Object{$_.DriverName -eq $DriverName} 
$IsDriverInstalled = Get-PrinterDriver -Name $DriverName -ErrorAction SilentlyContinue


Function Write-LogMessage ([string]$message) {

    $messageToLog = (Get-Date -Format "yyyyMMdd-HH_mmss") + ": " + $message
    $messageToLog | Out-File -Append -FilePath $logFileLocation

}


foreach($Printer in $uniFlowPrinters){
try {

    $Message = "Removing printer object named $($Printer.name) & print driver named $($DriverName)"
    Remove-Printer -Name $Printer.name
    Write-Host $Message
    Write-LogMessage($Message)

}
catch {

    $FailureMessage = "No printers to uninstall"
    Write-LogMessage($FailureMessage)

}
}

If($IsDriverInstalled){

    Try{

    $Message = "Uninstalling print drivers named $($DriverName)"
    Remove-PrinterDriver -Name $DriverName
    Write-Host $Message
    Write-LogMessage($Message)

    }
    Catch{

    $FailureMessage = "There was an error uninstalling print driver named $($DriverName), please manually uninstall."
    Write-Host $FailureMessage
    Write-LogMessage $FailureMessage

    }
}
