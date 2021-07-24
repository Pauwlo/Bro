# Init - Post install

# Self-elevate
$IsElevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$IsElevated) {
    $CommandLine = '-ExecutionPolicy Bypass -File "' + $MyInvocation.MyCommand.Path + '" ' + $MyInvocation.UnboundArguments
    Start-Process -FilePath powershell -Verb Runas -ArgumentList $CommandLine
    Exit
}

function Get-Logo {
    Write-Host ' _____       _ _   '
    Write-Host '|_   _|     (_) |  '
    Write-Host '  | |  _ __  _| |_ '
    Write-Host "  | | | '_ \| | __|"
    Write-Host ' _| |_| | | | | |_   Post install'
    Write-Host '|_____|_| |_|_|\__|  (c) 2021 Pauwlo'
    Write-Host ''
}

$Host.UI.RawUI.WindowTitle = 'Init (post install)'
Get-Logo

# Check internet connectivity
$HasInternet = [bool](Get-NetRoute | Where-Object DestinationPrefix -eq '0.0.0.0/0' | Get-NetIPInterface | Where-Object ConnectionState -eq 'Connected')
if (!$HasInternet) {
    Write-Host -ForegroundColor Yellow "You must be connected to the internet to run the post install script. Please connect and try again."
    Pause
    Exit
}

# Variable declarations
$InitPath = $MyInvocation.MyCommand.Path
$InitFolderPath = (Get-Item $InitPath -Force).Directory.FullName
Set-Location $InitFolderPath

$DummyFileName = 'Dummy (right-click - Properties - Change...)'

$ShouldInstallChocolatey = $true
$ShouldInstallFirefox = $true
$ShouldInstallVLC = $true
$ShouldInstallNotepadPlusPlus = $true
$Should7Zip = $true

# Init integrity checks
if (!$ShouldInstallChocolatey -and ($ShouldInstallFirefox -or $ShouldInstallVLC -or $ShouldInstallNotepadPlusPlus -or $Should7Zip)) {
    Write-Host -ForegroundColor Yellow "Chocolatey is required to install third-party software."
    Write-Host -ForegroundColor Yellow 'Set $ShouldInstallChocolatey to $true or set other software variables to $false.'
    Pause
    Exit
}

if ($ShouldInstallChocolatey) {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    
    $DocumentsPath = [Environment]::GetFolderPath('MyDocuments')
    (Get-Item "$DocumentsPath\WindowsPowerShell").Attributes += 'Hidden'

    if ($ShouldInstallFirefox) {
        choco install firefox -y

        New-Item "$DummyFileName.pdf" -Force | Out-Null
    }

    if ($ShouldInstallVLC) {
        choco install vlc -y
    }

    if ($ShouldInstallNotepadPlusPlus) {
        choco install notepadplusplus -y
    }

    if ($Should7Zip) {
        choco install 7zip --pre -y

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
$StartMenuPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"

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
Remove-Item $InitPath -Force
Remove-Item 'Post install.lnk'

Restart-Computer
