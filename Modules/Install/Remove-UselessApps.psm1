function Remove-UselessApps {
	$UselessApps = $Config['UselessApps']

	foreach ($App in $UselessApps) {
		$ProPackageFullName = (Get-AppxProvisionedPackage -Online | Where-Object { $_.Displayname -eq $App }).PackageName

		if ($ProPackageFullName) {
			Remove-AppxProvisionedPackage -Online -PackageName $ProPackageFullName | Out-Null -ErrorAction SilentlyContinue
		}
	}

	foreach ($App in $UselessApps) {
		$PackageFullName = (Get-AppxPackage $App).PackageFullName

		foreach ($Package in $PackageFullName) {
			Remove-AppxPackage -Package $Package -ErrorAction SilentlyContinue
		}
	}
}
