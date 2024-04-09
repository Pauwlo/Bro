function Invoke-BackupUserFolders {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$OutputPath
	)

	$ShellAppObject = New-Object -ComObject Shell.Application
	
	$Desktop	= [Environment]::GetFolderPath('Desktop')
	$Downloads	= $ShellAppObject.NameSpace('shell:Downloads').Self.Path
	$Documents	= [Environment]::GetFolderPath('MyDocuments')
	$Pictures	= [Environment]::GetFolderPath('MyPictures')
	$Music		= [Environment]::GetFolderPath('MyMusic')
	$Videos		= [Environment]::GetFolderPath('MyVideos')

	$BackupFolders = @(
		@{
			Source = $Desktop
			Destination = 'Desktop'
		},
		@{
			Source = $Downloads
			Destination = 'Downloads'
		},
		@{
			Source = $Documents
			Destination = 'Documents'
		},
		@{
			Source = $Pictures
			Destination = 'Pictures'
		},
		@{
			Source = $Music
			Destination = 'Music'
		},
		@{
			Source = $Videos
			Destination = 'Videos'
		}
	)

	$BackupFolders | ForEach-Object {
		$destination = $_.Destination.ToLower()

		if ($Config.backupFolders.$destination -eq $true) {
			Write-Host "Saving user $destination..."
			$Destination = "$OutputPath\" + $_.Destination
			Copy-Item $_.Source $Destination -Force -Recurse
		}
	}
}
