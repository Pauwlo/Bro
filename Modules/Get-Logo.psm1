function Get-Logo {
	$Host.UI.RawUI.WindowTitle = $Config.misc.windowTitle

	if ($Config.misc.clearTerminalOnLaunch) {
	    Clear-Host
	}

	if ($Config.misc.showLogo) {
	    Write-Host $Script:Logo
	}

	if ($Config.misc.showBuildDate) {
	    Write-Host "Build Date: $Script:BuildDate ($Script:BuildNumber)"
	}
}
