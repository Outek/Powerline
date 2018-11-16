# Installation von ConEmu, Powerline

## Install needed fonts

Install Powerline Fonts

Clone the powerline repository from GitHub.

git clone https://github.com/powerline/fonts.git

afterward, do the following:

```powershell

cd fonts
.\install.ps1

```

## Install Powershell Modules

```powershell

Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUse
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

```

## Configure Powershell Profile

```Powershell

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
notepad $PROFILE

```

Add these lines

Import-Module posh-git
Import-Module oh-my-posh
Set-Theme Paradox_Sigi

[Link](https://github.com/Jaykul/PowerLine/blob/acdb08698b71a40177c72c9d7aa4ee36c08f4c3d/README.md)
