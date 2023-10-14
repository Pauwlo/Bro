function Get-Menu {
	$Prompt = 'Do you want to [I]nstall, [B]ackup or [Q]uit?'
	
	$Selection = Read-Host -Prompt "Hi. $Prompt"

	while ($Selection -notin @(
		'b', 'backup',
		'i', 'install',
		'q', 'quit')
	) {
		$Selection = Read-Host -Prompt "No. $Prompt"
	}

	switch ($Selection) {
		b { return 0 }
		backup { return 0 }
		i { return 1 }
		install { return 1 }
		q { return 9 }
		quit { return 9 }
	}
}
