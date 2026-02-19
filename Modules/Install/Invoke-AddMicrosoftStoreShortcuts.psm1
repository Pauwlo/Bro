function Invoke-AddMicrosoftStoreShortcuts {
	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	$AppxAvailable = [bool](Get-Command Get-AppxPackage -ErrorAction SilentlyContinue)

	function Test-AppxInstalled($Name) {
		if ($AppxAvailable) {
			[bool](Get-AppxPackage -Name $Name -ErrorAction SilentlyContinue)
		} else {
			[bool](Get-ChildItem "$env:ProgramFiles\WindowsApps\$Name*" -ErrorAction SilentlyContinue)
		}
	}

	$StoreInstalled = Test-AppxInstalled "Microsoft.WindowsStore"

	if (!$StoreInstalled) {
		New-Shortcut "$DesktopPath\Install Microsoft Store.lnk" 'wsreset' '-i >nul' | Out-Null
	}

	if (!$StoreInstalled -or !(Test-AppxInstalled "Microsoft.DesktopAppInstaller")) {
		New-Shortcut "$DesktopPath\Get App Installer.url" 'ms-windows-store://pdp/?ProductId=9nblggh4nns1'
	}

	if (!(Test-AppxInstalled "Microsoft.WindowsCalculator")) {
		New-Shortcut "$DesktopPath\Get Calculator.url" 'ms-windows-store://pdp/?ProductId=9wzdncrfhvn5'
	}

	if (!(Test-AppxInstalled "Microsoft.WebpImageExtension")) {
		New-Shortcut "$DesktopPath\Get Webp Image Extensions.url" 'ms-windows-store://pdp/?ProductId=9pg2dk419drg'
	}
}
