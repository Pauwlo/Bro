function Get-RegistryAsset {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Asset,

		[Parameter()]
		[String]
		$OutputPath
	)

	$AssetUrl = $Config.assets.registry.$Asset

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown registry asset: $Asset"
		return $null
	}

	if ($null -ne $OutputPath) {
		Invoke-WebRequest $AssetUrl -OutFile $OutputPath -UseBasicParsing
	}

	return Invoke-WebRequest $AssetUrl -UseBasicParsing
}
