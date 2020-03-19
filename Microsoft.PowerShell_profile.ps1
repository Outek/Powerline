#Requires -Version 7

# Version 1.0.6

# check if newer version
$gistUrl = "https://api.github.com/gists/569c2288c015150eba622e860a4a6d2b"
$latestVersionFile = Join-Path -Path ~ -ChildPath ".latest_profile_version"
$versionRegEx = "# Version (?<version>\d+\.\d+\.\d+)"

if (Test-Path $latestVersionFile) {
  $latestVersion = Get-Content $latestVersionFile
  $currentProfile = Get-Content $profile -Raw
  [version]$currentVersion = "0.0.0"
  if ($currentProfile -match $versionRegEx) {
    $currentVersion = $matches.Version
  }

  if ($latestVersion -gt $currentVersion) {
    Write-Verbose "Your version: $currentVersion" -Verbose
    Write-Verbose "New version: $latestVersion" -Verbose
    $choice = Read-Host -Prompt "Found newer profile, install? (Y)"
    if ($choice -eq "Y" -or $choice -eq "") {
      try {
        $gist = Invoke-RestMethod $gistUrl -ErrorAction Stop
        $gistProfile = $gist.Files."profile.ps1".Content
        Set-Content -Path $profile -Value $gistProfile
        Write-Verbose "Installed newer version of profile" -Verbose
        . $profile
        return
      }
      catch {
        # we can hit rate limit issue with GitHub since we're using anonymous
        Write-Verbose -Verbose "Was not able to access gist, try again next time"
      }
    }
  }
}

$null = Start-ThreadJob -Name "Get version of `$profile from gist" -ArgumentList $gistUrl, $latestVersionFile, $versionRegEx -ScriptBlock {
  param ($gistUrl, $latestVersionFile, $versionRegEx)

  try {
    $gist = Invoke-RestMethod $gistUrl -ErrorAction Stop

    $gistProfile = $gist.Files."profile.ps1".Content
    [version]$gistVersion = "0.0.0"
    if ($gistProfile -match $versionRegEx) {
      $gistVersion = $matches.Version
      Set-Content -Path $latestVersionFile -Value $gistVersion
    }
  }
  catch {
    # we can hit rate limit issue with GitHub since we're using anonymous
    Write-Verbose -Verbose "Was not able to access gist to check for newer version"
  }
}

if ($IsWindows) {
  Set-PSReadLineKeyHandler -Chord Ctrl+Shift+c -Function Copy
  Set-PSReadLineKeyHandler -Chord Ctrl+Shift+v -Function Paste
}

Set-PSReadLineKeyHandler -Chord Ctrl+b -Function BackwardWord

function prompt {
  # set window title
  try {
    if ($isWindows) {
      $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
      $windowsPrincipal = [Security.Principal.WindowsPrincipal]::new($identity)
      if ($windowsPrincipal.IsInRole("Administrators") -eq 1) {
        $prefix = "Admin:"
      }
    }

    $Host.ui.RawUI.WindowTitle = "$prefix$PWD"
  } catch {
    # do nothing if can't be set
  }
}

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox_Sigi
