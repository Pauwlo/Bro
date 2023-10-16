function New-Shortcut {

    Param(
        [Parameter(Mandatory = $true)]
        [String]
        $Path,
        
        [Parameter(Mandatory = $true)]
        [String]
        $Target,
        
        [Parameter()]
        [String]
        $Arguments,
        
        [Parameter()]
        [String]
        $Icon
    )

    $WShellObject = New-Object -ComObject WScript.Shell
    $Shortcut = $WShellObject.CreateShortcut($Path)
    $Shortcut.TargetPath = $Target

    if ($Arguments) {
        $Shortcut.Arguments = $Arguments
    }

    if ($Icon) {
        $Shortcut.IconLocation = $Icon
    }

    $Shortcut.Save()
}
