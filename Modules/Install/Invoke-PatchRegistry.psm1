function Invoke-PatchRegistry {
    $FilePath = "$env:TMP\Bro_Tweaks.reg"

	Get-Asset RegistryFile $FilePath | Out-Null

    reg import $FilePath 2>&1 | Out-Null

    Remove-Item $FilePath

    Stop-Process -Name explorer
}
