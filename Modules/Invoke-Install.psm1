function Invoke-Install {

	# Rename computer
	if (Test-Feature RenameComputer) {
		Invoke-RenameComputer
	}

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

	# Set user home folder icon
	if (Test-Feature SetUserHomeIcon) {
		Write-Host 'Setting user home folder icon...'
		Set-UserHomeIcon
	}

	# Pin folders to Quick Access
	if (Test-Feature PinFoldersToQuickAccess) {
		Write-Host 'Pinning user folders to Quick Access...'
		Invoke-PinFoldersToQuickAccess
	}

	# Remove Edge shortcut from Desktop
	if (Test-Feature RemoveEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Set wallpaper
	if (Test-Feature SetWallpaper) {
		Write-Host 'Applying wallpaper...'
		Set-Wallpaper
	}

	# Install software
	if (Test-Feature InstallSoftware) {
		Write-Host 'Installing software...'
		Install-Software | Out-Null
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

	# Synchronize clock
	if (Test-Feature SynchronizeClock) {
		Write-Host 'Synchronizing clock...'
		Invoke-SynchronizeClock
	}

	Write-Host 'Done!'
}
