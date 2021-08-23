## Each hosts settings ##
# How to install "posh-git" #
#Install-Module -Name posh-git -Scope CurrentUser -Force
<#https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt#>

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
    #[string]$RgbPromptColor1 = '0x00AF00' # 34, Green3
    [string]$RgbPromptColor1 = '0x5FAFFF' # 75, SteelBlue1
    #[string]$RgbPromptColor2 = '0x5FAFFF' # 75, SteelBlue1
    [string]$RgbPromptColor2 = '0x00D7AF' # 43, Cyan3
    [string]$PromptColor1 = 'Blue'
    [string]$PromptColor2 = 'DarkCyan'

    [string]$PromptUsername = ($env:USERNAME).ToLower()
    [string]$PromptComputername = ($env:COMPUTERNAME).ToLower()

    if (Get-Module -Name 'posh-git') {
        $GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
        $GitPromptSettings.DefaultPromptPrefix.Text = "[$($PromptUsername)@$($PromptComputername)]"
        $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = ${RgbPromptColor1}
        $GitPromptSettings.DefaultPromptPath.ForegroundColor = ${RgbPromptColor2}
        $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = ${RgbPromptColor1}

        & $GitPromptScriptBlock
    } else {
        [string]$isAdmin = '>'

        Write-Host ("[$($PromptUsername)@$($PromptComputername)):") -ForegroundColor $PromptColor1 -NoNewline
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