# From https://stackoverflow.com/questions/12044432/how-do-i-take-ownership-of-a-registry-key-via-powershell
function Grant-KeyPermissions {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$RootKey,

		[Parameter(Mandatory = $true)]
		[String]
		$Key,

		[Parameter()]
		[System.Security.Principal.SecurityIdentifier]
		$Sid = 'S-1-5-32-544',

		[Parameter()]
		[bool]
		$Recurse = $false
	)

	switch -regex ($RootKey) {
		'HKCU|HKEY_CURRENT_USER'	{ $RootKey = 'CurrentUser' }
		'HKLM|HKEY_LOCAL_MACHINE'	{ $RootKey = 'LocalMachine' }
		'HKCR|HKEY_CLASSES_ROOT'	{ $RootKey = 'ClassesRoot' }
		'HKCC|HKEY_CURRENT_CONFIG'	{ $RootKey = 'CurrentConfig' }
		'HKU|HKEY_USERS'			{ $RootKey = 'Users' }
	}

	### Step 1 - escalate current process's privilege
	# get SeTakeOwnership, SeBackup and SeRestore privileges before executes next lines, script needs Admin privilege
	$import = '[DllImport("ntdll.dll")] public static extern int RtlAdjustPrivilege(ulong a, bool b, bool c, ref bool d);'
	$ntdll = Add-Type -Member $import -Name NtDll -PassThru
	$privileges = @{ SeTakeOwnership = 9; SeBackup = 17; SeRestore = 18 }
	foreach ($i in $privileges.Values) {
		$null = $ntdll::RtlAdjustPrivilege($i, 1, 0, [ref]0)
	}

	function Take-KeyPermissions {

		Param(
			[Parameter(Mandatory = $true)]
			[String]
			$RootKey,

			[Parameter(Mandatory = $true)]
			[String]
			$Key,

			[Parameter(Mandatory = $true)]
			[String]
			$Sid,

			[Parameter()]
			[bool]
			$Recurse = $false,

			[Parameter()]
			[int]
			$RecurseLevel = 0
		)

		### Step 2 - get ownerships of key - it works only for current key
		$regKey = [Microsoft.Win32.Registry]::$RootKey.OpenSubKey($Key, 'ReadWriteSubTree', 'TakeOwnership')
		$acl = New-Object System.Security.AccessControl.RegistrySecurity
		$acl.SetOwner($Sid)
		$regKey.SetAccessControl($acl)

		### Step 3 - enable inheritance of permissions (not ownership) for current key from parent
		$acl.SetAccessRuleProtection($false, $false)
		$regKey.SetAccessControl($acl)

		### Step 4 - only for top-level key, change permissions for current key and propagate it for subkeys
		# to enable propagations for subkeys, it needs to execute Steps 2-3 for each subkey (Step 5)
		if ($RecurseLevel -eq 0) {
			$regKey = $regKey.OpenSubKey('', 'ReadWriteSubTree', 'ChangePermissions')
			$rule = New-Object System.Security.AccessControl.RegistryAccessRule($Sid, 'FullControl', 'ContainerInherit', 'None', 'Allow')
			$acl.ResetAccessRule($rule)
			$regKey.SetAccessControl($acl)
		}

		### Step 5 - recursively repeat steps 2-5 for subkeys
		if ($Recurse) {
			foreach ($subKey in $regKey.OpenSubKey('').GetSubKeyNames()) {
				Take-KeyPermissions $RootKey ($Key + '\' + $subKey) $Sid $Recurse ($RecurseLevel + 1)
			}
		}
	}

	Take-KeyPermissions $RootKey $Key $Sid $Recurse
}
