function Invoke-RenameComputer {
	$ComputerName = Read-ComputerName
	
	if ($env:COMPUTERNAME -ne $ComputerName) {
		Write-Host "Computer will be renamed to $ComputerName upon restart."
		Rename-Computer -NewName $ComputerName -WarningAction SilentlyContinue
	} else {
		Write-Host -ForegroundColor Yellow "`nThe computer name is already set to $ComputerName."
	}
}
