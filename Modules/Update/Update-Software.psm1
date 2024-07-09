function Update-Software {

	if (Test-Feature update.updateChocolateyPackages) {
		choco upgrade all -ry
	}

	if (Test-Feature update.updateWinGetPackages) {
		winget upgrade --all
	}

}
