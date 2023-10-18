function Install-Fonts {
	$FilePath = "$env:TMP\Bro_Fonts.zip"
	$FontsPath = "$env:TMP\Bro_Fonts"
	$DesktopPath = [Environment]::GetFolderPath('Desktop')

	Get-AssetBits Fonts $FilePath | Out-Null

	Expand-Archive $FilePath $FontsPath
	Remove-Item $FilePath

	$Destination = "$DesktopPath\Fonts"
	New-Item $Destination -ItemType Directory | Out-Null

	Get-ChildItem -Path $FontsPath -Include *.ttf, *.otf -Recurse | ForEach-Object {
		Copy-Item $_ $Destination
	}

	Remove-Item $FontsPath -Recurse
}
