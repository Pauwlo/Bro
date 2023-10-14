$OutputFile = 'Bro.ps1'

# This script needs to run from the parent directory.
if ((Get-Location).ToString().EndsWith('Scripts')) {
	Set-Location '..'
}

if (Test-Path $OutputFile) {
	Remove-Item $OutputFile -Force
}

$Now = Get-Date
Write-Output "# This file was automatically generated on $Now." | Out-File $OutputFile

$Logo = Get-Content 'Stuff\Logo.txt' -Raw
$Logo = "`$global:Logo = @'`r`n" + $Logo + "`r`n'@"
Write-Output $Logo | Out-File $OutputFile -Append

Get-ChildItem .\Modules -File -Recurse | ForEach-Object {
    Get-Content $_.FullName | Out-File ./$OutputFile -Append
}

Get-Content 'Scripts\Start.ps1' | Out-File $OutputFile -Append
