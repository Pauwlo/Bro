function Grant-AdministratorPrivileges {

	Param(
		[Parameter(Mandatory = $true)]
		[Management.Automation.InvocationInfo]
		$Invocation
	)

	$IsElevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

	if (!$IsElevated) {
		if ($VerbosePreference -eq 'SilentlyContinue') {
			$CommandLine = '-ExecutionPolicy Bypass -File "' + $Invocation.MyCommand.Path + '" ' + $Invocation.UnboundArguments
		} else {
			$CommandLine = '-ExecutionPolicy Bypass -File "' + $Invocation.MyCommand.Path + '" -Verbose ' + $Invocation.UnboundArguments
		}

		try {
			Start-Process -FilePath powershell -Verb Runas -ArgumentList $CommandLine
		} catch {
			Write-Warning "Bro requires elevated permissions. Please run it as administrator."
		}
		Exit
	}
}
