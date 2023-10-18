function Invoke-PatchRegistry {
	$CommunicationsKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Communications'
	if (Test-Path "HKLM:\$CommunicationsKey") {
		Grant-KeyPermissions 'HKLM' $CommunicationsKey
	}
	
	$FilePath = "$env:TMP\Bro_Tweaks.reg"
	Get-Asset RegistryFile $FilePath | Out-Null
	reg import $FilePath 2>&1 | Out-Null
	Remove-Item $FilePath

	Stop-Process -Name explorer
}
