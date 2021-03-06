$MyDir = Split-Path $MyInvocation.MyCommand.Definition

function SignExecutable {
	param
	(
		[string] $ExecutablePath,
		[string] $CertificateFilePath,
		[string] $CertificateFilePassword = ""
	)
	
	$SignToolPath = GetSignToolPath
	
	if ($CertificateFilePassword -eq "") {
	  &	$SignToolPath sign /f $CertificateFilePath $ExecutablePath | Write-Verbose
	} else {
	  &	$SignToolPath sign /f $CertificateFilePath /p $CertificateFilePassword $ExecutablePath | Write-Verbose
	}

	CheckError "Failed to sign $ExecutablePath"
}

function GetSignToolPath {
    $VerbosePreference = 'Continue'
	Write-Verbose "Looking for signtool.exe and starting from $MyDir"
	$SignToolExePath = Resolve-Path $MyDir"\Tools\SignTool\signtool.exe"
	Write-Verbose "Found signtool.exe at $SignToolExePath"
	return $SignToolExePath
}