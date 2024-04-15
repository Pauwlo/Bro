function Install-Software {

	if (Test-Feature install.installChocolatey) {
		Install-Chocolatey
	}

	if (Test-Feature install.installChocolateyPackages) {
		Install-ChocolateyPackages
	}

	if (Test-Feature install.installWinGet) {
		Install-WinGet
	}

	if (Test-Feature install.installWinGetPackages) {
		Install-WinGetPackages
	}

	if ((Test-InstallChocolateyPackage '7-Zip') -or (Test-InstallWinGetPackage '7-Zip')) {
		# Create dummy shortcuts on the desktop
		$DesktopPath = [Environment]::GetFolderPath('Desktop')
		$DummyFileName = 'Dummy (right-click - Properties - Change...)'
		
		New-Item "$DesktopPath\$DummyFileName.7z" -Force | Out-Null
		New-Item "$DesktopPath\$DummyFileName.rar" -Force | Out-Null
		New-Item "$DesktopPath\$DummyFileName.zip" -Force | Out-Null

		# Set context menu items via registry
		$RegistryPath = 'HKCU:\SOFTWARE\7-Zip\Options'
		$Name = 'ContextMenu'
		$Value = '4359'

		if (! (Test-Path $RegistryPath)) {
			New-Item -Path $RegistryPath | Out-Null
		}

		New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
	}
}
