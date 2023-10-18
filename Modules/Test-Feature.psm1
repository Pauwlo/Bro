function Test-Feature {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Feature
	)

	return $Config['Features'][$Feature] -eq $true
}
