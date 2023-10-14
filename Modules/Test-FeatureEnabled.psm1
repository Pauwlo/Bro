function Test-FeatureEnabled {
	Param(
        [Parameter(Mandatory = $true)]
        $Feature
    )

	return $Config['Features'][$Feature] -eq $true
}