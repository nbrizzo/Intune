<#
Created by Nick Brizzolara

.SYNOPSIS
Create a Public Desktop URL Shortcut

#>
$WebsiteURL = "<URL of Website>"
$ShortcutName = "CHANGE ME.url"
$wshShell = New-Object -ComObject "WScript.Shell"

$urlShortcut = $wshShell.CreateShortcut(
  (Join-Path $wshShell.SpecialFolders.Item("AllUsersDesktop") $ShortcutName)
)

$urlShortcut.TargetPath = $WebsiteURL
$urlShortcut.Save()