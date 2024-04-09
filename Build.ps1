$OutputFile = 'Bro.ps1'

if (Test-Path $OutputFile) {
	Remove-Item $OutputFile -Force
}

$Now = Get-Date
Write-Output "# This file was automatically generated on $Now." | Out-File $OutputFile

Write-Output "# <config placeholder>" | Out-File $OutputFile -Append

$Logo = Get-Content 'Stuff\Logo.txt' -Raw
$Logo = "`$global:Logo = @'`r`n" + $Logo + "`r`n'@`r`n"
Write-Output $Logo | Out-File $OutputFile -Append

$DefaultConfig = Get-Content 'Stuff\Config.json' -Raw
$DefaultConfig = "`$DefaultConfig = @'`r`n" + $DefaultConfig + "`r`n'@`r`n"
Write-Output $DefaultConfig | Out-File $OutputFile -Append

Get-ChildItem .\Modules -File -Recurse | ForEach-Object {
	Get-Content $_.FullName -Raw | Out-File ./$OutputFile -Append
}

@'
Grant-AdministratorPrivileges $MyInvocation

$OriginalFolder = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $OriginalFolder

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
'@ | Out-File $OutputFile -Append

$OutputPath = ((Get-Item $PSScriptRoot).Parent).ToString() + '\' + $OutputFile
Write-Host "Bro script built successfully to $OutputPath"
