function Install-WinGetPackages {

	if (-not (Test-WinGetInstalled)) {
		Write-Warning 'WinGet not found. Packages will not be installed.'
		return
	}

	if (Test-InstallWinGetPackage Firefox) {
		winget install -e --id Mozilla.Firefox --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallWinGetPackage 7-Zip) {
		winget install -e --id 7zip.7zip --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallWinGetPackage Notepad++) {
		winget install -e --id Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallWinGetPackage VLC) {
		winget install -e --id VideoLAN.VLC --accept-source-agreements --accept-package-agreements
	}
}
