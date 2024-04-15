function Install-WinGet {

	if (-not (Test-ChocolateyInstalled)) {
		Write-Warning 'Chocolatey not found. WinGet will not be installed.'
		return
	}

	choco install microsoft-vclibs -ry
	choco install winget -ry
}
