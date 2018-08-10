set-alias -name npp -value "${env:ProgramFiles}\Notepad++\notepad++.exe"

remove-item alias:curl -EA SilentlyContinue	

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

