# Init

# Variable declarations
$InitPath = $MyInvocation.MyCommand.Path
$InitFolderPath = (Get-Item $InitPath).Directory.FullName
Set-Location $InitFolderPath

Import-Module .\Modules\Get-AdministratorPrivileges
Import-Module .\Modules\Get-Logo
Import-Module .\Modules\New-Shortcut

Get-AdministratorPrivileges $MyInvocation

$DesktopPath = [Environment]::GetFolderPath('Desktop')
$LayoutModificationFilePath = 'System\LayoutModification.xml'
$HostsFilePath = 'System\Hosts.txt'
$RegistryTweaksFilePath = 'System\Tweaks.reg'
$CertificatesFolderPath = 'Certificates'
$FontsFolderPath = 'Fonts'
$PostInstallFilePath = 'Post install.ps1'

$ShouldCleanTaskbarAndStartMenu = $true
$ShouldUninstallOneDrive = $true
$ShouldUninstallUselessApps = $true
$ShouldBlockMicrosoftTelemetry = $true
$ShouldPatchHosts = $true
$ShouldPatchRegistry = $true
$ShouldDisableFocusAssistRules = $true
$ShouldImportCertificates = $true
$ShouldInstallFonts = $true
$ShouldSetUserHomeFolderIcon = $true
$ShouldPinFoldersToQuickAccess = $true
$ShouldRemoveEdgeShortcutFromDesktop = $true
$ShouldRenameComputer = $true
$ShouldCreatePostInstallShortcut = $true

$Host.UI.RawUI.WindowTitle = 'Init'
Get-Logo
Write-Host 'Welcome to Init.'

# Init integrity checks
if ($ShouldPatchHosts -and !(Test-Path $HostsFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$HostsFilePath is missing."
    Write-Host -ForegroundColor Yellow 'Hosts file will not be patched.'
    Pause
    $ShouldPatchHosts = $false
}

if ($ShouldCleanTaskbarAndStartMenu -and !(Test-Path $LayoutModificationFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$LayoutModificationFilePath is missing."
    Write-Host -ForegroundColor Yellow 'Taskbar and start menu will not be cleaned.'
    Pause
    $ShouldCleanTaskbarAndStartMenu = $false
}

if ($ShouldPatchRegistry -and !(Test-Path $RegistryTweaksFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$RegistryTweaksFilePath is missing."
    Write-Host -ForegroundColor Yellow 'Registry will not be patched (not recommended).'
    Pause
    $ShouldPatchRegistry = $false
}

if ($ShouldImportCertificates -and !(Test-Path $CertificatesFolderPath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$CertificatesFolderPath folder is missing."
    Write-Host -ForegroundColor Yellow 'Certificates will not be imported.'
    Pause
    $ShouldImportCertificates = $false
}

if ($ShouldInstallFonts -and !(Test-Path $FontsFolderPath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$FontsFolderPath folder is missing."
    Write-Host -ForegroundColor Yellow 'Fonts will not be installed.'
    Pause
    $ShouldInstallFonts = $false
}

if ($ShouldCopyPostInstallScript -and !(Test-Path $PostInstallFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$PostInstallFilePath is missing."
    Write-Host -ForegroundColor Yellow 'Post install shortcut will not be created to the desktop (not recommended).'
    Pause
    $ShouldCopyPostInstallScript = $false
}

if ($ShouldRenameComputer) {
    Write-Host ""
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

    if ($env:COMPUTERNAME -eq $ComputerName) {
        Write-Host -ForegroundColor Yellow "`nComputer name is already set to $ComputerName."
        Pause
        $ShouldRenameComputer = $false
    }
}

Clear-Host
$Host.UI.RawUI.WindowTitle = 'Init - Working, please wait...'
Get-Logo

# Clean taskbar & start menu
if ($ShouldCleanTaskbarAndStartMenu) {
    Write-Host 'Cleaning taskbar & start menu...'

    $TempLayoutPath = 'C:\LayoutModification.xml'
    Copy-Item $LayoutModificationFilePath $TempLayoutPath
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
    Start-Sleep -s 3

    foreach ($Registry in @('HKLM', 'HKCU')) {
        $KeyPath = $Registry + ':\Software\Policies\Microsoft\Windows\Explorer'
        Remove-Item $KeyPath
    }

    Remove-Item $TempLayoutPath
    Set-Location $InitFolderPath
}

taskkill /im explorer.exe /f | Out-Null

# Uninstall OneDrive
if ($ShouldUninstallOneDrive) {
    Write-Host 'Uninstalling OneDrive...'

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

# Uninstall useless apps
if ($ShouldUninstallUselessApps) {
    Write-Host 'Uninstalling useless apps...'

    $UselessApps = @(
        'MicrosoftTeams',
        'MicrosoftWindows.Client.WebExperience', # Widgets
        'Microsoft.549981C3F5F10',
        'Microsoft.Advertising.Xaml',
        'Microsoft.BingNews',
        'Microsoft.BingWeather',
        'Microsoft.GamingApp',
        'Microsoft.GetHelp',
        'Microsoft.Getstarted',
        'Microsoft.Messaging',
        'Microsoft.Microsoft3DViewer',
        'Microsoft.MicrosoftOfficeHub',
        'Microsoft.MicrosoftSolitaireCollection',
        'Microsoft.MixedReality.Portal',
        'Microsoft.MSPaint',
        'Microsoft.Office.OneNote',
        'Microsoft.OneConnect',
        'Microsoft.People',
        'Microsoft.PowerAutomateDesktop',
        'Microsoft.Print3D',
        'Microsoft.SkypeApp',
        'Microsoft.Todos',
        'Microsoft.Wallet',
        #'microsoft.windowscommunicationsapps', # Mail and Calendar
        'Microsoft.WindowsFeedbackHub',
        'Microsoft.WindowsMaps',
        'Microsoft.Xbox.TCUI',
        'Microsoft.XboxApp',
        'Microsoft.XboxGameOverlay',
        'Microsoft.XboxGamingOverlay',
        'Microsoft.XboxIdentityProvider',
        'Microsoft.XboxSpeechToTextOverlay',
        'Microsoft.YourPhone',
        'Microsoft.ZuneMusic',
        'Microsoft.ZuneVideo'
    )

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

# Block Microsoft telemetry
if ($ShouldBlockMicrosoftTelemetry) {
    Write-Host 'Removing telemetry services...'

    sc.exe stop DiagTrack | Out-Null
    sc.exe stop dmwappushservice | Out-Null
    sc.exe delete DiagTrack | Out-Null
    sc.exe delete dmwappushservice | Out-Null

    New-Item "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl" | Out-Null
}

if ($ShouldPatchHosts) {
    Add-MpPreference -ExclusionPath 'C:\Windows\System32\drivers\etc\hosts'

    $WindowsHostsFilePath = "$env:WINDIR\System32\drivers\etc\hosts"

    if ((Get-Content $WindowsHostsFilePath) -match 'telemetry') {
        Write-Host -ForegroundColor Yellow 'It seems that the hosts file was already patched in the past.'
        Write-Host -ForegroundColor Yellow 'In order to prevent loosing user modifications, and to avoid duplicates, it will not be patched again by Init.'
        Pause
    }
    else {
        Write-Host 'Patching hosts...'
        Get-Content $HostsFilePath | Add-Content $WindowsHostsFilePath
    }
}

# Import registry tweaks
if ($ShouldPatchRegistry) {
    Write-Host 'Patching registry...'
    reg import $RegistryTweaksFilePath 2>&1 | Out-Null
}
else {
    Remove-Item $RegistryTweaksFilePath -ErrorAction SilentlyContinue
}

# Disable Focus Assist automatic rules
if ($ShouldDisableFocusAssistRules) {
    Write-Host 'Disabling Focus Assist automatic rules...'

    $Prefix = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$quietmoment'
    $Suffix = '$windows.data.notifications.quietmoment\Current'
    $FocusAssistRules = @(
        'presentation',
        'game',
        'fullscreen',
        'postoobe'
    )
    $Name = 'Data'

    foreach ($rule in $FocusAssistRules) {
        $Data = (Get-ItemProperty -Path "$Prefix$rule$Suffix" -Name $Name -ErrorAction SilentlyContinue).$Name

        if ($Data) {
            if ($Data[22] -eq 1 -and $Data[23] -eq 194 -and $Data[24] -eq 20) {
                $Data = $Data[0..21] + $Data[25..($Data.Length - 1)] # Remove 3 bytes at 0x0016
                Set-ItemProperty -Path "$Prefix$rule$Suffix" -Name $Name -Value $Data
            }
        }
    }
}

# Import certificates
if ($ShouldImportCertificates) {
    Write-Host 'Importing certificates...'

    Get-ChildItem -Path $CertificatesFolderPath -Filter *.crt | ForEach-Object {
        Import-Certificate -FilePath $_.FullName -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
    }
}

# Install fonts
if ($ShouldInstallFonts) {
    Write-Host 'Installing fonts...'

    $InstalledFontsFolderPath = Join-Path $env:LOCALAPPDATA 'Microsoft\Windows\Fonts'
    $Destination = (New-Object -ComObject Shell.Application).Namespace(0x14)

    Get-ChildItem -Path $FontsFolderPath -Include *.ttf, *.otf -Recurse | ForEach-Object {
        $TargetPath = Join-Path $InstalledFontsFolderPath $_.Name

        if (!(Test-Path $TargetPath)) {
            $Destination.CopyHere($_.FullName, 0x10)
        }
    }
}

# Set user home folder icon
if ($ShouldSetUserHomeFolderIcon) {
    Write-Host 'Setting user home folder icon...'

    $DesktopIniFile = @'
[.ShellClassInfo]
IconResource=C:\Windows\System32\SHELL32.dll,170
'@

    $DesktopIniFilePath = "$env:USERPROFILE\desktop.ini"

    Add-Content $DesktopIniFilePath -Value $DesktopIniFile
    (Get-Item $DesktopIniFilePath -Force).Attributes = 'Hidden, System, Archive'
    (Get-Item ((Get-ChildItem $DesktopIniFilePath -Force).Directory)).Attributes = 'ReadOnly, Directory'
}

# Pin folders to Quick Access
if ($ShouldPinFoldersToQuickAccess) {
    Write-Host 'Pinning user folders to Quick Access...'

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

# Remove Edge shortcut from Desktop
if ($ShouldRemoveEdgeShortcutFromDesktop) {
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

# Rename computer
if ($ShouldRenameComputer) {
    Write-Host 'Renaming computer...'
    Rename-Computer -NewName $ComputerName -WarningAction SilentlyContinue
}

# Create post install shortcut
if ($ShouldCreatePostInstallShortcut) {
    New-Shortcut "$DesktopPath\Post install.lnk" 'powershell' "-ExecutionPolicy Bypass -File `".\Files\Post install.ps1`""
    (Get-Item $(Get-Location)).Attributes += 'Hidden'
}
else {
    Remove-Item $InitFolderPath -Recurse -Force
}

# Final clean-up
Remove-Item '..\Start Init.lnk'

Restart-Computer
