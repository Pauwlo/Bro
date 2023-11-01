function Test-InstallChocolateyPackage {
	Param(
		[Parameter(Mandatory = $true)]
		$Package
	)

	return $Config['ChocolateyPackages'][$Package] -eq $true
}
