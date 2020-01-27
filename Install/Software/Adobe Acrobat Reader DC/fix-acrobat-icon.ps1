# Fix Adobe Acrobat Reader DC icon in Start menu

# Self-elevate
[bool]$IsElevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$IsElevated) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = '-ExecutionPolicy Bypass -File "' + $MyInvocation.MyCommand.Path + '" ' + $MyInvocation.UnboundArguments
        Start-Process -FilePath powershell -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

# Try to resolve Acrobat installation path
$DefaultAcrobatPath = 'C:\Program Files (x86)\Adobe\Acrobat Reader DC\Reader\AcroRd32.exe'
$AcrobatPath = $null

if (Test-Path $DefaultAcrobatPath) {
    $AcrobatPath = $DefaultAcrobatPath
} else {
    $AcrobatPath = Read-Host -Prompt "Acrobat executable path (AcroRd32.exe)"
}

if (! (Test-Path $AcrobatPath)) {
    Write-Host -ForegroundColor Yellow "Couldn't find Acrobat executable: $AcrobatPath"
    Pause
    Exit
}

$ShortcutName = 'Acrobat Reader DC.lnk'

# Recreate Acrobat shortcut
$StartMenuFolder = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$ShortcutPath = "$StartMenuFolder\$ShortcutName"

if (Test-Path $ShortcutPath) {
    Remove-Item $ShortcutPath -Force
}

$WShellObject = New-Object -Com WScript.Shell
$Shortcut = $WShellObject.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $AcrobatPath
$Shortcut.IconLocation = "$AcrobatPath, 0"
$Shortcut.Save()
