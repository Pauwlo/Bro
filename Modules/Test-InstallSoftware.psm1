function Test-InstallSoftware {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)

	$SoftwareNames = $Config.software.PSObject.Properties;

	foreach ($Software in $SoftwareNames) {
		if ($Software.Name -eq $Name) {
			return $Software.Value -eq $true
		}
	}

	return $false
}
