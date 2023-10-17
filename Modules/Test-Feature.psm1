function Test-Feature {
	Param(
        [Parameter(Mandatory = $true)]
        $Feature
    )

	return $Config['Features'][$Feature] -eq $true
}