function Invoke-Debloat {
	$ProgressPreference = 'SilentlyContinue'

	# Block Microsoft telemetry
	if (Test-Feature BlockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Patch Hosts file
	if (Test-Feature PatchHosts) {
		Write-Host 'Patching hosts... (Windows Defender may false positive)'
		Invoke-PatchHosts
	}

	# Patch registry
	if (Test-Feature PatchRegistry) {
		Write-Host 'Patching registry...'
		Invoke-PatchRegistry
	}

	# Disable Focus Assist automatic rules
	if (Test-Feature DisableFocusAssist) {
		Write-Host 'Disabling Focus Assist automatic rules...'
		Disable-FocusAssist
	}

	# Uninstall useless apps
	if (Test-Feature UninstallUselessApps) {
		Write-Host 'Uninstalling useless apps...'
		Remove-UselessApps
	}

	# Uninstall OneDrive
	if (Test-Feature UninstallOneDrive) {
		Write-Host 'Uninstalling OneDrive...'
		Remove-OneDrive
	}
	
	# Remove Edge shortcut from Desktop
	if (Test-Feature RemoveEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}
	
	# Clean start menu & taskbar
	if (Test-Feature CleanStartAndTaskbar) {
		Write-Host 'Cleaning taskbar & start menu...'
		Invoke-CleanStartAndTaskbar
	}

	# Clean-up start menu and desktop
	if (Test-Feature CleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}
