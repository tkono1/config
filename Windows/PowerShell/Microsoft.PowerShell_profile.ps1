##Requires -Version 7

# Set Console output encoding to UTF-8.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

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

if ((([System.Diagnostics.Process]::GetCurrentProcess()).Parent).ProcessName -eq 'WindowsTerminal') {
    $Global:LastHistoryId = -1

    function prompt {
        $FakeCode = [int]!$global:?
        Set-StrictMode -Off
        $LastHistoryEntry = Get-History -Count 1
        [string]$Result = ""
        # Skip finishing the command if the first command has not yet started
        if ($Global:LastHistoryId -ne -1) {
            if ($LastHistoryEntry.Id -eq $Global:LastHistoryId) {
                # Don't provide a command line or exit code if there was no history entry (eg. ctrl+c, enter on no command)
                $Result += "`e]133;D`a"
            } else {
                # Command finished exit code
                $Result += "`e]133;D;${FakeCode}`a"
            }
        }

        # Prompt started
        $Result += "`e]133;A$([char]07)"

        # Current Working Directory
        $Result += "`e]9;9;`"${PWD}`"$([char]07)"

        $Global:OriginalPrompt = ${GitPromptScriptBlock}
        $Result += $Global:OriginalPrompt.Invoke()

        # Prompt ended, Command started
        $Result += "`e]133;B$([char]07)"
        $Global:LastHistoryId = $LastHistoryEntry.Id

        return $Result
    }
} elseif ((([System.Diagnostics.Process]::GetCurrentProcess()).Parent).ProcessName -eq 'Code') {
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