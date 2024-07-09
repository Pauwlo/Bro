function Invoke-CleanShortcuts {
	$StartMenu = "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs"
	$PublicDesktop = 'C:\Users\Public\Desktop'

	if (Test-Path "$StartMenu\7-Zip\7-Zip File Manager.lnk") {
		Move-Item "$StartMenu\7-Zip\7-Zip File Manager.lnk" "$StartMenu\7-Zip.lnk" -Force
		Remove-Item "$StartMenu\7-Zip" -Recurse
	}
	
	if (Test-Path "$StartMenu\VideoLAN\VLC\VLC media player.lnk") {
		Move-Item "$StartMenu\VideoLAN\VLC\VLC media player.lnk" "$StartMenu\VLC.lnk" -Force
		Remove-Item "$StartMenu\VideoLAN" -Recurse
	}
	
	if (Test-Path "$StartMenu\VideoLAN\VLC media player.lnk") {
		Move-Item "$StartMenu\VideoLAN\VLC media player.lnk" "$StartMenu\VLC.lnk" -Force
		Remove-Item "$StartMenu\VideoLAN" -Recurse
	}

	foreach ($Shortcut in @(
		'Firefox'
		'VLC media player'
	)) {
		if (Test-Path "$PublicDesktop\$Shortcut.lnk") {
			Remove-Item "$PublicDesktop\$Shortcut.lnk"
		}
	}
}
