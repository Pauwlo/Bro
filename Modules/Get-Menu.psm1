function Get-Menu {
	$Prompt = 'Do you want to [I]nstall, [B]ackup or [Q]uit?'
	Write-Host "Hi. $Prompt"

	$Selection = [System.Console]::ReadKey($true)

	while ($Selection.KeyChar -notin @('b', 'i', 'q')) {
		Write-Host "No. $Prompt"
		$Selection = [System.Console]::ReadKey($true)
	}

	switch ($Selection) {
		b { return 0 }
		i { return 1 }
		q { return 9 }
	}
}
