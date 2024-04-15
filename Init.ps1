Grant-AdministratorPrivileges $MyInvocation

$OriginalFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition

if (Test-Path $OriginalFolder) {
	Set-Location $OriginalFolder
}

$Config = Get-Config

Get-Logo
$Selection = Get-Menu

Start-Transcript $env:TMP\Bro.log -Append | Out-Null

switch ($Selection) {
	0 {
		Invoke-Backup
	}
	1 {
		Invoke-Debloat
	}
	2 {
		Invoke-Install
	}
	3 {
		Invoke-Update
	}
	9 {
		Stop-Bro
	}
}
