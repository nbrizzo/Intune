<#
.SYNOPSIS
Created by Nick Brizzolara
Created on 11/27/2022

Script creates an RDP link to an IP and places the shortcut in the Public Desktop folder.

#>

$wshshell = New-Object -ComObject WScript.Shell
$ShortcutName = "C:\Users\Public\Desktop\ChangeME.lnk"
$RDPIP = "/v:0.0.0.0"
$Description = "Change Me"

$lnk = $wshshell.CreateShortcut($ShortcutName)
$lnk.TargetPath = "%windir%\system32\mstsc.exe"
$lnk.Arguments = $RDPIP
$lnk.Description = $Description
$lnk.Save()
