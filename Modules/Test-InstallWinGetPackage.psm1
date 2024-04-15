function Test-InstallWinGetPackage {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)
	
	$Packages = $Config.winget.PSObject.Properties;

	foreach ($Package in $Packages) {
		if ($Package.Name -eq $Name) {
			return $Package.Value -eq $true
		}
	}

	return $false
}
