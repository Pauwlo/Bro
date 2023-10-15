Get-AdministratorPrivileges $MyInvocation

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
