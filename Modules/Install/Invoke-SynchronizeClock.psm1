function Invoke-SynchronizeClock {
	sc.exe stop w32time | Out-Null
    Start-Sleep -s 1
	sc.exe start w32time | Out-Null
    Start-Sleep -s 3
    w32tm /config /update | Out-Null
    Start-Sleep -s 1
    w32tm /resync /rediscover | Out-Null
    Start-Sleep -s 1
    w32tm /resync /force | Out-Null
}
