if (Get-InstalledPSResource -Name 'PSReadLine') {
    #Import-Module PSReadLine
    Set-PSReadlineOption -EditMode Emacs
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
}