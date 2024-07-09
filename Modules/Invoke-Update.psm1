function Invoke-Update {
	$ProgressPreference = 'SilentlyContinue'

	# Block Microsoft telemetry
	if (Test-Feature common.blockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Import certificates
	if (Test-Feature common.importCertificates) {
		Write-Host 'Importing certificates...'
		Import-Certificates
	}

	# Install fonts
	if (Test-Feature install.installFonts) {
		Write-Host 'Installing fonts...'
		Install-Fonts
	}

	# Remove Edge shortcut from Desktop
	if (Test-Feature common.removeEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Install software
	if (Test-Feature update.updateSoftware) {
		Write-Host 'Updating software...'
		
		if ($VerbosePreference -eq 'SilentlyContinue') {
			Update-Software | Out-Null
		} else {
			Update-Software
		}
	}

	# Clean-up start menu and desktop
	if (Test-Feature common.cleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}
