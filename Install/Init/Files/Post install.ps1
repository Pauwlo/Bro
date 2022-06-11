# Init - Post install

# Variable declarations
$InitPath = $MyInvocation.MyCommand.Path
$InitFolderPath = (Get-Item $InitPath -Force).Directory.FullName
Set-Location $InitFolderPath

Import-Module .\Modules\Test-Internet
Import-Module .\Modules\Get-AdministratorPrivileges
Import-Module .\Modules\Get-Logo

# Check internet connectivity
if (! (Test-Internet)) {
    Write-Host -ForegroundColor Yellow 'You must be connected to the internet to run the post install script. Please connect and try again.'
    Pause
    Exit
}

Get-AdministratorPrivileges $MyInvocation

$DummyFileName = 'Dummy (right-click - Properties - Change...)'
$RegistryTweaksFilePath = 'System\Tweaks.reg'

$ShouldPatchRegistry = Test-Path $RegistryTweaksFilePath
$ShouldUninstallTeams = $true
$ShouldInstallChocolatey = $true
$ShouldInstallFirefox = $true
$ShouldInstallVLC = $true
$ShouldInstallNotepadPlusPlus = $true
$ShouldInstall7Zip = $true

$Host.UI.RawUI.WindowTitle = 'Init (post install)'
Get-Logo

# Init integrity checks
if (!$ShouldInstallChocolatey -and ($ShouldInstallFirefox -or $ShouldInstallVLC -or $ShouldInstallNotepadPlusPlus -or $ShouldInstall7Zip)) {
    Write-Host -ForegroundColor Yellow 'Chocolatey is required to install third-party software.'
    Write-Host -ForegroundColor Yellow 'Set $ShouldInstallChocolatey to $true or set other software variables to $false.'
    Pause
    Exit
}

# Reimport registry tweaks in case Windows updates overrode some
if ($ShouldPatchRegistry) {
    Write-Host 'Patching registry again...'
    reg import $RegistryTweaksFilePath 2>&1 | Out-Null
}

# Uninstall Microsoft Teams
if ($ShouldUninstallTeams) {
    Write-Host 'Uninstalling Microsoft Teams...'

    $App = 'MicrosoftTeams'
    $ProPackageFullName = (Get-AppxProvisionedPackage -Online | Where-Object { $_.Displayname -eq $App }).PackageName
    $PackageFullName = (Get-AppxPackage $App).PackageFullName

    if ($ProPackageFullName) {
        Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName | Out-Null -ErrorAction SilentlyContinue
    }

    foreach ($Package in $PackageFullName) {
        Remove-AppxPackage -Package $Package -ErrorAction SilentlyContinue
    }
}

# Install software via Chocolatey package manager
if ($ShouldInstallChocolatey) {
    Write-Host 'Installing Chocolatey...'

    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    
    $DocumentsPath = [Environment]::GetFolderPath('MyDocuments')
    (Get-Item "$DocumentsPath\WindowsPowerShell").Attributes += 'Hidden'

    choco feature enable -n=useRememberedArgumentsForUpgrades

    Write-Host 'Installing software...'

    if ($ShouldInstallFirefox) {
        choco install firefox -ry

        New-Item "$DummyFileName.pdf" -Force | Out-Null
    }

    if ($ShouldInstallVLC) {
        choco install vlc -ry
    }

    if ($ShouldInstallNotepadPlusPlus) {
        choco install notepadplusplus -ry
    }

    if ($ShouldInstall7Zip) {
        choco install 7zip --pre -ry

        New-Item "$DummyFileName.7z" -Force | Out-Null
        New-Item "$DummyFileName.rar" -Force | Out-Null
        New-Item "$DummyFileName.zip" -Force | Out-Null

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

# Clean start menu and desktop
$StartMenuPath = "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs"

if (Test-Path "$StartMenuPath\7-Zip") {
    Move-Item "$StartMenuPath\7-Zip\7-Zip File Manager.lnk" "$StartMenuPath\7-Zip.lnk"
    Remove-Item "$StartMenuPath\7-Zip" -Recurse -Force
}

if (Test-Path "$StartMenuPath\VideoLAN") {
    Move-Item "$StartMenuPath\VideoLAN\VLC media player.lnk" "$StartMenuPath\VLC.lnk"
    Remove-Item "$StartMenuPath\VideoLAN" -Recurse -Force
    Remove-Item 'C:\Users\Public\Desktop\VLC media player.lnk'
}

# Final clean-up
Set-Location '..'
Remove-Item $InitFolderPath -Recurse -Force
Remove-Item 'Post install.lnk'

Restart-Computer
