## Each hosts settings ##

if ($host.Name -eq 'ConsoleHost') {
    if (Get-Module -ListAvailable -Name 'PSReadLine') {
        Import-Module PSReadLine
        Set-PSReadlineOption -EditMode Emacs
        Set-PSReadLineOption -PredictionSource History
    }
    if (get-Module -ListAvailable -Name 'posh-git') {
        Import-Module posh-git
    }
} elseif ($host.Name -eq 'Vusual Studio Code Host') {
    if (Get-Module -ListAvailable -Name 'PSReadLine') {
        Import-Module PSReadline
        #Set-PSReadlineOption -EditMode Emacs
    }
}

## Defining functions ##

function prompt () {
        [string]$isAdmin = '>'
        [string]$PromptColor1 = 'DarkGreen'
        [string]$PromptColor2 = 'DarkCyan'

    if (Get-Module -Name 'posh-git') {
        $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
        $GitPromptSettings.DefaultPromptPrefix.Text = "[$(($env:USERNAME).ToLower())@$(($env:COMPUTERNAME).ToLower())]"
        $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::${PromptColor1}
        $GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::${PromptColor2}
        $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::${PromptColor1}

        & $GitPromptScriptBlock
    } else {
        [string]$isAdmin = '>'
        [string]$PromptColor1 = 'DarkGreen'
        [string]$PromptColor2 = 'DarkCyan'

        Write-Host ("[$(($env:USERNAME).ToLower())@$(($env:COMPUTERNAME).ToLower()):") -ForegroundColor $PromptColor1 -NoNewline
        Write-Host ((Get-Location).Path).Replace($HOME, '~') -ForegroundColor $PromptColor2 -NoNewline
        Write-Host ("]" + $isAdmin) -ForegroundColor $PromptColor1 -NoNewline
        Return " "
    }
}

function which {
        [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $CommandName
    )
    begin {}
    Process {
        (Get-Command -ErrorAction SilentlyContinue -Name $CommandName).Definition
    }
    end {}
}