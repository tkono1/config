#
## PowerShell modules ##
#
# Install-Module -Name posh-git -Scope CurrentUser -Force
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt

[string]$CWD = (Get-Location).Path

if (Get-InstalledPSResource -Name 'PSReadLine') {
    Import-Module PSReadLine
    Set-PSReadlineOption -EditMode Emacs
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
}

if (Get-InstalledPSResource -Name 'posh-git') {
    Import-Module posh-git

    [string]$RgbPromptColor1 = '0x00BFFF' # DeepSkyBlue
    [string]$RgbPromptColor2 = '0x40E0D0' # Turquoise

    $GitPromptSettings.DefaultPromptPrefix.Text = "PS "
    $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = $RgbPromptColor1
    $GitPromptSettings.DefaultPromptPath.ForegroundColor = $RgbPromptColor2
    $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = $RgbPromptColor1
    $GitPromptSettings.DefaultPromptSuffix.Text = "$('>' * ($nestedPromptLevel + 1)) "
} else {
    [string]$ESC27 = "$([char]27)"
    $out = "${ESC27}[38;5;45mPS ${ESC27}[0m${ESC27}[38;5;140m${CWD}$('>' * ($nestedPromptLevel + 1))${ESC27}[0m "
}

if ($env:TERM_PROGRAM -ne 'vscode') {
    $Global:__LastHistoryId = -1

    function prompt {
        [string]$ESC07 = "$([char]07)"
        [string]$OSC133 = "`e]133"

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
                $Result += "${OSC133};D`a"
            } else {
                # Command finished exit code
                # OSC 133 ; D [; <ExitCode>] ST
                $Result += "${OSC133};D;${FakeCode}`a"
            }
        }

        # Prompt started
        $Result += "${OSC133};A${ESC07}"
        # Current Working Directory
        $Result += "`e]9;9;`"${CWD}`"${ESC07}"

        if (Get-Module -Name 'posh-git') {
            $Global:__OriginalPrompt = ${GitPromptScriptBlock}
            $Result += $Global:__OriginalPrompt.Invoke()
        } else {
            $Result += $out
        }

        # Prompt ended, Command started
        $Result += "${OSC133};B${ESC07}"
        $Global:__LastHistoryId = $LastHistoryEntry.Id

        return $Result
    } 
} elseif ($env:TERM_PROGRAM -eq 'vscode') {
    function prompt () {    
        if (Get-Module -Name 'posh-git') {    
            & $GitPromptScriptBlock
        } else {
            $Result = $out

            return $Result
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