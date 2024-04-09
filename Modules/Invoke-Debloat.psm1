function Invoke-Debloat {
	$ProgressPreference = 'SilentlyContinue'

	# Block Microsoft telemetry
	if (Test-Feature common.blockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Patch Hosts file
	if (Test-Feature common.patchHosts) {
		Write-Host 'Patching hosts... (Windows Defender may false positive)'
		Invoke-PatchHosts
	}

	# Patch registry
	if (Test-Feature common.patchRegistry) {
		Write-Host 'Patching registry...'
		Invoke-PatchRegistry
	}

	# Disable Focus Assist automatic rules
	if (Test-Feature common.disableFocusAssist) {
		Write-Host 'Disabling Focus Assist automatic rules...'
		Disable-FocusAssist
	}

	# Uninstall useless apps
	if (Test-Feature common.uninstallUselessApps) {
		Write-Host 'Uninstalling useless apps...'
		Remove-UselessApps
	}

	# Uninstall OneDrive
	if (Test-Feature install.uninstallOneDrive) {
		Write-Host 'Uninstalling OneDrive...'
		Remove-OneDrive
	}
	
	# Remove Edge shortcut from Desktop
	if (Test-Feature common.removeEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}
	
	# Clean start menu & taskbar
	if (Test-Feature common.cleanStartAndTaskbar) {
		Write-Host 'Cleaning taskbar & start menu...'
		Invoke-CleanStartAndTaskbar
	}

	# Clean-up start menu and desktop
	if (Test-Feature common.cleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}
