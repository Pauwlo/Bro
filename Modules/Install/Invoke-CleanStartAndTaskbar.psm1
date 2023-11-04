function Invoke-CleanStartAndTaskbar {
	$PreviousLocation = Get-Location

	$TempLayoutPath = 'C:\LayoutModification.xml'
	Get-Asset LayoutModificationXml $TempLayoutPath | Out-Null
	Set-Location C:\
	Import-StartLayout -LayoutPath $TempLayoutPath -MountPath C:

	$KeyPathRelative = 'Software\Policies\Microsoft\Windows\Explorer'

	foreach ($Registry in @('HKLM', 'HKCU')) {
		$KeyPath = "$Registry`:\$KeyPathRelative"

		if (!(Test-Path $KeyPath)) {
			New-Item $KeyPath | Out-Null
		}

		Set-ItemProperty $KeyPath -Name 'LockedStartLayout' -Value 1
		Set-ItemProperty $KeyPath -Name 'StartLayoutFile' -Value $TempLayoutPath
	}

	Stop-Process -Name explorer
	Start-Sleep 3

	foreach ($Registry in @('HKLM', 'HKCU')) {
		$KeyPath = "$Registry`:\$KeyPathRelative"

		Remove-ItemProperty $KeyPath -Name 'LockedStartLayout'
		Remove-ItemProperty $KeyPath -Name 'StartLayoutFile'
	}

	Stop-Process -Name explorer

	Remove-Item $TempLayoutPath
	Set-Location $PreviousLocation
}
