function Install-Chocolatey {
	Set-ExecutionPolicy Bypass -Scope Process -Force
	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *>&1 | Out-Null

	$DocumentsPath = [Environment]::GetFolderPath('MyDocuments')
	$PowerShellFolder = Get-Item "$DocumentsPath\WindowsPowerShell" -ErrorAction SilentlyContinue

	if ($PowerShellFolder) {
		$PowerShellFolder.Attributes += 'Hidden'
	}

	choco feature enable -n=useRememberedArgumentsForUpgrades
}
