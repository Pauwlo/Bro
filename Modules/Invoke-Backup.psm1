function Invoke-Backup {

	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	# Create a temporary backup location
	$Now = (Get-Date).ToString("yyyy-MM-dd HH-mm-ss")
	$Name = "Backup $Now"
	$OutputPath = Get-BackupOutputPath $Name

	# Create a temporary shortcut to the backup location on the desktop
	if (Test-Feature backup.createTemporaryBackupShortcut) {
		$ShortcutName = 'Backup'

		$i = 0
		while (Test-Path "$DesktopPath\$ShortcutName.lnk") {
			$i++
			$ShortcutName = "Backup ($i)"
		}

		New-Shortcut "$DesktopPath\$ShortcutName.lnk" $OutputPath
	}
	
	# Backup user folders
	if (Test-Feature backup.backupUserFolders) {
		Invoke-BackupUserFolders $OutputPath
	}

	# Remove temporary shortcuts
	if (Test-Feature backup.createTemporaryBackupShortcut) {
		Remove-Item "$DesktopPath\$ShortcutName.lnk" -ErrorAction SilentlyContinue
		Remove-Item "$OutputPath\Desktop\$ShortcutName.lnk" -ErrorAction SilentlyContinue
	}

	# Take a screenshot of the desktop
	if (Test-Feature backup.takeScreenshot) {
		Invoke-TakeScreenshot $OutputPath
	}

	# Make a ZIP of the backup data and put it on the desktop
	Compress-Archive $OutputPath "$DesktopPath\$Name.zip"

	# Delete the backup data
	Remove-Item $OutputPath -Force -Recurse

	Write-Host 'Done!'
}
