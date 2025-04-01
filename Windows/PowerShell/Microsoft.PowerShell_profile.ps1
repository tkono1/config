# Configure PSReadLine.
if (Get-InstalledPSResource -Name 'PSReadLine') {
    Import-Module -Name PSReadLine

    if (Get-InstalledPSResource -Name 'CompletionPredictor') {
        Import-Module -Name CompletionPredictor
    }

    $PSROptions = @{
        EditMode = "Emacs"
        PredictionSource = "HistoryAndPlugin"
        PredictionViewStyle = "ListView"
        Colors = @{
            Operator = "`e[36m"
            Parameter = "`e[36m"
        }
    }
    Set-PSReadLineOption @PSROptions
}

# Install-Module -Name posh-git -Scope CurrentUser -Force
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
if (Get-InstalledPSResource -Name 'posh-git') {
    Import-Module -Name posh-git

    $GitPromptSettings.DefaultPromptPrefix.Text = "PS "
    $GitPromptSettings.DefaultPromptPrefix.ForegroundColor = '0x00BFFF' # DeepSkyBlue
    $GitPromptSettings.DefaultPromptPath.ForegroundColor = '0x40E0D0' # Turquoise
    $GitPromptSettings.DefaultPromptSuffix.ForegroundColor = '0x00BFFF' # DeepSkyBlue
} else {
    [string]$StartOfColor = "$([char]27)[38;5;"
    [string]$EndOfColor = "$([char]27)[0m"

    $out = "${StartOfColor}45mPS ${EndOfColor}${StartOfColor}51m${PWD}>${$EndOfColor} "
}

if ($env:TERM_PROGRAM -ne 'vscode') {
    $Global:__LastHistoryId = -1

    function prompt {
        [string]$ESC07 = "$([char]07)"
        [string]$OSC133 = "`e]133"

        $FakeCode = [int]!$global:?
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
                $Result += "${OSC133};D;${FakeCode}`a"
            }
        }

        # Prompt started
        $Result += "${OSC133};A${ESC07}"
        # Current Working Directory
        $Result += "`e]9;9;`"${PWD}`"${ESC07}"

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