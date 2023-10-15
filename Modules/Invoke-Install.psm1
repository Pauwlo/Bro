function Invoke-Install {

	# Rename computer
	if (Test-FeatureEnabled RenameComputer) {
		Invoke-RenameComputer
	}

	# Block Microsoft telemetry
	if (Test-FeatureEnabled BlockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Patch Hosts file
	if (Test-FeatureEnabled PatchHosts) {
		Write-Host 'Patching hosts... (Windows Defender may false positive)'
		Invoke-PatchHosts
	}

	# Patch registry
	if (Test-FeatureEnabled PatchRegistry) {
		Write-Host 'Patching registry...'
		Invoke-PatchRegistry
	}

	# Disable Focus Assist automatic rules
	if (Test-FeatureEnabled DisableFocusAssist) {
		Write-Host 'Disabling Focus Assist automatic rules...'
		Disable-FocusAssist
	}

	# Uninstall useless apps
	if (Test-FeatureEnabled UninstallUselessApps) {
		Write-Host 'Uninstalling useless apps...'
		Remove-UselessApps
	}

	# Uninstall OneDrive
	if (Test-FeatureEnabled UninstallOneDrive) {
		Write-Host 'Uninstalling OneDrive...'
		Remove-OneDrive
	}

	# Import certificates
	if (Test-FeatureEnabled ImportCertificates) {
		Write-Host 'Importing certificates...'
	}

	# Install fonts
	if (Test-FeatureEnabled InstallFonts) {
		Write-Host 'Installing fonts...'
	}

	# Set user home folder icon
	if (Test-FeatureEnabled SetUserHomeIcon) {
		Write-Host 'Setting user home folder icon...'
		Set-UserHomeIcon
	}

	# Pin folders to Quick Access
	if (Test-FeatureEnabled PinFoldersToQuickAccess) {
		Write-Host 'Pinning user folders to Quick Access...'
		Invoke-PinFoldersToQuickAccess
	}

	# Remove Edge shortcut from Desktop
	if (Test-FeatureEnabled RemoveEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Set wallpaper
	if (Test-FeatureEnabled SetWallpaper) {
		Write-Host 'Applying wallpaper...'
		Set-Wallpaper
	}

	# Install software
	if (Test-FeatureEnabled InstallSoftware) {
		Write-Host 'Installing software...'
		Install-Software | Out-Null
	}

	# Clean start menu & taskbar
	if (Test-FeatureEnabled CleanStartAndTaskbar) {
		Write-Host 'Cleaning taskbar & start menu...'
		Invoke-CleanStartAndTaskbar
	}

	# Clean-up start menu and desktop
	if (Test-FeatureEnabled CleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	# Synchronize clock
	if (Test-FeatureEnabled SynchronizeClock) {
		Write-Host 'Synchronizing clock...'
		Invoke-SynchronizeClock
	}

	Write-Host 'Done!'
}
