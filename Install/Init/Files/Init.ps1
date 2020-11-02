# Init

# Self-elevate
[bool]$IsElevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$IsElevated) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = '-ExecutionPolicy Bypass -File "' + $MyInvocation.MyCommand.Path + '" ' + $MyInvocation.UnboundArguments
        Start-Process -FilePath powershell -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

function Get-Logo {
    Write-Host " _____       _ _   "
    Write-Host "|_   _|     (_) |  "
    Write-Host "  | |  _ __  _| |_ "
    Write-Host "  | | | '_ \| | __|"
    Write-Host " _| |_| | | | | |_ "
    Write-Host "|_____|_| |_|_|\__|  (c) 2020 Pauwlo."
    Write-Host ''
}

$Host.UI.RawUI.WindowTitle = 'Init'
Get-Logo
Write-Host 'Welcome to Init.'

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

    $ComputerName = Read-Host -Prompt 'Computer name'
}

# Check if OneDrive setup is running
$OneDriveSetup = Get-Process OneDriveSetup -ErrorAction SilentlyContinue
if ($OneDriveSetup) {
    Write-Host -ForegroundColor Yellow '`nOneDrive setup is still running. You probably started Init too early after installing Windows 10. Please wait 30 seconds, or more if you have a slow computer, and try again.'
    Pause
    Exit
}

# Variable declarations
$InitPath = $MyInvocation.MyCommand.Path
$InitFolderPath = (Get-Item $InitPath).Directory.FullName
Set-Location $InitFolderPath

$DesktopPath = [Environment]::GetFolderPath('Desktop')
$LayoutModificationFilePath = 'LayoutModification.xml'
$HostsFilePath = 'Hosts.txt'
$TweaksFilePath = 'Tweaks.reg'

$ShouldCleanTaskbarAndStartMenu = $true
$ShouldUninstallOneDrive = $true
$ShouldUninstallUselessApps = $true
$ShouldBlockMicrosoftTelemetry = $true
$ShouldInstallHosts = $true
$ShouldInstallTweaks = $true
$ShouldSetUserHomeFolderIcon = $true
$ShouldPinFoldersToQuickAccess = $true
$ShouldRemoveEdgeShortcutFromDesktop = $true

# Init integrity checks
if (!(Test-Path $HostsFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$HostsFilePath is missing."
    Write-Host -ForegroundColor Yellow "Hosts file won't be modified."
    Pause
    $ShouldInstallHosts = $false
}

if (!(Test-Path $LayoutModificationFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$LayoutModificationFilePath is missing."
    Write-Host -ForegroundColor Yellow "Taskbar and start menu won't be cleaned."
    Pause
    $ShouldCleanTaskbarAndStartMenu = $false
}

if (!(Test-Path $TweaksFilePath)) {
    Write-Host -ForegroundColor Yellow "`nFiles\$TweaksFilePath is missing."
    Write-Host -ForegroundColor Yellow "Registry tweaks won't be applied. (not recommended)"
    Pause
    $ShouldInstallTweaks = $false
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
        New-Item $KeyPath | Out-Null
        Set-ItemProperty $KeyPath -Name 'LockedStartLayout' -Value 1
        Set-ItemProperty $KeyPath -Name 'StartLayoutFile' -Value $TempLayoutPath
    }

    Stop-Process -Name explorer
    Start-Sleep -s 5
    $WShellObject = New-Object -ComObject WScript.Shell
    $WShellObject.SendKeys('^{ESCAPE}')
    Start-Sleep -s 5

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

    $OneDriveProcess = Get-Process OneDrive -ErrorAction SilentlyContinue
    if ($OneDriveProcess) {
        Stop-Process -InputObject $OneDriveProcess -Force
    }

    if (Test-Path $OneDrive_x64) {
        Start-Process $OneDrive_x64 /uninstall -Wait
    } elseif (Test-Path $OneDrive_x86) {
        Start-Process $OneDrive_x86 /uninstall -Wait
    }

    $OneDriveFolders = @(
        "$env:USERPROFILE\OneDrive",
        "$env:LOCALAPPDATA\Microsoft\OneDrive",
        "$env:PROGRAMDATA\Microsoft OneDrive",
        'C:\OneDriveTemp'
    )

    foreach ($Folder in $OneDriveFolders) {
        if (Test-Path $Folder) {
            Remove-Item $Folder -Recurse -Force
        }
    }
}

# Uninstall useless apps
if ($ShouldUninstallUselessApps) {
    Write-Host 'Uninstalling useless apps...'

    $UselessApps = @(
        'Microsoft.BingWeather',
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
        'Microsoft.Print3D',
        'Microsoft.SkypeApp',
        'Microsoft.Wallet',
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
    
        if ($PackageFullName) {
            Remove-AppxPackage -Package $PackageFullName -ErrorAction SilentlyContinue
        }
    }
}

# Block Microsoft telemetry
if ($ShouldBlockMicrosoftTelemetry) {
    sc.exe stop DiagTrack | Out-Null
    sc.exe stop dmwappushservice | Out-Null
    sc.exe delete DiagTrack | Out-Null
    sc.exe delete dmwappushservice | Out-Null
}

if ($ShouldInstallHosts) {
    Write-Host 'Patching hosts...'
    Get-Content $HostsFilePath | Add-Content "$env:WINDIR\System32\drivers\etc\hosts"
}

# Import registry tweaks
if ($ShouldInstallTweaks) {
    Write-Host 'Installing registry tweaks...'
    reg import $TweaksFilePath 2>&1 | Out-Null
}

# Set user home folder icon
if ($ShouldSetUserHomeFolderIcon) {

    $DesktopIniFile = @'
[.ShellClassInfo]
IconResource=C:\Windows\System32\imageres.dll,117
'@

    $DesktopIniFilePath = "$env:USERPROFILE\desktop.ini"

    Add-Content $DesktopIniFilePath -Value $DesktopIniFile
    (Get-Item $DesktopIniFilePath -Force).Attributes = 'Hidden, System, Archive'
    (Get-Item ((Get-ChildItem $DesktopIniFilePath -Force).Directory)).Attributes = 'ReadOnly, Directory'
}

# Pin folders to Quick Access
if ($ShouldPinFoldersToQuickAccess) {
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
    if (Test-Path $EdgeShortcutPath) {
        Remove-Item $EdgeShortcutPath -Force
    }
}

# Final clean-up
Set-Location '..'
Remove-Item $InitFolderPath -Recurse -Force
Remove-Item 'Start Init.lnk'

# Rename computer
Rename-Computer -NewName $ComputerName -Restart
