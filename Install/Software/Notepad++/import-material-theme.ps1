# Import Material theme for Notepad++

$NotepadPlusPlusPath = "$env:AppData\Notepad++"
$ThemesPath = "$NotepadPlusPlusPath\themes"

if (Test-Path "$ThemesPath\Material.xml") {
    Write-Host -ForegroundColor Yellow "A theme called Material already exists."
    Pause
    Exit
}

if (! (Test-Path $ThemesPath)) {
    New-Item -ItemType Directory $ThemesPath | Out-Null
}

Copy-Item Material.xml $ThemesPath
