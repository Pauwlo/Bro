function Update-Software {

	if (Test-InstallSoftware Chocolatey) {
		choco upgrade all -ry
	}

	winget upgrade --all
}
