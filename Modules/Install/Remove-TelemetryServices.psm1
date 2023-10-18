function Remove-TelemetryServices {
	sc.exe stop DiagTrack | Out-Null
	sc.exe stop dmwappushservice | Out-Null
	sc.exe delete DiagTrack | Out-Null
	sc.exe delete dmwappushservice | Out-Null

	$LogPath = "$env:PROGRAMDATA\Microsoft\Diagnosis\ETLLogs\AutoLogger\AutoLogger-Diagtrack-Listener.etl"

	if (Test-Path $LogPath) {
		Remove-Item $LogPath -Force
	}

	New-Item $LogPath | Out-Null
}
