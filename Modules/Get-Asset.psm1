function Get-Asset {
	Param(
        [Parameter(Mandatory = $true)]
        $Asset,
		$OutputPath
    )

	$AssetUrl = $Config['Assets'][$Asset]

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown asset: $Asset"
		return $null
	}

	if ($null -ne $OutputPath) {
		Invoke-WebRequest $AssetUrl -OutFile $OutputPath -UseBasicParsing
	}

	return Invoke-WebRequest $AssetUrl -UseBasicParsing
}
