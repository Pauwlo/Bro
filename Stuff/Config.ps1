$Config = @{
	Features = @{
		BlockMicrosoftTelemetry = $true
		CleanTaskbarAndStartMenu = $true
		CreatePostInstallShortcut = $true
		DisableFocusAssistRules = $true
		ImportCertificates = $true
		InstallFonts = $true
		PatchHosts = $true
		PatchRegistry = $true
		PinFoldersToQuickAccess = $true
		RemoveEdgeShortcutFromDesktop = $true
		RenameComputer = $true
		SetUserHomeFolderIcon = $true
		SetWallpaper = $true
		UninstallOneDrive = $true
		UninstallUselessApps = $true
	}
	Input = @{
		NewComputerName = $null
	}
}
