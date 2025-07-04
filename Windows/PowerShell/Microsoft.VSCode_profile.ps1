# Set Console output encoding to UTF-8.
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Configure PSReadLine.
if (Get-InstalledPSResource -Name 'PSReadLine') {
    #Import-Module PSReadLine
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