function Get-BackupOutputPath {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)

	$OutputPath = "$env:TMP\$Name"

	$i = 0
	while (Test-Path $OutputPath) {
		$i++
		$OutputPath = "$env:TMP\$Name ($i)"
	}

	New-Item $OutputPath -ItemType Directory | Out-Null
	Write-Host "Backup folder created at $OutputPath"

	return $OutputPath
}
