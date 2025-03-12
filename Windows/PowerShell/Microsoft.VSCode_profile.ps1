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