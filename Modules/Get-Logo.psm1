function Get-Logo {
    $Host.UI.RawUI.WindowTitle = 'Bro'
    Clear-Host
    Write-Host $global:Logo
}
