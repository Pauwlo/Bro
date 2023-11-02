# From https://stackoverflow.com/questions/59996907/how-to-take-a-remote-screenshot-with-powershell
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing

function Invoke-TakeScreenshot {

	Param(
		[Parameter(Mandatory = $true)]
		[String]
		$OutputPath
	)

	$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen

	$Bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height

	$Graphic = [System.Drawing.Graphics]::FromImage($Bitmap)

	# Show the desktop
	$ShellAppObject = New-Object -ComObject Shell.Application
	$ShellAppObject.toggleDesktop()
	$ShellScriptObject = New-Object -ComObject WScript.Shell
	$ShellScriptObject.SendKeys("^{ESC}")

	Start-Sleep 1

	$Graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $Bitmap.Size)
	
	$Bitmap.Save("$OutputPath\Screenshot.png")
}
