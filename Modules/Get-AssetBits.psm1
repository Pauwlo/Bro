function Get-AssetBits {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Asset,

		[Parameter(Mandatory = $true)]
		[String]
		$OutputPath
	)

	$AssetUrl = $Config.assets.$Asset

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown asset: $Asset"
		return $null
	}

	return Start-BitsTransfer -Source $AssetUrl -Destination $OutputPath
}
