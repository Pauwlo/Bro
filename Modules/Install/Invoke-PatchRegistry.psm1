function Invoke-PatchRegistry {
	$CommunicationsKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Communications'
	if (Test-Path "HKLM:\$CommunicationsKey") {
		Grant-KeyPermissions 'HKLM' $CommunicationsKey
	}
	
	$FilePath = "$env:TMP\Bro_Tweaks.reg"
	Get-Asset RegistryFile $FilePath | Out-Null
	reg import $FilePath 2>&1 | Out-Null

	$ScriptFilePath = "$env:TMP\Bro (re-patch registry on reboot).ps1"

	Write-Output "reg import '$FilePath' 2>&1" | Out-File $ScriptFilePath -Encoding ascii
	Write-Output "Remove-Item '$FilePath'" | Out-File $ScriptFilePath -Append -Encoding ascii
	Write-Output "Remove-Item '$ScriptFilePath'" | Out-File $ScriptFilePath -Append -Encoding ascii
	Write-Output "Unregister-ScheduledTask 'Re-patch registry' -Confirm:`$false" | Out-File $ScriptFilePath -Append -Encoding ascii

	$A = New-ScheduledTaskAction -Execute 'powershell' -Argument "-ExecutionPolicy Bypass -File `"$ScriptFilePath`""
	$T = New-ScheduledTaskTrigger -AtLogon
	$P = New-ScheduledTaskPrincipal -UserId SYSTEM -RunLevel Highest
	$Task = New-ScheduledTask -Action $A -Trigger $T -Principal $P
	Register-ScheduledTask 'Bro\Re-patch registry' -InputObject $Task -Force | Out-Null

	Stop-Process -Name explorer
}
