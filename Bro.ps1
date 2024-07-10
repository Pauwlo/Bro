# This file was automatically generated on 07/10/2024 01:33:33.
# <config placeholder>
[CmdletBinding()] param()

$global:Logo = @'
`7MM"""Yp,
  MM    Yb
  MM    dP `7Mb,od8 ,pW"Wq.
  MM"""bg.   MM' "'6W'   `Wb
  MM    `Y   MM    8M     M8
  MM    ,9   MM    YA.   ,A9
.JMMmmmd9  .JMML.   `Ybmd9'

'@

$DefaultConfig = @'
{
	"title": "Bro",
	"features": {
		"common": {
			"blockMicrosoftTelemetry": true,
			"cleanShortcuts": true,
			"cleanStartAndTaskbar": true,
			"disableFocusAssist": true,
			"hideRecentFilesInExplorer": true,
			"importCertificates": false,
			"openExplorerWithThisPC": true,
			"patchHosts": true,
			"patchRegistry": true,
			"removeEdgeShortcut": true,
			"synchronizeClock": true,
			"uninstallUselessApps": true
		},
		"backup": {
			"backupUserFolders": true,
			"createTemporaryBackupShortcut": true,
			"takeScreenshot": true
		},
		"install": {
			"installChocolatey": true,
			"installChocolateyPackages": true,
			"installFonts": false,
			"installSoftware": true,
			"installWinGet": false,
			"installWinGetPackages": false,
			"pinFoldersToQuickAccess": true,
			"renameComputer": true,
			"setUserHomeIcon": true,
			"setWallpaper": true,
			"uninstallOneDrive": true
		},
		"update": {
			"updateChocolateyPackages": true,
			"updateSoftware": true,
			"updateWinGetPackages": false
		}
	},

	"assets": {
		"certificates": "",
		"fonts": "",
		"hosts": "https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/Hosts.txt",
		"layoutModificationXml": "https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/LayoutModification.xml",
		"registry": {
			"dontShowRecentFiles": "https://raw.githubusercontent.com/Pauwlo/Bro/main/Registry/Don't show recently used files and folders in Explorer.reg",
			"openExplorerWithThisPC": "https://raw.githubusercontent.com/Pauwlo/Bro/main/Registry/Open Explorer with This PC instead of Quick Access.reg",
			"tweaks": "https://raw.githubusercontent.com/Pauwlo/Bro/main/Registry/Tweaks.reg"
		},
		"wallpaper": "https://raw.githubusercontent.com/Pauwlo/Bro/main/Stuff/Gradient.jpg"
	},

	"newComputerName": null,

	"backupFolders": {
		"desktop": true,
		"downloads": true,
		"documents": true,
		"pictures": true,
		"music": true,
		"videos": true
	},

	"chocolatey": {
		"Firefox": true,
		"VLC": true,
		"Notepad++": true,
		"7-Zip": true
	},

	"winget": {
		"Firefox": false,
		"VLC": false,
		"Notepad++": false,
		"7-Zip": false
	},

	"uselessApps": [
		"Clipchamp.Clipchamp",
		"MicrosoftTeams",
		"MicrosoftWindows.Client.WebExperience",
		"Microsoft.549981C3F5F10",
		"Microsoft.Advertising.Xaml",
		"Microsoft.BingNews",
		"Microsoft.GamingApp",
		"Microsoft.GetHelp",
		"Microsoft.Getstarted",
		"Microsoft.Messaging",
		"Microsoft.Microsoft3DViewer",
		"Microsoft.MicrosoftOfficeHub",
		"Microsoft.MicrosoftSolitaireCollection",
		"Microsoft.MixedReality.Portal",
		"Microsoft.MSPaint",
		"Microsoft.Office.OneNote",
		"Microsoft.OneConnect",
		"Microsoft.People",
		"Microsoft.PowerAutomateDesktop",
		"Microsoft.Print3D",
		"Microsoft.SkypeApp",
		"Microsoft.Todos",
		"Microsoft.Wallet",
		"Microsoft.WindowsFeedbackHub",
		"Microsoft.WindowsMaps",
		"Microsoft.Xbox.TCUI",
		"Microsoft.XboxApp",
		"Microsoft.XboxGameOverlay",
		"Microsoft.XboxGamingOverlay",
		"Microsoft.XboxIdentityProvider",
		"Microsoft.XboxSpeechToTextOverlay",
		"Microsoft.YourPhone",
		"Microsoft.ZuneMusic",
		"Microsoft.ZuneVideo",
		"MicrosoftCorporationII.MicrosoftFamily",
		"MicrosoftCorporationII.QuickAssist"
	]
}
'@

function Get-Asset {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Asset,

		[Parameter()]
		[String]
		$OutputPath
	)

	$AssetUrl = $Config.assets.$Asset

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown asset: $Asset"
		return $null
	}

	if ($null -ne $OutputPath) {
		return Invoke-WebRequest $AssetUrl -OutFile $OutputPath -UseBasicParsing
	}

	return Invoke-WebRequest $AssetUrl -UseBasicParsing
}

function Get-AssetBits {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Asset,

		[Parameter(Mandatory = $true)]
		[String]
		$OutputPath
	)

	$AssetUrl = $Config.assets.$Asset

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown asset: $Asset"
		return $null
	}

	return Start-BitsTransfer -Source $AssetUrl -Destination $OutputPath
}

function Get-Config {

	Param(
		[Parameter(Mandatory = $false)]
		[String]
		$FilePath = 'Config.json'
	)

	if (Test-Path $FilePath) {
		try {
			$Config = Get-Content -Path $FilePath | ConvertFrom-Json
			return $Config
		} catch {
			Write-Warning 'An error occured while reading the configuration file specified.'
		}
	}

	if ($global:Config) {
		try {
			$Config | ConvertFrom-Json
			return $Config
		} catch {
			Write-Warning 'An error occured while reading the embedded configuration.'
		}
	}

	try {
		$Config = $DefaultConfig | ConvertFrom-Json
		return $Config
	} catch {
		Write-Warning 'An error occured while reading the default configuration.'
	}
}

function Get-Logo {
	$Host.UI.RawUI.WindowTitle = $Config.title
	Clear-Host
	Write-Host $global:Logo
}

function Get-Menu {
	$Prompt = 'Do you want to [D]ebloat, [I]nstall, [U]pdate, [B]ackup or [Q]uit?'
	Write-Host "Hi. $Prompt"

	$Selection = [System.Console]::ReadKey($true)

	while ($Selection.KeyChar -notin @('b', 'd', 'i', 'q', 'u')) {
		Write-Host "No. $Prompt"
		$Selection = [System.Console]::ReadKey($true)
	}

	switch ($Selection.KeyChar) {
		b { return 0 }
		d { return 1 }
		i { return 2 }
		u { return 3 }
		q { return 9 }
	}
}

function Get-RegistryAsset {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Asset,

		[Parameter()]
		[String]
		$OutputPath
	)

	$AssetUrl = $Config.assets.registry.$Asset

	if ($null -eq $AssetUrl) {
		Write-Warning "Unknown registry asset: $Asset"
		return $null
	}

	if ($null -ne $OutputPath) {
		Invoke-WebRequest $AssetUrl -OutFile $OutputPath -UseBasicParsing
	}

	return Invoke-WebRequest $AssetUrl -UseBasicParsing
}

function Grant-AdministratorPrivileges {

	Param(
		[Parameter(Mandatory = $true)]
		[Management.Automation.InvocationInfo]
		$Invocation
	)

	$IsElevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

	if (!$IsElevated) {
		if ($VerbosePreference -eq 'SilentlyContinue') {
			$CommandLine = '-ExecutionPolicy Bypass -File "' + $Invocation.MyCommand.Path + '" ' + $Invocation.UnboundArguments
		} else {
			$CommandLine = '-ExecutionPolicy Bypass -File "' + $Invocation.MyCommand.Path + '" -Verbose ' + $Invocation.UnboundArguments
		}

		try {
			Start-Process -FilePath powershell -Verb Runas -ArgumentList $CommandLine
		} catch {
			Write-Warning "Bro requires elevated permissions. Please run it as administrator."
		}
		Exit
	}
}

# From https://stackoverflow.com/questions/12044432/how-do-i-take-ownership-of-a-registry-key-via-powershell
function Grant-KeyPermissions {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$RootKey,

		[Parameter(Mandatory = $true)]
		[String]
		$Key,

		[Parameter()]
		[System.Security.Principal.SecurityIdentifier]
		$Sid = 'S-1-5-32-544',

		[Parameter()]
		[bool]
		$Recurse = $false
	)

	switch -regex ($RootKey) {
		'HKCU|HKEY_CURRENT_USER'	{ $RootKey = 'CurrentUser' }
		'HKLM|HKEY_LOCAL_MACHINE'	{ $RootKey = 'LocalMachine' }
		'HKCR|HKEY_CLASSES_ROOT'	{ $RootKey = 'ClassesRoot' }
		'HKCC|HKEY_CURRENT_CONFIG'	{ $RootKey = 'CurrentConfig' }
		'HKU|HKEY_USERS'			{ $RootKey = 'Users' }
	}

	### Step 1 - escalate current process's privilege
	# get SeTakeOwnership, SeBackup and SeRestore privileges before executes next lines, script needs Admin privilege
	$import = '[DllImport("ntdll.dll")] public static extern int RtlAdjustPrivilege(ulong a, bool b, bool c, ref bool d);'
	$ntdll = Add-Type -Member $import -Name NtDll -PassThru
	$privileges = @{ SeTakeOwnership = 9; SeBackup = 17; SeRestore = 18 }
	foreach ($i in $privileges.Values) {
		$null = $ntdll::RtlAdjustPrivilege($i, 1, 0, [ref]0)
	}

	function Take-KeyPermissions {

		Param(
			[Parameter(Mandatory = $true)]
			[String]
			$RootKey,

			[Parameter(Mandatory = $true)]
			[String]
			$Key,

			[Parameter(Mandatory = $true)]
			[System.Security.Principal.SecurityIdentifier]
			$Sid,

			[Parameter()]
			[bool]
			$Recurse = $false,

			[Parameter()]
			[int]
			$RecurseLevel = 0
		)

		### Step 2 - get ownerships of key - it works only for current key
		$regKey = [Microsoft.Win32.Registry]::$RootKey.OpenSubKey($Key, 'ReadWriteSubTree', 'TakeOwnership')
		$acl = New-Object System.Security.AccessControl.RegistrySecurity
		$acl.SetOwner($Sid)
		$regKey.SetAccessControl($acl)

		### Step 3 - enable inheritance of permissions (not ownership) for current key from parent
		$acl.SetAccessRuleProtection($false, $false)
		$regKey.SetAccessControl($acl)

		### Step 4 - only for top-level key, change permissions for current key and propagate it for subkeys
		# to enable propagations for subkeys, it needs to execute Steps 2-3 for each subkey (Step 5)
		if ($RecurseLevel -eq 0) {
			$regKey = $regKey.OpenSubKey('', 'ReadWriteSubTree', 'ChangePermissions')
			$rule = New-Object System.Security.AccessControl.RegistryAccessRule($Sid, 'FullControl', 'ContainerInherit', 'None', 'Allow')
			$acl.ResetAccessRule($rule)
			$regKey.SetAccessControl($acl)
		}

		### Step 5 - recursively repeat steps 2-5 for subkeys
		if ($Recurse) {
			foreach ($subKey in $regKey.OpenSubKey('').GetSubKeyNames()) {
				Take-KeyPermissions $RootKey ($Key + '\' + $subKey) $Sid $Recurse ($RecurseLevel + 1)
			}
		}
	}

	Take-KeyPermissions $RootKey $Key $Sid $Recurse
}

function Invoke-Backup {

	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	# Create a temporary backup location
	$Now = (Get-Date).ToString("yyyy-MM-dd HH-mm-ss")
	$Name = "Backup $Now"
	$OutputPath = Get-BackupOutputPath $Name

	# Create a temporary shortcut to the backup location on the desktop
	if (Test-Feature backup.createTemporaryBackupShortcut) {
		$ShortcutName = 'Backup'

		$i = 0
		while (Test-Path "$DesktopPath\$ShortcutName.lnk") {
			$i++
			$ShortcutName = "Backup ($i)"
		}

		New-Shortcut "$DesktopPath\$ShortcutName.lnk" $OutputPath
	}
	
	# Backup user folders
	if (Test-Feature backup.backupUserFolders) {
		Invoke-BackupUserFolders $OutputPath
	}

	# Remove temporary shortcuts
	if (Test-Feature backup.createTemporaryBackupShortcut) {
		Remove-Item "$DesktopPath\$ShortcutName.lnk" -ErrorAction SilentlyContinue
		Remove-Item "$OutputPath\Desktop\$ShortcutName.lnk" -ErrorAction SilentlyContinue
	}

	# Take a screenshot of the desktop
	if (Test-Feature backup.takeScreenshot) {
		Invoke-TakeScreenshot $OutputPath
	}

	# Make a ZIP of the backup data and put it on the desktop
	Compress-Archive $OutputPath "$DesktopPath\$Name.zip"

	# Delete the backup data
	Remove-Item $OutputPath -Force -Recurse

	Write-Host 'Done!'
}

function Invoke-Debloat {
	$ProgressPreference = 'SilentlyContinue'

	# Block Microsoft telemetry
	if (Test-Feature common.blockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Patch Hosts file
	if (Test-Feature common.patchHosts) {
		Write-Host 'Patching hosts... (Windows Defender may false positive)'
		Invoke-PatchHosts
	}

	# Patch registry
	if (Test-Feature common.patchRegistry) {
		Write-Host 'Patching registry...'
		Invoke-PatchRegistry
	}

	# Disable Focus Assist automatic rules
	if (Test-Feature common.disableFocusAssist) {
		Write-Host 'Disabling Focus Assist automatic rules...'
		Disable-FocusAssist
	}

	# Uninstall useless apps
	if (Test-Feature common.uninstallUselessApps) {
		Write-Host 'Uninstalling useless apps...'
		Remove-UselessApps
	}

	# Uninstall OneDrive
	if (Test-Feature install.uninstallOneDrive) {
		Write-Host 'Uninstalling OneDrive...'
		Remove-OneDrive
	}
	
	# Remove Edge shortcut from Desktop
	if (Test-Feature common.removeEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}
	
	# Clean start menu & taskbar
	if (Test-Feature common.cleanStartAndTaskbar) {
		Write-Host 'Cleaning taskbar & start menu...'
		Invoke-CleanStartAndTaskbar
	}

	# Clean-up start menu and desktop
	if (Test-Feature common.cleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}

function Invoke-Install {
	$ProgressPreference = 'SilentlyContinue'

	# Rename computer
	if (Test-Feature install.renameComputer) {
		Invoke-RenameComputer
	}

	# Block Microsoft telemetry
	if (Test-Feature common.blockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Patch Hosts file
	if (Test-Feature common.patchHosts) {
		Write-Host 'Patching hosts... (Windows Defender may false positive)'
		Invoke-PatchHosts
	}

	# Patch registry
	if (Test-Feature common.patchRegistry) {
		Write-Host 'Patching registry...'
		Invoke-PatchRegistry
	}

	# Disable Focus Assist automatic rules
	if (Test-Feature common.disableFocusAssist) {
		Write-Host 'Disabling Focus Assist automatic rules...'
		Disable-FocusAssist
	}

	# Uninstall useless apps
	if (Test-Feature common.uninstallUselessApps) {
		Write-Host 'Uninstalling useless apps...'
		Remove-UselessApps
	}

	# Uninstall OneDrive
	if (Test-Feature install.uninstallOneDrive) {
		Write-Host 'Uninstalling OneDrive...'
		Remove-OneDrive
	}

	# Import certificates
	if (Test-Feature common.importCertificates) {
		Write-Host 'Importing certificates...'
		Import-Certificates
	}

	# Install fonts
	if (Test-Feature install.installFonts) {
		Write-Host 'Installing fonts...'
		Install-Fonts
	}

	# Set user home folder icon
	if (Test-Feature install.setUserHomeIcon) {
		Write-Host 'Setting user home folder icon...'
		Set-UserHomeIcon
	}

	# Pin folders to Quick Access
	if (Test-Feature install.pinFoldersToQuickAccess) {
		Write-Host 'Pinning user folders to Quick Access...'
		Invoke-PinFoldersToQuickAccess
	}

	# Remove Edge shortcut from Desktop
	if (Test-Feature common.removeEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Set wallpaper
	if (Test-Feature install.setWallpaper) {
		Write-Host 'Applying wallpaper...'
		Set-Wallpaper
	}

	# Install software
	if (Test-Feature install.installSoftware) {
		Write-Host 'Installing software...'

		if ($VerbosePreference -eq 'SilentlyContinue') {
			Install-Software | Out-Null
		} else {
			Install-Software
		}
	}

	# Clean start menu & taskbar
	if (Test-Feature common.cleanStartAndTaskbar) {
		Write-Host 'Cleaning taskbar & start menu...'
		Invoke-CleanStartAndTaskbar
	}

	# Clean-up start menu and desktop
	if (Test-Feature common.cleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	# Synchronize clock
	if (Test-Feature common.synchronizeClock) {
		Write-Host 'Synchronizing clock...'
		Invoke-SynchronizeClock
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}

function Invoke-Update {
	$ProgressPreference = 'SilentlyContinue'

	# Block Microsoft telemetry
	if (Test-Feature common.blockMicrosoftTelemetry) {
		Write-Host 'Removing telemetry services...'
		Remove-TelemetryServices
	}

	# Import certificates
	if (Test-Feature common.importCertificates) {
		Write-Host 'Importing certificates...'
		Import-Certificates
	}

	# Install fonts
	if (Test-Feature install.installFonts) {
		Write-Host 'Installing fonts...'
		Install-Fonts
	}

	# Remove Edge shortcut from Desktop
	if (Test-Feature common.removeEdgeShortcut) {
		Write-Host 'Removing Edge shortcut from desktop...'
		Remove-EdgeShortcut
	}

	# Install software
	if (Test-Feature update.updateSoftware) {
		Write-Host 'Updating software...'
		
		if ($VerbosePreference -eq 'SilentlyContinue') {
			Update-Software | Out-Null
		} else {
			Update-Software
		}
	}

	# Clean-up start menu and desktop
	if (Test-Feature common.cleanShortcuts) {
		Write-Host 'Cleaning shortcuts...'
		Invoke-CleanShortcuts
	}

	$ProgressPreference = 'Continue'

	Write-Host 'Done!'
}

function New-Shortcut {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Path,
		
		[Parameter(Mandatory = $true)]
		[String]
		$Target,
		
		[Parameter()]
		[String]
		$Arguments,
		
		[Parameter()]
		[String]
		$Icon
	)

	$WShellObject = New-Object -ComObject WScript.Shell
	$Shortcut = $WShellObject.CreateShortcut($Path)
	$Shortcut.TargetPath = $Target

	if ($Arguments) {
		$Shortcut.Arguments = $Arguments
	}

	if ($Icon) {
		$Shortcut.IconLocation = $Icon
	}

	$Shortcut.Save()
}

function Stop-Bro {
	Write-Host "Goodbye."
}

function Test-ChocolateyInstalled {
	$choco = Get-Command -Name choco.exe -ErrorAction SilentlyContinue

	if ($choco) {
		return $true
	}
	
	return $false
}

function Test-Feature {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Feature
	)

	$Array = $Feature.Split('.')
	$Group = $Array[0]
	$Name = $Array[1]

	if (! $Config.features.$Group) {
		Write-Warning "Unknown feature group: $Group"
	} elseif (! $Name -in $Config.features.$Group) {
		Write-Warning "Unknown feature for group $Group`: $Name"
	}

	return $Config.features.$Group.$Name -eq $true
}

function Test-InstallChocolateyPackage {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)
	
	$Packages = $Config.chocolatey.PSObject.Properties;

	foreach ($Package in $Packages) {
		if ($Package.Name -eq $Name) {
			return $Package.Value -eq $true
		}
	}

	return $false
}

function Test-InstallWinGetPackage {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)
	
	$Packages = $Config.winget.PSObject.Properties;

	foreach ($Package in $Packages) {
		if ($Package.Name -eq $Name) {
			return $Package.Value -eq $true
		}
	}

	return $false
}

function Test-ValidateConfig {
	$ErrorCount = 0

	if (Test-Feature common.hideRecentFilesInExplorer) {
		if (-not (Test-Feature common.patchRegistry)) {
			Write-Warning 'Hiding recently used files and folders requires "Patch registry" to be enabled. Please set "common.patchRegistry" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature common.openExplorerWithThisPC) {
		if (-not (Test-Feature common.patchRegistry)) {
			Write-Warning 'Opening Explorer with "This PC" requires "Patch registry" to be enabled. Please set "common.patchRegistry" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installChocolatey) {
		if (-not (Test-Feature install.installSoftware)) {
			Write-Warning 'Installing Chocolatey requires "Install Software" to be enabled. Please set "install.installSoftware" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installChocolateyPackages) {
		if (-not (Test-Feature install.installSoftware)) {
			Write-Warning 'Installing Chocolatey packages requires "Install Software" to be enabled. Please set "install.installSoftware" to "true" and try again.'
			$ErrorCount++
		}

		if (-not (Test-Feature install.installChocolatey)) {
			Write-Warning 'Installing Chocolatey packages requires Chocolatey. Please set "install.installChocolatey" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installWinGet) {
		if (-not (Test-Feature install.installSoftware)) {
			Write-Warning 'Installing Winget requires "Install Software" to be enabled. Please set "install.installSoftware" to "true" and try again.'
			$ErrorCount++
		}

		if (-not (Test-Feature install.installChocolatey)) {
			Write-Warning 'Installing WinGet requires Chocolatey. Please set "install.installChocolatey" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installWinGetPackages) {
		if (-not (Test-Feature install.installWinGet)) {
			Write-Warning 'Installing WinGet packages requires WinGet. Please set "install.installWinGet" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature update.updateChocolateyPackages) {
		if (-not (Test-Feature update.updateSoftware)) {
			Write-Warning 'Updating Chocolatey packages requires "Update Software" to be enabled. Please set "update.updateSoftware" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature update.updateWinGetPackages) {
		if (-not (Test-Feature update.updateSoftware)) {
			Write-Warning 'Updating WinGet packages requires "Update Software" to be enabled. Please set "update.updateSoftware" to "true" and try again.'
			$ErrorCount++
		}
	}

	return $ErrorCount -eq 0
}
function Test-WinGetInstalled {
	$winget = Get-Command -Name winget.exe -ErrorAction SilentlyContinue

	if ($winget) {
		return $true
	}
	
	return $false
}

function Disable-FocusAssist {
	$Prefix = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$quietmoment'
	$Suffix = '$windows.data.notifications.quietmoment\Current'
	$FocusAssistRules = @(
		'presentation',
		'game',
		'fullscreen',
		'postoobe'
	)
	$Name = 'Data'

	foreach ($Rule in $FocusAssistRules) {
		$Data = (Get-ItemProperty -Path "$Prefix$Rule$Suffix" -Name $Name -ErrorAction SilentlyContinue).$Name

		if ($Data) {
			if ($Data[22] -eq 1 -and $Data[23] -eq 194 -and $Data[24] -eq 20) {
				$Data = $Data[0..21] + $Data[25..($Data.Length - 1)] # Remove 3 bytes at 0x0016
				Set-ItemProperty -Path "$Prefix$Rule$Suffix" -Name $Name -Value $Data
			}
		}
	}
}

function Import-Certificates {
	$FilePath = "$env:TMP\Bro_Certificates.zip"
	$CertificatesPath = "$env:TMP\Bro_Certificates"

	Get-AssetBits Certificates $FilePath | Out-Null

	Expand-Archive $FilePath $CertificatesPath
	Remove-Item $FilePath

	Get-ChildItem -Path $CertificatesPath -Filter *.crt | ForEach-Object {
		Import-Certificate -FilePath $_.FullName -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
	}

	Remove-Item $CertificatesPath -Recurse
}

function Install-Chocolatey {
	Set-ExecutionPolicy Bypass -Scope Process -Force
	[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
	Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1')) *>&1 | Out-Null

	$DocumentsPath = [Environment]::GetFolderPath('MyDocuments')
	$PowerShellFolder = Get-Item "$DocumentsPath\WindowsPowerShell" -ErrorAction SilentlyContinue

	if ($PowerShellFolder) {
		$PowerShellFolder.Attributes += 'Hidden'
	}

	choco feature enable -n=useRememberedArgumentsForUpgrades
}

function Install-ChocolateyPackages {

	if (-not (Test-ChocolateyInstalled)) {
		Write-Warning 'Chocolatey not found. Packages will not be installed.'
		return
	}

	if (Test-InstallChocolateyPackage Firefox) {
		choco install firefox -ry
	}

	if (Test-InstallChocolateyPackage 7-Zip) {
		choco install 7zip -ry
	}

	if (Test-InstallChocolateyPackage Notepad++) {
		choco install notepadplusplus -ry
	}

	if (Test-InstallChocolateyPackage VLC) {
		choco install vlc -ry
	}
}

function Install-Fonts {
	$FilePath = "$env:TMP\Bro_Fonts.zip"
	$FontsPath = "$env:TMP\Bro_Fonts"
	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	Get-AssetBits Fonts $FilePath | Out-Null

	Expand-Archive $FilePath $FontsPath
	Remove-Item $FilePath

	$Destination = "$DesktopPath\Fonts"
	New-Item $Destination -ItemType Directory | Out-Null

	Get-ChildItem -Path $FontsPath -Include *.ttf, *.otf -Recurse | ForEach-Object {
		Copy-Item $_ $Destination
	}

	Remove-Item $FontsPath -Recurse
}

function Install-Software {

	if (Test-Feature install.installChocolatey) {
		Install-Chocolatey
	}

	if (Test-Feature install.installChocolateyPackages) {
		Install-ChocolateyPackages
	}

	if (Test-Feature install.installWinGet) {
		Install-WinGet
	}

	if (Test-Feature install.installWinGetPackages) {
		Install-WinGetPackages
	}

	if ((Test-InstallChocolateyPackage '7-Zip') -or (Test-InstallWinGetPackage '7-Zip')) {
		# Create dummy shortcuts on the desktop
		$DesktopPath = [Environment]::GetFolderPath('Desktop')
		$DummyFileName = 'Dummy (right-click - Properties - Change...)'
		
		New-Item "$DesktopPath\$DummyFileName.7z" -Force | Out-Null
		New-Item "$DesktopPath\$DummyFileName.rar" -Force | Out-Null
		New-Item "$DesktopPath\$DummyFileName.zip" -Force | Out-Null

		# Set context menu items via registry
		$RegistryPath = 'HKCU:\SOFTWARE\7-Zip\Options'
		$Name = 'ContextMenu'
		$Value = '4359'

		if (! (Test-Path $RegistryPath)) {
			New-Item -Path $RegistryPath | Out-Null
		}

		New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
	}
}

function Install-WinGet {

	if (-not (Test-ChocolateyInstalled)) {
		Write-Warning 'Chocolatey not found. WinGet will not be installed.'
		return
	}

	choco install microsoft-vclibs -ry
	choco install winget -ry
}

function Install-WinGetPackages {

	if (-not (Test-WinGetInstalled)) {
		Write-Warning 'WinGet not found. Packages will not be installed.'
		return
	}

	if (Test-InstallWinGetPackage Firefox) {
		winget install -e --id Mozilla.Firefox --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallWinGetPackage 7-Zip) {
		winget install -e --id 7zip.7zip --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallWinGetPackage Notepad++) {
		winget install -e --id Notepad++.Notepad++ --accept-source-agreements --accept-package-agreements
	}

	if (Test-InstallWinGetPackage VLC) {
		winget install -e --id VideoLAN.VLC --accept-source-agreements --accept-package-agreements
	}
}

function Invoke-CleanShortcuts {
	$StartMenu = "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs"
	$PublicDesktop = 'C:\Users\Public\Desktop'

	if (Test-Path "$StartMenu\7-Zip\7-Zip File Manager.lnk") {
		Move-Item "$StartMenu\7-Zip\7-Zip File Manager.lnk" "$StartMenu\7-Zip.lnk" -Force
		Remove-Item "$StartMenu\7-Zip" -Recurse
	}
	
	if (Test-Path "$StartMenu\VideoLAN\VLC\VLC media player.lnk") {
		Move-Item "$StartMenu\VideoLAN\VLC\VLC media player.lnk" "$StartMenu\VLC.lnk" -Force
		Remove-Item "$StartMenu\VideoLAN" -Recurse
	}
	
	if (Test-Path "$StartMenu\VideoLAN\VLC media player.lnk") {
		Move-Item "$StartMenu\VideoLAN\VLC media player.lnk" "$StartMenu\VLC.lnk" -Force
		Remove-Item "$StartMenu\VideoLAN" -Recurse
	}

	foreach ($Shortcut in @(
		'Firefox'
		'VLC media player'
	)) {
		if (Test-Path "$PublicDesktop\$Shortcut.lnk") {
			Remove-Item "$PublicDesktop\$Shortcut.lnk"
		}
	}
}

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

function Invoke-PatchRegistry {
	$CommunicationsKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Communications'
	if (Test-Path "HKLM:\$CommunicationsKey") {
		Grant-KeyPermissions 'HKLM' $CommunicationsKey
	}

	if (Test-Feature common.openExplorerWithThisPC) {
		Write-Verbose "Applying patch: Open Explorer with This PC instead of Quick Access"

		$FilePath = "$env:TMP\Bro_OpenExplorerWithThisPC.reg"
		Get-RegistryAsset openExplorerWithThisPC $FilePath | Out-Null
		reg import $FilePath 2>&1 | Out-Null
		Remove-Item $FilePath
	}

	if (Test-Feature common.hideRecentFilesInExplorer) {
		Write-Verbose "Applying patch: Don't show recently used files and folders in Explorer"

		$FilePath = "$env:TMP\Bro_DontShowRecentFilesAndFolders.reg"
		Get-RegistryAsset dontShowRecentFiles $FilePath | Out-Null
		reg import $FilePath 2>&1 | Out-Null
		Remove-Item $FilePath
	}
	
	$FilePath = "$env:TMP\Bro_Tweaks.reg"
	Get-RegistryAsset tweaks $FilePath | Out-Null
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

function Invoke-PinFoldersToQuickAccess {
	$ShellAppObject = New-Object -ComObject Shell.Application
	$ShellAppObject.Namespace('shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}').Items() | ForEach-Object {
		$_.InvokeVerb('unpinfromhome')
	}

	$Folders = @(
		[Environment]::GetFolderPath('UserProfile'),
		[Environment]::GetFolderPath('Desktop'),
		$ShellAppObject.NameSpace('shell:Downloads').Self.Path,
		[Environment]::GetFolderPath('MyDocuments'),
		[Environment]::GetFolderPath('MyPictures'),
		[Environment]::GetFolderPath('MyMusic'),
		[Environment]::GetFolderPath('MyVideos')
	)

	foreach ($Folder in $Folders) {
		$ShellAppObject.Namespace($Folder).Self.InvokeVerb('pintohome')
	}
}

function Invoke-RenameComputer {
	$ComputerName = Read-ComputerName
	
	if ($env:COMPUTERNAME -ne $ComputerName) {
		Write-Host "Computer will be renamed to $ComputerName upon restart."
		Rename-Computer -NewName $ComputerName -WarningAction SilentlyContinue
	} else {
		Write-Host -ForegroundColor Yellow "`nThe computer name is already set to $ComputerName."
	}
}

function Invoke-SynchronizeClock {
	sc.exe stop w32time | Out-Null
	Start-Sleep -s 1
	sc.exe start w32time | Out-Null
	Start-Sleep -s 3
	w32tm /config /update | Out-Null
	Start-Sleep -s 1
	w32tm /resync /rediscover | Out-Null
	Start-Sleep -s 1
	w32tm /resync /force | Out-Null
}

function Read-ComputerName {
	$ComputerName = $Config.newComputerName

	if ($null -ne $ComputerName) {
		return $ComputerName
	}

	$ComputerName = Read-Host -Prompt 'Computer name'

	while (($ComputerName.Length -gt 15) -or ($ComputerName -notmatch '^[A-z0-9\-]+$') -or ($ComputerName -match '^[0-9]+$')) {
		
		if ($ComputerName.Length -gt 15) {
			Write-Host -ForegroundColor Yellow 'The computer name is limited to 15 characters.'
		}
		
		if ($ComputerName -notmatch '^[A-z0-9\-]+$') {
			Write-Host -ForegroundColor Yellow 'The computer name contains invalid characters. (Only A-z, 0-9 and -)'
		}
		
		if ($ComputerName -match '^[0-9]+$') {
			Write-Host -ForegroundColor Yellow 'The computer name may not consist entirely of digits.'
		}
	
		Write-Host ""
		$ComputerName = Read-Host -Prompt 'Computer name'
	}

	return $ComputerName
}

function Remove-EdgeShortcut {
	$DesktopPath = [Environment]::GetFolderPath('Desktop')
	$EdgeShortcutPath = "$DesktopPath\Microsoft Edge.lnk"
	
	$PublicDesktop = [Environment]::GetEnvironmentVariable('Public') + '\Desktop'
	$EdgeShortcutPathPublic = "$PublicDesktop\Microsoft Edge.lnk"

	if (Test-Path $EdgeShortcutPath) {
		Remove-Item $EdgeShortcutPath -Force
	}

	if (Test-Path $EdgeShortcutPathPublic) {
		Remove-Item $EdgeShortcutPathPublic -Force
	}
}

function Remove-OneDrive {
	$OneDrive_x86 = "$env:SYSTEMROOT\System32\OneDriveSetup.exe"
	$OneDrive_x64 = "$env:SYSTEMROOT\SysWOW64\OneDriveSetup.exe"

	Get-Process OneDriveSetup -ErrorAction SilentlyContinue | Stop-Process
	Get-Process OneDrive -ErrorAction SilentlyContinue | Stop-Process

	if (Test-Path $OneDrive_x64) {
		Start-Process $OneDrive_x64 /uninstall -Wait
	}
	elseif (Test-Path $OneDrive_x86) {
		Start-Process $OneDrive_x86 /uninstall -Wait
	}

	$OneDriveFolders = @(
		"$env:USERPROFILE\OneDrive",
		"$env:LOCALAPPDATA\Microsoft\OneDrive",
		"$env:PROGRAMDATA\Microsoft OneDrive",
		'C:\OneDriveTemp'
	)

	foreach ($Folder in $OneDriveFolders) {
		Remove-Item $Folder -Recurse -Force -ErrorAction SilentlyContinue
	}
}

function Remove-TelemetryServices {
	sc.exe stop DiagTrack | Out-Null
	sc.exe stop dmwappushservice | Out-Null
	sc.exe delete DiagTrack | Out-Null
	sc.exe delete dmwappushservice | Out-Null

	$LogPath = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\Autologger\AutoLogger-Diagtrack-Listener.etl"

	if (Test-Path $LogPath) {
		Remove-Item $LogPath -Force
	}

	New-Item $LogPath | Out-Null
}

function Remove-UselessApps {
	$UselessApps = $Config.uselessApps

	foreach ($App in $UselessApps) {
		$ProPackageFullName = (Get-AppxProvisionedPackage -Online | Where-Object { $_.Displayname -eq $App }).PackageName

		if ($ProPackageFullName) {
			Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName | Out-Null -ErrorAction SilentlyContinue
		}
	}

	foreach ($App in $UselessApps) {
		$PackageFullName = (Get-AppxPackage $App).PackageFullName

		foreach ($Package in $PackageFullName) {
			Remove-AppxPackage -Package $Package -ErrorAction SilentlyContinue
		}
	}
}

function Set-UserHomeIcon {
	$DesktopIniFile = @'
[.ShellClassInfo]
IconResource=C:\Windows\System32\SHELL32.dll,170
'@

	$DesktopIniFilePath = "$env:USERPROFILE\desktop.ini"

	Set-Content $DesktopIniFilePath -Value $DesktopIniFile
	(Get-Item $DesktopIniFilePath -Force).Attributes = 'Hidden, System, Archive'
	(Get-Item ((Get-ChildItem $DesktopIniFilePath -Force).Directory)).Attributes = 'ReadOnly, Directory'
}

$Code = @'
using System.Runtime.InteropServices;

public class Wallpaper
{
	public const int SetDesktopWallpaper = 20;
	public const int UpdateIniFile = 0x01;
	public const int SendWinIniChange = 0x02;
	[DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
	private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
	public static void SetWallpaper(string path)
	{
	SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
	}
}
'@

Add-Type $Code

function Set-Wallpaper {
	$FilePath = "$env:TMP\Bro_Wallpaper.jpg"

	Get-Asset Wallpaper $FilePath | Out-Null

	[Wallpaper]::SetWallpaper($FilePath)

	Remove-Item $FilePath
}

function Update-Software {

	if (Test-Feature update.updateChocolateyPackages) {
		choco upgrade all -ry
	}

	if (Test-Feature update.updateWinGetPackages) {
		winget upgrade --all
	}

}

function Get-BackupOutputPath {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$Name
	)

	$OutputPath = "$env:TMP\$Name"

	$i = 0
	while (Test-Path $OutputPath) {
		$i++
		$OutputPath = "$env:TMP\$Name ($i)"
	}

	New-Item $OutputPath -ItemType Directory | Out-Null
	Write-Host "Backup folder created at $OutputPath"

	return $OutputPath
}

function Invoke-BackupUserFolders {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$OutputPath
	)

	$ShellAppObject = New-Object -ComObject Shell.Application
	
	$Desktop	= [Environment]::GetFolderPath('Desktop')
	$Downloads	= $ShellAppObject.NameSpace('shell:Downloads').Self.Path
	$Documents	= [Environment]::GetFolderPath('MyDocuments')
	$Pictures	= [Environment]::GetFolderPath('MyPictures')
	$Music		= [Environment]::GetFolderPath('MyMusic')
	$Videos		= [Environment]::GetFolderPath('MyVideos')

	$BackupFolders = @(
		@{
			Source = $Desktop
			Destination = 'Desktop'
		},
		@{
			Source = $Downloads
			Destination = 'Downloads'
		},
		@{
			Source = $Documents
			Destination = 'Documents'
		},
		@{
			Source = $Pictures
			Destination = 'Pictures'
		},
		@{
			Source = $Music
			Destination = 'Music'
		},
		@{
			Source = $Videos
			Destination = 'Videos'
		}
	)

	$BackupFolders | ForEach-Object {
		$destination = $_.Destination.ToLower()

		if ($Config.backupFolders.$destination -eq $true) {
			Write-Host "Saving user $destination..."
			$Destination = "$OutputPath\" + $_.Destination
			Copy-Item $_.Source $Destination -Force -Recurse
		}
	}
}

# From https://stackoverflow.com/questions/59996907/how-to-take-a-remote-screenshot-with-powershell
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing

function Invoke-TakeScreenshot {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$OutputPath
	)

	$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen

	$Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height

	$Graphic = [System.Drawing.Graphics]::FromImage($Bitmap)

	# Show the desktop
	$ShellAppObject = New-Object -ComObject Shell.Application
	$ShellAppObject.toggleDesktop()
	$ShellScriptObject = New-Object -ComObject WScript.Shell
	$ShellScriptObject.SendKeys("^{ESC}")

	Start-Sleep 1

	$Graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $Bitmap.Size)
	
	$Bitmap.Save("$OutputPath\Screenshot.png")
}

Grant-AdministratorPrivileges $MyInvocation

$OriginalFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition

if (Test-Path $OriginalFolder) {
	Set-Location $OriginalFolder
}

$Config = Get-Config

Get-Logo

if (-not (Test-ValidateConfig)) {
	Pause
	Write-Host ''
}

$Selection = Get-Menu

Start-Transcript $env:TMP\Bro.log -Append | Out-Null

switch ($Selection) {
	0 {
		Invoke-Backup
	}
	1 {
		Invoke-Debloat
	}
	2 {
		Invoke-Install
	}
	3 {
		Invoke-Update
	}
	9 {
		Stop-Bro
	}
}
