function Test-InstallChocolateyPackage {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)
	
	$Packages = $Config.chocolatey.PSObject.Properties;

	foreach ($Package in $Packages) {
		if ($Package.Name -eq $Name) {
			return $Package.Value -eq $true
		}
	}

	return $false
}
