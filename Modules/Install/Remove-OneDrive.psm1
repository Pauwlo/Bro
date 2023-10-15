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
