$OutputFile = 'Bro.ps1'

if (Test-Path $OutputFile) {
	Remove-Item $OutputFile -Force
}

$Now = Get-Date
Write-Output "# This file was automatically generated on $Now." | Out-File $OutputFile

Get-Content 'Config.ps1' -Raw | Out-File $OutputFile -Append

$Logo = Get-Content 'Stuff\Logo.txt' -Raw
$Logo = "`$global:Logo = @'`r`n" + $Logo + "`r`n'@`r`n"
Write-Output $Logo | Out-File $OutputFile -Append

Get-ChildItem .\Modules -File -Recurse | ForEach-Object {
    Get-Content $_.FullName -Raw | Out-File ./$OutputFile -Append
}

@'
Grant-AdministratorPrivileges $MyInvocation

Get-Logo
$Selection = Get-Menu

Start-Transcript $env:TMP\Bro.log -Append | Out-Null

switch ($Selection) {
    0 {
        Invoke-Backup
    }
    1 {
        Invoke-Install
    }
    9 {
        Stop-Bro
    }
}
'@ | Out-File $OutputFile -Append

$OutputPath = ((Get-Item $PSScriptRoot).Parent).ToString() + "\Bro.ps1"
Write-Host "Bro script built successfully to $OutputPath"
