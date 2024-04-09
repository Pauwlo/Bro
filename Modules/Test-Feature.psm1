function Test-Feature {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Feature
	)

	$Array = $Feature.Split('.')
	$Group = $Array[0]
	$Name = $Array[1]

	if (! $Config.features.$Group) {
		Write-Warning "Unknown feature group: $Group"
	} elseif (! $Config.features.$Group.$Name) {
		Write-Warning "Unknown feature for group $Group`: $Name"
	}

	return $Config.features.$Group.$Name -eq $true
}
