# Create dummy files & add 7-Zip to Path

# Self-elevate
[bool]$IsElevated = (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (!$IsElevated) {
    if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
        $CommandLine = '-ExecutionPolicy Bypass -File "' + $MyInvocation.MyCommand.Path + '" ' + $MyInvocation.UnboundArguments
        Start-Process -FilePath powershell -Verb Runas -ArgumentList $CommandLine
        Exit
    }
}

# Try to resolve 7-Zip installation path
$RegistryPath = 'HKCU:\SOFTWARE\7-Zip'
$7ZipPath = $null

if ($path = Get-ItemProperty -Path $RegistryPath -Name 'Path64' -ErrorAction SilentlyContinue) {
    $7ZipPath = $path.Path64
}
elseif ($path = Get-ItemProperty -Path $RegistryPath -Name 'Path' -ErrorAction SilentlyContinue) {
    $7ZipPath = $path.Path
}

if (! (Test-Path "$7ZipPath\7z.exe")) {
    Write-Host -ForegroundColor Yellow "Couldn't find 7-Zip. Make sure it is installed correctly and try again."
    Pause
    Exit
}

# Create dummy shortcuts
$DesktopPath = [Environment]::GetFolderPath('Desktop')
Set-Location $DesktopPath

$DummyFileName = 'Dummy (right-click - Properties - Change...)'
New-Item "$DummyFileName.7z" -Force | Out-Null
New-Item "$DummyFileName.rar" -Force | Out-Null
New-Item "$DummyFileName.zip" -Force | Out-Null

# Add 7-Zip to Path
if (! (Get-Command 7z -ErrorAction SilentlyContinue)) {
    $env:Path += ";$7ZipPath"
    [Environment]::SetEnvironmentVariable('Path', $env:Path, [System.EnvironmentVariableTarget]::Machine)
}

# Tweak settings
$RegistryPath = 'HKCU:\SOFTWARE\7-Zip\Options'
$Name = 'ContextMenu'
$Value = '4359'

if (! (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath | Out-Null
}

New-ItemProperty -Path $RegistryPath -Name $Name -Value $Value -PropertyType DWORD -Force | Out-Null
