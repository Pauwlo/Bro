function Import-Certificates {
	$FilePath = "$env:TMP\Bro_Certificates.zip"
	$CertificatesPath = "$env:TMP\Bro_Certificates"

	Get-AssetBits Certificates $FilePath | Out-Null

	Expand-Archive $FilePath $CertificatesPath
	Remove-Item $FilePath

	Get-ChildItem -Path $CertificatesPath -Filter *.crt | ForEach-Object {
		Import-Certificate -FilePath $_.FullName -CertStoreLocation Cert:\LocalMachine\Root | Out-Null
	}

	Remove-Item $CertificatesPath -Recurse
}
