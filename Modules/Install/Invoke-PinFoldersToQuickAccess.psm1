function Invoke-PinFoldersToQuickAccess {
	$ShellAppObject = New-Object -ComObject Shell.Application
	$ShellAppObject.Namespace('shell:::{679F85CB-0220-4080-B29B-5540CC05AAB6}').Items() | ForEach-Object {
		$_.InvokeVerb('unpinfromhome')
	}

	$Folders = @(
		[Environment]::GetFolderPath('UserProfile'),
		[Environment]::GetFolderPath('Desktop'),
		$ShellAppObject.NameSpace('shell:Downloads').Self.Path,
		[Environment]::GetFolderPath('MyDocuments'),
		[Environment]::GetFolderPath('MyPictures'),
		[Environment]::GetFolderPath('MyMusic'),
		[Environment]::GetFolderPath('MyVideos')
	)

	foreach ($Folder in $Folders) {
		$ShellAppObject.Namespace($Folder).Self.InvokeVerb('pintohome')
	}
}
