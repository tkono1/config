function prompt () {
    [string]$isAdmin = '>'
    [string]$PromptColor1 = "DarkGreen"
    [string]$PromptColor2 = "DarkCyan"

    #Write-Host ("[$($env:USERNAME)@$(($env:COMPUTERNAME).ToLower()):" + (Get-Location) + "]$isAdmin ") -ForegroundColor $PromptColor2 -NoNewline
    Write-Host ("[$($env:USERNAME)@$(($env:COMPUTERNAME).ToLower()):") -ForegroundColor $PromptColor1 -NoNewline
    Write-Host ((Get-Location)) -ForegroundColor $PromptColor2 -NoNewline
    Write-Host ("]" + $isAdmin + " ") -ForegroundColor $PromptColor1 -NoNewline
    Return " "
}

if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
    Set-PSReadlineOption -EditMode Emacs
} elseif ($host.Name -eq 'Vusual Studio Code Host') {
    Import-Module PSReadline
    #Set-PSReadlineOption -EditMode Emacs
}
