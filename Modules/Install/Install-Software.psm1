function Install-Software {

	if (Test-InstallSoftware Chocolatey) {
		Install-Chocolatey

		if (Test-InstallSoftware WinGet) {
			choco install winget -ry
		}

		if (Test-InstallChocolateyPackage Firefox) {
			choco install firefox -ry
		}
	
		if (Test-InstallChocolateyPackage VLC) {
			choco install vlc -ry
		}
	
		if (Test-InstallChocolateyPackage NotepadPlusPlus) {
			choco install notepadplusplus -ry
		}

		if (Test-InstallChocolateyPackage 7Zip) {
			choco install 7zip -ry
		}
	}

	if (Test-InstallSoftware Firefox) {
		winget install -e --id Mozilla.Firefox --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallSoftware VLC) {
		winget install -e --id VideoLAN.VLC --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallSoftware NotepadPlusPlus) {
		winget install -e --id Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallSoftware 7Zip) {
		winget install -e --id 7zip.7zip --accept-source-agreements --accept-package-agreements
	}

	if ((Test-InstallChocolateyPackage 7Zip) -or (Test-InstallSoftware 7Zip)) {
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
