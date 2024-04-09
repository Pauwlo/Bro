function Test-InstallChocolateyPackage {
	Param(
		[Parameter(Mandatory = $true)]
		$Package
	)
	
	return $Package -in $Config.chocolatey
}
