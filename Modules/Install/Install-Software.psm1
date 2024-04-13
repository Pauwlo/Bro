function Install-Software {

	#if (($Config.chocolatey.Count -ge 1) -or (Test-Feature install.installWinGet)) {
		Install-Chocolatey

		if (Test-Feature install.installWinGet) {
			choco install microsoft-vclibs -ry
			choco install winget -ry
		}

		choco install firefox -ry
		choco install vlc -ry
		choco install notepadplusplus -ry
		choco install 7zip -ry
	#}

	#winget install -e --id Mozilla.Firefox --accept-source-agreements --accept-package-agreements
	#winget install -e --id VideoLAN.VLC --accept-source-agreements --accept-package-agreements
	#winget install -e --id Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements
	#winget install -e --id 7zip.7zip --accept-source-agreements --accept-package-agreements

	#if ((Test-InstallChocolateyPackage 7Zip) -or (Test-InstallWinGetPackage 7Zip)) {
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
	#}
}
