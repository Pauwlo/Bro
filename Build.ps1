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

$Init = Get-Content 'Init.ps1'
Write-Output $Init | Out-File $OutputFile -Append

Import-Module '.\Modules\Test-Feature.psm1'
Import-Module '.\Modules\Test-ValidateConfig.psm1'
Import-Module '.\Modules\Get-Config.psm1'
$global:Config = Get-Config 'Stuff\Config.json'
Test-ValidateConfig | Out-Null

$OutputPath = ((Get-Item $PSScriptRoot).Parent).ToString() + '\' + $OutputFile
Write-Host "Bro script built successfully to $OutputPath"
