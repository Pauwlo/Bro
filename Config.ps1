$Config = @{
	Features = @{
		BackupUserFolders = $true
		BlockMicrosoftTelemetry = $true
		CleanShortcuts = $true
		CleanStartAndTaskbar = $true
		CreateTemporaryBackupShortcut = $true
		DisableFocusAssist = $true
		ImportCertificates = $false
		InstallFonts = $false
		InstallSoftware = $true
		PatchHosts = $true
		PatchRegistry = $true
		PinFoldersToQuickAccess = $true
		RemoveEdgeShortcut = $true
		RenameComputer = $true
		SetUserHomeIcon = $true
		SetWallpaper = $true
		UninstallOneDrive = $true
		UninstallUselessApps = $true
	}

	Input = @{
		NewComputerName = $null
	}

	Software = @{
		Chocolatey = $true # required for below
		WinGet = $true

		Firefox = $false
		VLC = $false
		NotepadPlusPlus = $false
		'7Zip' = $false
	}

	ChocolateyPackages = @{
		Firefox = $true
		VLC = $true
		NotepadPlusPlus = $true
		'7Zip' = $true
	}

	UselessApps = @(
		'Clipchamp.Clipchamp'
		'MicrosoftTeams'
		'MicrosoftWindows.Client.WebExperience' # Widgets
		'Microsoft.549981C3F5F10'
		'Microsoft.Advertising.Xaml'
		'Microsoft.BingNews'
		#'Microsoft.BingWeather' # MSN Weather
		'Microsoft.GamingApp'
		'Microsoft.GetHelp'
		'Microsoft.Getstarted'
		'Microsoft.Messaging'
		'Microsoft.Microsoft3DViewer'
		'Microsoft.MicrosoftOfficeHub'
		'Microsoft.MicrosoftSolitaireCollection'
		'Microsoft.MixedReality.Portal'
		'Microsoft.MSPaint'
		'Microsoft.Office.OneNote'
		'Microsoft.OneConnect'
		'Microsoft.People'
		'Microsoft.PowerAutomateDesktop'
		'Microsoft.Print3D'
		'Microsoft.SkypeApp'
		'Microsoft.Todos'
		'Microsoft.Wallet'
		#'microsoft.windowscommunicationsapps' # Mail and Calendar
		'Microsoft.WindowsFeedbackHub'
		'Microsoft.WindowsMaps'
		'Microsoft.Xbox.TCUI'
		'Microsoft.XboxApp'
		'Microsoft.XboxGameOverlay'
		'Microsoft.XboxGamingOverlay'
		'Microsoft.XboxIdentityProvider'
		'Microsoft.XboxSpeechToTextOverlay'
		'Microsoft.YourPhone'
		'Microsoft.ZuneMusic'
		'Microsoft.ZuneVideo'
		'MicrosoftCorporationII.MicrosoftFamily'
		'MicrosoftCorporationII.QuickAssist'
	)

	Assets = @{
		Certificates = ''
		Fonts = ''
		Hosts = 'https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/Hosts.txt'
		LayoutModificationXml = 'https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/LayoutModification.xml'
		RegistryFile = 'https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/Tweaks.reg'
		Wallpaper = 'https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/Gradient.jpg'
	}

	BackupUserFolders = @{
		Desktop = $true
		Downloads = $true
		Documents = $true
		Pictures = $true
		Music = $true
		Videos = $true
	}
}
