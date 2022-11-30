<#
.SYNOPSIS
Adapted from: https://helloitsliam.com/2021/01/25/note-to-self-powershell-create-dynamic-azure-ad-group/
Created by Nick Brizzolara
Created on 11/28/2022

Baseline AAD Dynamic Groups for Intune Deployments

.DESCRIPTION
Script creates multiple dynamic groups with common membership statements.
#>

#Check if AAD Preview module installed, if not installs and then gets AAD creds and authenticates.
if (Get-Module -ListAvailable -Name AzureADPreview) {
    Write-Host "AzureADPreview Module Already Installed" -ForegroundColor Green
} 
else {
    Write-Host "AzureADPreview Module Not Installed. Installing........." -ForegroundColor Red
        Install-Module -Name AzureADPreview -AllowClobber -Force
    Write-Host "AzureADPreview Module Installed" -ForegroundColor Green
}
Import-Module AzureADPreview
$AADCreds = Get-Credential
Connect-AzureAD -Credential $AADCreds

#Set Dynamic Group variables
$CorpWin10 = "Intune - Corporate Windows 10 Devices"
$CorpWin10MailName = "IntuneCorporateWindows10Devices"
$CorpWin10DRule = "(device.deviceOSType -eq ""Windows"") and (device.deviceOSVersion -contains ""10.0.1"") and (device.deviceOwnership -eq ""Company"")"

$CorpWin11 = "Intune - Corporate Windows 11 Devices"
$CorpWin11MailName = "IntuneCorporateWindows11Devices"
$CorpWin11DRule = "(device.deviceOSType -eq ""Windows"") and (device.deviceOSVersion -contains ""10.0.2"") and (device.deviceOwnership -eq ""Company"")"

$BYODWin10 = "Intune - Personal Windows 10 Devices"
$BYODWin10MailName = "IntunePersonalWindows10Devices"
$BYODWin10DRule ="(device.deviceOSType -eq ""Windows"") and (device.deviceOSVersion -contains ""10.0.1"") and (device.deviceOwnership -eq ""Personal"")"

$BYODWin11 = "Intune - Personal Windows 11 Devices"
$BYODWin11MailName = "IntunePersonalWindows11Devices"
$BYODWin11DRule = "(device.deviceOSType -eq ""Windows"") and (device.deviceOSVersion -contains ""10.0.2"") and (device.deviceOwnership -eq ""Personal"")"

#Update to proper Autopilot group variables and then update respective code for creating the group.
#$TempAP = "Autopilot - Template Group"
#$TempAPMailName = "AutopilotTemplateGroup"
#$TempAPDRule = "(device.devicePhysicalIds -any _ -eq ""[OrderID]:CHANGEME"")"

#Create Dynamic Groups and set to groups to begin membership sync immediately.
$CorpWin10Create = New-AzureADMSGroup -Description "$($CorpWin10)" `
    -DisplayName "$($CorpWin10)" `
    -MailEnabled $false `
    -SecurityEnabled $true `
    -MailNickname "$($CorpWin10MailName)" `
    -GroupTypes "DynamicMembership" `
    -MembershipRule "$($CorpWin10DRule)" `
    -MembershipRuleProcessingState "Paused"
Set-AzureADMSGroup -Id $CorpWin10Create.Id -MembershipRuleProcessingState "Paused"

$CorpWin11Create = New-AzureADMSGroup -Description "$($CorpWin11)" `
    -DisplayName "$($CorpWin11)" `
    -MailEnabled $false `
    -SecurityEnabled $true `
    -MailNickname "$($CorpWin11MailName)" `
    -GroupTypes "DynamicMembership" `
    -MembershipRule "$($CorpWin11DRule)" `
    -MembershipRuleProcessingState "Paused"
Set-AzureADMSGroup -Id $CorpWin11Create.Id -MembershipRuleProcessingState "Paused"

$BYODWin10Create = New-AzureADMSGroup -Description "$($BYODWin10)" `
    -DisplayName "$($BYODWin10)" `
    -MailEnabled $false `
    -SecurityEnabled $true `
    -MailNickname "$($BYODWin10MailName)" `
    -GroupTypes "DynamicMembership" `
    -MembershipRule "$($BYODWin10DRule)" `
    -MembershipRuleProcessingState "Paused"
Set-AzureADMSGroup -Id $BYODWin10Create.Id -MembershipRuleProcessingState "Paused"

$BYODWin11Create = New-AzureADMSGroup -Description "$($BYODWin11)" `
    -DisplayName "$($BYODWin11)" `
    -MailEnabled $false `
    -SecurityEnabled $true `
    -MailNickname "$($BYODWin11MailName)" `
    -GroupTypes "DynamicMembership" `
    -MembershipRule "$($BYODWin11DRule)" `
    -MembershipRuleProcessingState "Paused"
Set-AzureADMSGroup -Id $BYODWin11Create.Id -MembershipRuleProcessingState "Paused"

#Update with proper Autopilot Group Variables
#$TempAPCreate = New-AzureADMSGroup -Description "$($TempAP)"`
#    -DisplayName "$($TempAP)"`
#    -MailEnabled $false`
#    -SecurityEnabled $true`
#    -MailNickname "$($TempAPMailName)"`
#    -GroupTypes "DynamicMembership"`
#    -MembershipRule "$($TempAPDRule)"`
#    -MembershipRuleProcessingState "Paused"
#Set-AzureADMSGroup -Id $TempAPCreate.Id -MembershipRuleProcessingState "Paused"
