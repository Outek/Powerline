# Installation of Powerline, Fonts, Powershell Profile and more

## Files

#### Microsoft.PowerShell_profile.ps1
Powershell profile

#### profiles.json
Windows Terminal configurations
 
#### Paradox_Sigi.psm1
Modified Paradox Theme from Powerline

#### settings.json
Personal vscode settings

## Install needed fonts

Install all Cascadia Code Fonts
[GitHub Repo](https://github.com/microsoft/cascadia-code/releases

## Install oh-my-posh

Download file from Github
[oh-my-posh/releases](https://github.com/JanDeDobbeleer/oh-my-posh/releases)

install file

## Copy Paradox_Sigi 

Copy the file to theme folder or 'C:\Program Files\WindowsPowerShell\Modules\oh-my-posh\2.0.230\Themes'
or
```powershell

C:\Program Files (x86)\oh-my-posh\themes

```

## Configure Powershell Profile

```Powershell

if (!(Test-Path -Path $PROFILE )) { New-Item -Type File -Path $PROFILE -Force }
notepad $PROFILE
```

and copy this lines to theProfiles file

```powershell
oh-my-posh init pwsh --config "C:\Program Files (x86)\oh-my-posh\themes\paradox_sigi.omp.json" | Invoke-Expression
```


## Configure vscode to use the font

```Powershell

{
    "workbench.startupEditor": "newUntitledFile",
    "editor.fontSize": 16,
    "editor.fontFamily": "'Cascadia Code PL', Consolas, 'Courier New', monospace",
    "debug.console.fontSize": 16,
    "markdown.preview.fontSize": 16,
    "terminal.integrated.fontSize": 16,
    "editor.renderWhitespace": "all",
    "extensions.ignoreRecommendations": true,
    "go.formatTool": "goimports",
    "go.useLanguageServer": true
}

```

## Configure Microsoft Terminal to use the font

```Powershell
    "profiles": 
    {
        "defaults": {
	           "font":
            {
                "face": "Cascadia Code PL"
            }
		     },
    }
```
