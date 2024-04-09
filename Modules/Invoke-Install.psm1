function Invoke-Install {
	$ProgressPreference = 'SilentlyContinue'

	# Rename computer
	if (Test-Feature install.renameComputer) {
		Invoke-RenameComputer
	}

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

	# Set user home folder icon
	if (Test-Feature install.setUserHomeIcon) {
		Write-Host 'Setting user home folder icon...'
		Set-UserHomeIcon
	}

	# Pin folders to Quick Access
	if (Test-Feature install.pinFoldersToQuickAccess) {
		Write-Host 'Pinning user folders to Quick Access...'
		Invoke-PinFoldersToQuickAccess
	}

	# Remove Edge shortcut from Desktop
	if (Test-Feature common.removeEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Set wallpaper
	if (Test-Feature install.setWallpaper) {
		Write-Host 'Applying wallpaper...'
		Set-Wallpaper
	}

	# Install software
	if (Test-Feature install.installSoftware) {
		Write-Host 'Installing software...'
		Install-Software | Out-Null
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

	# Synchronize clock
	if (Test-Feature common.synchronizeClock) {
		Write-Host 'Synchronizing clock...'
		Invoke-SynchronizeClock
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}
