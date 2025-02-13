#
## PowerShell modules ##
#
# Install-Module -Name posh-git -Scope CurrentUser -Force
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt

if ($host.Name -eq 'ConsoleHost') {
    if (Get-InstalledPSResource -Name 'PSReadLine') {
        Import-Module PSReadLine
        Set-PSReadlineOption -EditMode Emacs
        Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
    }
    if (Get-InstalledPSResource -Name 'posh-git') {
        Import-Module posh-git
    }
} elseif ($env:TERM_PROGRAM -eq 'vscode') {
    if (Get-InstalledPSResource -Name 'PSReadLine') {
        Import-Module PSReadline
        Set-PSReadlineOption -EditMode Emacs
    }
}

if ($env:TERM_PROGRAM -ne 'vscode') {
    $Global:__LastHistoryId = -1

    function prompt {
        [string]$Computername = ($env:COMPUTERNAME).ToLower()
        [string]$CWD = (Get-Location).Path
        [string]$ESC07 = "$([char]07)"

        $FakeCode = [int]!$global:?
        # NOTE: We disable strict mode for the scope of this function because it unhelpfully throws an
        # error when $LastHistoryEntry is null, and is not otherwise useful.
        Set-StrictMode -Off
        $LastHistoryEntry = Get-History -Count 1
        $Result = ""
        # Skip finishing the command if the first command has not yet started
        if ($Global:__LastHistoryId -ne -1) {
            if ($LastHistoryEntry.Id -eq $Global:__LastHistoryId) {
                # Don't provide a command line or exit code if there was no history entry (eg. ctrl+c, enter on no command)
                $Result += "`e]133;D`a"
            } else {
                # Command finished exit code
                # OSC 133 ; D [; <ExitCode>] ST
                $Result += "`e]133;D;${FakeCode}`a"
            }
        }

        # Prompt started
        $Result += "`e]133;A${ESC07}"
        # Current Working Directory
        $Result += "`e]9;9;`"${CWD}`"${ESC07}"
        
        # Prompt here
        [string]$RgbPromptColor1 = '0x00BFFF' # DeepSkyBlue
        [string]$RgbPromptColor2 = '0x40E0D0' # Turquoise

        if (Get-Module -Name 'posh-git') {
            #$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $$true
            $GitPromptSettings.DefaultPromptPrefix.Text = "[$($Computername)]"
            $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = $RgbPromptColor1
            $GitPromptSettings.DefaultPromptPath.ForegroundColor = $RgbPromptColor2
            $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = $RgbPromptColor1
            $GitPromptSettings.DefaultPromptSuffix.Text = "$('>' * ($nestedPromptLevel + 1)) "
            $Global:__OriginalPrompt = ${GitPromptScriptBlock}

            $Result += $Global:__OriginalPrompt.Invoke()
        } else {
            [string]$ESC27 = "$([char]27)"

            $Result += "${ESC27}[38;5;45m[${Computername}:${ESC27}[0m${ESC27}[38;5;140m${CWD}]$('>' * ($nestedPromptLevel + 1))${ESC27}[0m "
        }

        # Prompt ended, Command started
        $Result += "`e]133;B${ESC07}"
        $Global:__LastHistoryId = $LastHistoryEntry.Id

        return $Result
    } 
} elseif ($env:TERM_PROGRAM -eq 'vscode') {
    function prompt () {
        [string]$RgbPromptColor1 = '0x00BFFF' # DeepSkyBlue
        [string]$RgbPromptColor2 = '0x40E0D0' # Turquoise
    
        [string]$Computername = ($env:COMPUTERNAME).ToLower()
    
        if (Get-Module -Name 'posh-git') {
            #$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true
            $GitPromptSettings.DefaultPromptPrefix.Text = "[$($Computername)]"
            $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = $RgbPromptColor1
            $GitPromptSettings.DefaultPromptPath.ForegroundColor = $RgbPromptColor2
            $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = $RgbPromptColor1
            $GitPromptSettings.DefaultPromptSuffix.Text = "$('>' * ($nestedPromptLevel + 1)) "
    
            & $GitPromptScriptBlock
        } else {
            [string]$ESC27 = "$([char]27)"

            $out = "${ESC27}[38;5;45m[${Computername}:${ESC27}[0m${ESC27}[38;5;140m${CWD}]$('>' * ($nestedPromptLevel + 1))${ESC27}[0m "

            return $out
        }
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