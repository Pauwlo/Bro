Get-AdministratorPrivileges $MyInvocation

Get-Logo
$Selection = Get-Menu

Start-Transcript $env:TMP\Bro.log -Append | Out-Null

switch ($Selection) {
    0 {
        Start-Backup
    }
    1 {
        Start-Install
    }
    9 {
        Stop-Bro
    }
}
