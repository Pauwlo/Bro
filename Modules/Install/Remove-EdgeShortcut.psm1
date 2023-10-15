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
