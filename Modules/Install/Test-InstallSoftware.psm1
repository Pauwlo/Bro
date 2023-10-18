function Test-InstallSoftware {
	Param(
		[Parameter(Mandatory = $true)]
		$Software
	)

	return $Config['Software'][$Software] -eq $true
}
