function Disable-FocusAssist {
	$Prefix = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\$quietmoment'
    $Suffix = '$windows.data.notifications.quietmoment\Current'
    $FocusAssistRules = @(
        'presentation',
        'game',
        'fullscreen',
        'postoobe'
    )
    $Name = 'Data'

    foreach ($Rule in $FocusAssistRules) {
        $Data = (Get-ItemProperty -Path "$Prefix$Rule$Suffix" -Name $Name -ErrorAction SilentlyContinue).$Name

        if ($Data) {
            if ($Data[22] -eq 1 -and $Data[23] -eq 194 -and $Data[24] -eq 20) {
                $Data = $Data[0..21] + $Data[25..($Data.Length - 1)] # Remove 3 bytes at 0x0016
                Set-ItemProperty -Path "$Prefix$Rule$Suffix" -Name $Name -Value $Data
            }
        }
    }
}
