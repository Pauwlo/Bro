function Test-WinGetInstalled {
	$winget = Get-Command -Name winget.exe -ErrorAction SilentlyContinue

	if ($winget) {
		return $true
	}
	
	return $false
}
