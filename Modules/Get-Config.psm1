function Get-Config {

	Param(
		[Parameter(Mandatory = $false)]
		[String]
		$FilePath = 'Config.json'
	)

	if (Test-Path $FilePath) {
		try {
			$Config = Get-Content -Path $FilePath | ConvertFrom-Json
			return $Config
		} catch {
			Write-Warning 'An error occured while reading the configuration file specified.'
		}
	}

	if ($global:Config) {
		try {
			$Config | ConvertFrom-Json
			return $Config
		} catch {
			Write-Warning 'An error occured while reading the embedded configuration.'
		}
	}

	try {
		$Config = $DefaultConfig | ConvertFrom-Json
		return $Config
	} catch {
		Write-Warning 'An error occured while reading the default configuration.'
	}
}
