function Get-Menu {
	$Prompt = 'Do you want to [I]nstall, [U]pdate, [B]ackup or [Q]uit?'
	Write-Host "Hi. $Prompt"

	$Selection = [System.Console]::ReadKey($true)

	while ($Selection.KeyChar -notin @('b', 'i', 'q', 'u')) {
		Write-Host "No. $Prompt"
		$Selection = [System.Console]::ReadKey($true)
	}

	switch ($Selection.KeyChar) {
		b { return 0 }
		i { return 1 }
		u { return 2 }
		q { return 9 }
	}
}
