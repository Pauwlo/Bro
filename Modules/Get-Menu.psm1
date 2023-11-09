function Get-Menu {
	$Prompt = 'Do you want to [D]ebloat, [I]nstall, [U]pdate, [B]ackup or [Q]uit?'
	Write-Host "Hi. $Prompt"

	$Selection = [System.Console]::ReadKey($true)

	while ($Selection.KeyChar -notin @('b', 'd', 'i', 'q', 'u')) {
		Write-Host "No. $Prompt"
		$Selection = [System.Console]::ReadKey($true)
	}

	switch ($Selection.KeyChar) {
		b { return 0 }
		d { return 1 }
		i { return 2 }
		u { return 3 }
		q { return 9 }
	}
}
