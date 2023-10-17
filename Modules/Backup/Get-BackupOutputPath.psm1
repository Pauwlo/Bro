function Get-BackupOutputPath {
	$Now = (Get-Date).ToString("yyyy-MM-dd HH-mm-ss")
	$OutputPath = "$env:TMP\Backup $Now"

	$i = 0
	while (Test-Path $OutputPath) {
		$i++
		$OutputPath = "$Desktop\Backup $Now ($i)"
	}

	New-Item $OutputPath -ItemType Directory | Out-Null
	Write-Host "Backup folder created at $OutputPath"

	return $OutputPath
}
