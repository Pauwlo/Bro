function Invoke-Update {
	$ProgressPreference = 'SilentlyContinue'

	# Block Microsoft telemetry
	if (Test-Feature BlockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Import certificates
	if (Test-Feature ImportCertificates) {
		Write-Host 'Importing certificates...'
		Import-Certificates
	}

	# Install fonts
	if (Test-Feature InstallFonts) {
		Write-Host 'Installing fonts...'
		Install-Fonts
	}

	# Remove Edge shortcut from Desktop
	if (Test-Feature RemoveEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Install software
	if (Test-Feature InstallSoftware) {
		Write-Host 'Updating software...'
		Update-Software | Out-Null
	}

	# Clean-up start menu and desktop
	if (Test-Feature CleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}
