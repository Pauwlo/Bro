function Test-ChocolateyInstalled {
	$choco = Get-Command -Name choco.exe -ErrorAction SilentlyContinue

	if ($choco) {
		return $true
	}
	
	return $false
}
