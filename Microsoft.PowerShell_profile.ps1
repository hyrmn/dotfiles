Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-a4faccd\src\posh-git.psd1'

# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($pwd.ProviderPath) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
	
	& "$env:ConEmuBaseDir\ConEmuC.exe" "/GUIMACRO", 'Rename(0,@"'$(Get-Location)'")' > $null
	
    return "> "
}

function Get-Batchfile ($file) {
	$cmd = "`"$file`" & set"
	cmd /c $cmd | Foreach-Object {
		$p, $v = $_.split('=')
		Set-Item -path env:$p -value $v
	}
}

function Load-VsTools()
{
	$batchFile = [System.IO.Path]::Combine($env:VS140COMNTOOLS, "VsDevCmd.bat") 

	Get-Batchfile -file $batchFile

	Write-Host -ForegroundColor 'Yellow' "VsVars has been loaded from: $batchFile"
}

Pop-Location

Load-VsTools

set-alias -name npp -value "${env:ProgramFiles(x86)}\Notepad++\notepad++.exe"
remove-item alias:curl -EA SilentlyContinue	


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

