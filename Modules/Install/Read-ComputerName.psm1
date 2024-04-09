function Read-ComputerName {
	$ComputerName = $Config.newComputerName

	if ($null -ne $ComputerName) {
		return $ComputerName
	}

	$ComputerName = Read-Host -Prompt 'Computer name'

	while (($ComputerName.Length -gt 15) -or ($ComputerName -notmatch '^[A-z0-9\-]+$') -or ($ComputerName -match '^[0-9]+$')) {
		
		if ($ComputerName.Length -gt 15) {
			Write-Host -ForegroundColor Yellow 'The computer name is limited to 15 characters.'
		}
		
		if ($ComputerName -notmatch '^[A-z0-9\-]+$') {
			Write-Host -ForegroundColor Yellow 'The computer name contains invalid characters. (Only A-z, 0-9 and -)'
		}
		
		if ($ComputerName -match '^[0-9]+$') {
			Write-Host -ForegroundColor Yellow 'The computer name may not consist entirely of digits.'
		}
	
		Write-Host ""
		$ComputerName = Read-Host -Prompt 'Computer name'
	}

	return $ComputerName
}
