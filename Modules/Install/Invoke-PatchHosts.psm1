function Invoke-PatchHosts {
	Add-MpPreference -ExclusionPath 'C:\Windows\System32\drivers\etc\hosts'

    $HostsPath = "$env:WINDIR\System32\drivers\etc\hosts"

    if ((Get-Content $HostsPath) -match 'telemetry') {
        Write-Warning "The hosts file appears to be patched already. Please check for duplicates at $HostsPath"
    }

    Get-Asset Hosts | Add-Content $HostsPath
}
