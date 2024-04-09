function Get-Asset {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Asset,

		[Parameter()]
		[String]
		$OutputPath
	)

	$AssetUrl = $Config.assets.$Asset

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown asset: $Asset"
		return $null
	}

	if ($null -ne $OutputPath) {
		Invoke-WebRequest $AssetUrl -OutFile $OutputPath -UseBasicParsing
	}

	return Invoke-WebRequest $AssetUrl -UseBasicParsing
}
