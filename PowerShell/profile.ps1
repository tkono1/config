#
## PowerShell modules ##
#
# Install-Module -Name posh-git -Scope CurrentUser -Force
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt

if ($host.Name -eq 'ConsoleHost') {
    if (Get-Module -ListAvailable -Name 'PSReadLine') {
        Import-Module PSReadLine
        Set-PSReadlineOption -EditMode Emacs
        Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
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

#
## Defining functions ##
#

function prompt () {
    [string]$RgbPromptColor1 = '0x00BFFF' # DeepSkyBlue
    [string]$RgbPromptColor2 = '0x40E0D0' # Turquoise

    [string]$PromptUsername = ($env:USERNAME).ToLower()
    [string]$PromptComputername = ($env:COMPUTERNAME).ToLower()
    [string]$isAdmin = '>'

    if (Get-Module -Name 'posh-git') {
        $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
        $GitPromptSettings.DefaultPromptPrefix.Text = "[$($PromptUsername)@$($PromptComputername)]"
        $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = ${RgbPromptColor1}
        $GitPromptSettings.DefaultPromptPath.ForegroundColor = ${RgbPromptColor2}
        $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = ${RgbPromptColor1}
        $GitPromptSettings.DefaultPromptSuffix.Text = "$($isAdmin * ($nestedPromptLevel + 1)) "

        & $GitPromptScriptBlock
    } else {
        [string]$PromptColor1 = 'Blue'
        [string]$PromptColor2 = 'DarkCyan'

        Write-Host ("[$($PromptUsername)@$($PromptComputername):") -ForegroundColor $PromptColor1 -NoNewline
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
        (Get-Command -ErrorAction SilentlyContinue -Name ${CommandName}).Definition
    }
    end {}
}