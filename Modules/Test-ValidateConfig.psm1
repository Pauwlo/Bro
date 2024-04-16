function Test-ValidateConfig {
	$ErrorCount = 0

	if (Test-Feature common.hideRecentFilesInExplorer) {
		if (-not (Test-Feature common.patchRegistry)) {
			Write-Warning 'Hiding recently used files and folders requires "Patch registry" to be enabled. Please set "common.patchRegistry" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature common.openExplorerWithThisPC) {
		if (-not (Test-Feature common.patchRegistry)) {
			Write-Warning 'Opening Explorer with "This PC" requires "Patch registry" to be enabled. Please set "common.patchRegistry" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installChocolatey) {
		if (-not (Test-Feature install.installSoftware)) {
			Write-Warning 'Installing Chocolatey requires "Install Software" to be enabled. Please set "install.installSoftware" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installChocolateyPackages) {
		if (-not (Test-Feature install.installSoftware)) {
			Write-Warning 'Installing Chocolatey packages requires "Install Software" to be enabled. Please set "install.installSoftware" to "true" and try again.'
			$ErrorCount++
		}

		if (-not (Test-Feature install.installChocolatey)) {
			Write-Warning 'Installing Chocolatey packages requires Chocolatey. Please set "install.installChocolatey" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installWinGet) {
		if (-not (Test-Feature install.installSoftware)) {
			Write-Warning 'Installing Winget requires "Install Software" to be enabled. Please set "install.installSoftware" to "true" and try again.'
			$ErrorCount++
		}

		if (-not (Test-Feature install.installChocolatey)) {
			Write-Warning 'Installing WinGet requires Chocolatey. Please set "install.installChocolatey" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature install.installWinGetPackages) {
		if (-not (Test-Feature install.installWinGet)) {
			Write-Warning 'Installing WinGet packages requires WinGet. Please set "install.installWinGet" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature update.updateChocolateyPackages) {
		if (-not (Test-Feature update.updateSoftware)) {
			Write-Warning 'Updating Chocolatey packages requires "Update Software" to be enabled. Please set "update.updateSoftware" to "true" and try again.'
			$ErrorCount++
		}
	}

	if (Test-Feature update.updateWinGetPackages) {
		if (-not (Test-Feature update.updateSoftware)) {
			Write-Warning 'Updating WinGet packages requires "Update Software" to be enabled. Please set "update.updateSoftware" to "true" and try again.'
			$ErrorCount++
		}
	}

	return $ErrorCount -eq 0
}