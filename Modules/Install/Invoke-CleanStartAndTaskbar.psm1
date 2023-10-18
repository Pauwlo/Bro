function Invoke-CleanStartAndTaskbar {
	$PreviousLocation = Get-Location

	$TempLayoutPath = 'C:\LayoutModification.xml'
	Get-Asset LayoutModificationXml $TempLayoutPath | Out-Null
	Set-Location C:\
	Import-StartLayout -LayoutPath $TempLayoutPath -MountPath C:

	foreach ($Registry in @('HKLM', 'HKCU')) {
		$KeyPath = $Registry + ':\Software\Policies\Microsoft\Windows\Explorer'

		if (!(Test-Path $KeyPath)) {
			New-Item $KeyPath | Out-Null
		}

		Set-ItemProperty $KeyPath -Name 'LockedStartLayout' -Value 1
		Set-ItemProperty $KeyPath -Name 'StartLayoutFile' -Value $TempLayoutPath
	}

	Stop-Process -Name explorer
	Start-Sleep 3

	foreach ($Registry in @('HKLM', 'HKCU')) {
		$KeyPath = $Registry + ':\Software\Policies\Microsoft\Windows\Explorer'
		Remove-Item $KeyPath
	}

	Remove-Item $TempLayoutPath
	Set-Location $PreviousLocation
}
