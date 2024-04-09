function Test-InstallSoftware {
	Param(
		[Parameter(Mandatory = $true)]
		$Software
	)

	return $Package -in $Config.winget
}
