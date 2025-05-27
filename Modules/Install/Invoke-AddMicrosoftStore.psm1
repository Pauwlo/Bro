function Invoke-AddMicrosoftStore {
	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	New-Shortcut "$DesktopPath\Install Microsoft Store.lnk" 'wsreset' '-i >nul' | Out-Null
	
	New-Shortcut "$DesktopPath\Get App Installer.url" 'ms-windows-store://pdp/?ProductId=9nblggh4nns1'
	New-Shortcut "$DesktopPath\Get Calculator.url" 'ms-windows-store://pdp/?ProductId=9wzdncrfhvn5'
	New-Shortcut "$DesktopPath\Get Webp Image Extensions.url" 'ms-windows-store://pdp/?ProductId=9pg2dk419drg'
}
