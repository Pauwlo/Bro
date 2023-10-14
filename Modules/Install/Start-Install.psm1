function Start-Install {
	Write-Host 'Starting Install...'

	# Rename computer
	if (Test-FeatureEnabled RenameComputer) {
		$ComputerName = Read-ComputerName
	
		if ($env:COMPUTERNAME -ne $ComputerName) {
			Write-Host "Renaming to $ComputerName"
			Rename-Computer -NewName $ComputerName #-WarningAction SilentlyContinue
		} else {
			Write-Host -ForegroundColor Yellow "`nThe computer name is already set to $ComputerName."
			Pause
		}
	}
}