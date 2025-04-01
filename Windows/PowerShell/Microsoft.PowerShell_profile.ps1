# Configure PSReadLine.
if (Get-InstalledPSResource -Name 'PSReadLine') {
    Import-Module -Name PSReadLine

    if (Get-InstalledPSResource -Name 'CompletionPredictor') {
        Import-Module -Name CompletionPredictor
    } else {
        Install-Module -Name CompletionPredictor -Scope CurrentUser -Force `
        && Import-Module -Name CompletionPredictor
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

if (Get-InstalledPSResource -Name 'posh-git') {
    Import-Module -Name posh-git
} else {
    Install-Module -Name posh-git -Scope CurrentUser -Force `
    && Import-Module -Name posh-git
}
# https://github.com/dahlbyk/posh-git/wiki/Customizing-Your-PowerShell-Prompt
$GitPromptSettings.DefaultPromptPrefix.Text = "PS "
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = '0x00BFFF' # DeepSkyBlue
$GitPromptSettings.DefaultPromptPath.ForegroundColor = '0x40E0D0' # Turquoise
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = '0x00BFFF' # DeepSkyBlue

if (((get-process -Id $PID).Parent).ProcessName -eq 'WindowsTerminal') {
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

        $Global:__OriginalPrompt = ${GitPromptScriptBlock}
        $Result += $Global:__OriginalPrompt.Invoke()

        # Prompt ended, Command started
        $Result += "${OSC133};B${ESC07}"
        $Global:__LastHistoryId = $LastHistoryEntry.Id

        return $Result
    }
} elseif (((get-process -Id $PID).Parent).ProcessName -eq 'Code') {
    function prompt () {    
        & $GitPromptScriptBlock
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