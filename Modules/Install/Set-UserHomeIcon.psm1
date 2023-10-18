function Set-UserHomeIcon {
	$DesktopIniFile = @'
[.ShellClassInfo]
IconResource=C:\Windows\System32\SHELL32.dll,170
'@

	$DesktopIniFilePath = "$env:USERPROFILE\desktop.ini"

	Add-Content $DesktopIniFilePath -Value $DesktopIniFile
	(Get-Item $DesktopIniFilePath -Force).Attributes = 'Hidden, System, Archive'
	(Get-Item ((Get-ChildItem $DesktopIniFilePath -Force).Directory)).Attributes = 'ReadOnly, Directory'
}
