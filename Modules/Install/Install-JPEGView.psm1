function Install-JPEGView {
	$StartMenuPath = "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs"

	$JPEGViewUrl = 'https://github.com/sylikc/jpegview/releases/download/v1.3.46/JPEGView_1.3.46.zip'
	$JPEGViewZipFilePath = 'JPEGView.zip'
	$JPEGViewZipExtractPath = "$env:Tmp\JPEGView"
	$JPEGViewInstallPath = "$env:ProgramFiles\JPEGView"

	Start-BitsTransfer -Source $JPEGViewUrl -Destination $JPEGViewZipFilePath
	Expand-Archive -Path $JPEGViewZipFilePath -Destination $JPEGViewZipExtractPath
	Remove-Item $JPEGViewZipFilePath

	New-Item $JPEGViewInstallPath -ItemType Directory | Out-Null
	Move-Item "$JPEGViewZipExtractPath\JPEGView64\*" $JPEGViewInstallPath
	Remove-Item $JPEGViewZipExtractPath -Recurse

	# Fix permissions for all users
	icacls $JPEGViewInstallPath /inheritance:e /grant "*S-1-5-32-545:(OI)(CI)RX" /T /C | Out-Null

	New-Shortcut "$StartMenuPath\JPEGView.lnk" "$JPEGViewInstallPath\JPEGView.exe"

	$MachinePath = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ";$JPEGViewInstallPath"
	[Environment]::SetEnvironmentVariable('Path', $MachinePath, [EnvironmentVariableTarget]::Machine)

	$ConfigFilePath = "$env:AppData\JPEGView\JPEGView.ini"
	$KeymapFileFilePath = "$JPEGViewInstallPath\KeyMap.txt.default"
	$ConfigFile = Get-Content "$JPEGViewInstallPath\JPEGView.ini.tpl" -Raw
	$KeymapFile = Get-Content $KeymapFileFilePath -Raw

	$ConfigFile = $ConfigFile.Replace('FilesProcessedByWIC=*.wdp;*.hdp;*.jxr', 'FilesProcessedByWIC=*.wdp;*.hdp;*.jxr;*.heic')
	$ConfigFile = $ConfigFile.Replace('ShowFullScreen=auto', 'ShowFullScreen=false')
	$ConfigFile = $ConfigFile.Replace('IsSortedUpcounting=true', 'IsSortedUpcounting=false')
	New-Item (Split-Path $ConfigFilePath) -ItemType Directory | Out-Null
	New-Item $ConfigFilePath | Out-Null
	Set-Content $ConfigFilePath $ConfigFile

	$KeymapFile = $KeymapFile.Replace('   IDM_MOVE_TO_RECYCLE_BIN_CONFIRM', '   IDM_MOVE_TO_RECYCLE_BIN')
	Set-Content $KeymapFileFilePath $KeymapFile
}
