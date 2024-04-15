function Install-ChocolateyPackages {

	if (-not (Test-ChocolateyInstalled)) {
		Write-Warning 'Chocolatey not found. Packages will not be installed.'
		return
	}

	if (Test-InstallChocolateyPackage Firefox) {
		choco install firefox -ry
	}

	if (Test-InstallChocolateyPackage 7-Zip) {
		choco install 7zip -ry
	}

	if (Test-InstallChocolateyPackage Notepad++) {
		choco install notepadplusplus -ry
	}

	if (Test-InstallChocolateyPackage VLC) {
		choco install vlc -ry
	}
}
