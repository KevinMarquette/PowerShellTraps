
$Version = $PSVersionTable.PSVersion.Major

task Test-1.Environment {
	($r = try {.\Test-1.Environment.ps1} catch {$_})
	equals $r.FullyQualifiedErrorId 'NotSupported,Microsoft.PowerShell.Commands.GetChildItemCommand'
}

task Test-2.1.FileSystem {
	($r = .\Test-2.1.FileSystem.ps1)
	assert ($r -contains 'tmp')
}

# TODO skip v6-beta.1, try later
# win10, v6: OK (but OSVersion check gets 6!)
# win81, v6: still KO
task -If ($Version -ne 6) Test-2.2.FileSystem {
	($r = .\Test-2.2.FileSystem.ps1)

	# fixed in Windows 10?
	if ([Environment]::OSVersion.Version.Major -ge 10) {
		equals ($r -join '|') 'tmp.tmp|True'
	}
	else {
		equals ($r -join '|') 'tmp.tmp|tmp.tmp2|False'
	}
}
