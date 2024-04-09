function Get-Logo {
	$Host.UI.RawUI.WindowTitle = $Config.title
	Clear-Host
	Write-Host $global:Logo
}
