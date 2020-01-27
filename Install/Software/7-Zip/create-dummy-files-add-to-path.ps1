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

$DesktopPath = [Environment]::GetFolderPath('Desktop')
Set-Location $DesktopPath

$DummyFileName = 'Dummy (right-click - Properties - Change...)'
Write-Output $null | Out-File "$DummyFileName.7z"
Write-Output $null | Out-File "$DummyFileName.rar"
Write-Output $null | Out-File "$DummyFileName.zip"

# Check if 7-Zip is already in Path
if (Get-Command 7z -ErrorAction SilentlyContinue) {
    Write-Host -ForegroundColor Yellow "7-Zip is already in Path."
    Pause
    Exit
}

# Try to resolve 7-Zip installation path
$Default7ZipPathX86 = 'C:\Program Files (x86)\7-Zip'
$Default7ZipPathX64 = 'C:\Program Files\7-Zip'
$7ZipPath = $null

if (Test-Path $Default7ZipPathX64) {
    $7ZipPath = $Default7ZipPathX64
} elseif (Test-Path $Default7ZipPathX86) {
    $7ZipPath = $Default7ZipPathX86
} else {
    $7ZipPath = Read-Host -Prompt "7-Zip installation folder"
}

$7ZipPath = $7ZipPath.TrimEnd('\')

if (! (Test-Path "$7ZipPath\7z.exe")) {
    Write-Host -ForegroundColor Yellow "Couldn't find 7-Zip executable: $7ZipPath\7z.exe"
    Pause
    Exit
}

# Add 7-Zip to Path
$env:Path += ";$7ZipPath"
[Environment]::SetEnvironmentVariable('Path', $env:Path, [System.EnvironmentVariableTarget]::Machine)
