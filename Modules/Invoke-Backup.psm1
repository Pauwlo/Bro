function Invoke-Backup {

	$OutputPath = Get-BackupOutputPath
	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	# Create a temporary shortcut to the backup location on the desktop
	if (Test-Feature CreateTemporaryBackupShortcut) {
		New-Shortcut "$DesktopPath\Backup.lnk" $OutputPath
	}
	
	# Backup user folders
	if (Test-Feature BackupUserFolders) {
		Invoke-BackupUserFolders $OutputPath
	}

	Remove-Item "$DesktopPath\Backup.lnk" -ErrorAction SilentlyContinue

	Write-Host 'Done!'
}
