function Invoke-PatchHosts {
	Add-MpPreference -ExclusionPath 'C:\Windows\System32\drivers\etc\hosts'

	$HostsPath = "$env:WINDIR\System32\drivers\etc\hosts"
	$Hosts = Get-Content $HostsPath
	$NewHosts = [System.Collections.Generic.List[string]]::new()

	# Find and remove previous Bro patches
	$Ignore = $false
	for ($i = 0; $i -lt $Hosts.Length; $i++) {
		$Line = $Hosts[$i]
		
		if ($Line -eq '#< Added by Bro (https://pauw.io/bro.git)') {
			$Ignore = $true
		} elseif ($Line -eq '#> Added by Bro (https://pauw.io/bro.git)') {
			$Ignore = $false
		} else {
			if ($Ignore) {
				continue;
			}

			$NewHosts.Add($Line)
		}
	}

	if (! $Ignore) {
		Set-Content -Value $NewHosts -Path $HostsPath
	} else {
		Write-Warning "It seems that the hosts file has already been patched in the past. Please check for duplicates at $HostsPath"
	}

	Get-Asset Hosts | Add-Content $HostsPath
}
