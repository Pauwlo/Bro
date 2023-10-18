function Install-Software {

	Install-Chocolatey

	if (Test-InstallSoftware Firefox) {
		choco install firefox -ry
	}

	if (Test-InstallSoftware VLC) {
		choco install vlc -ry
	}

	if (Test-InstallSoftware NotepadPlusPlus) {
		choco install notepadplusplus -ry
	}

	if (Test-InstallSoftware 7Zip) {
		choco install 7zip -ry

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
