function Get-Gitdiff { git diff }
function Get-GitStatus { & git status }
function Get-GitDiffCached { git diff --cached }
function Get-GitCheckout { git checkout $args }
function Get-GitCheckoutBranch { git checkout -b }
function Get-GitFancyLog ( $n ){ 
    if ( $n ) { 
        git log --oneline --decorate --color -n $n 
    } else {
        git log --oneline --decorate --color -n 5 
    }
}
function Get-GitAdd { & git add $args }
function Get-GitBranch { git branch }
function Get-GitBranchAll { git branch -a }
function Get-GitCommit { git commit -m $args }

# --------------------------------------------------------------------------- #
# Git Aliases
# --------------------------------------------------------------------------- #

New-Alias -Name gst -Value Get-GitStatus -Force -Option AllScope
New-Alias -Name gd -Value Get-Gitdiff
New-Alias -Name gdc -Value Get-GitDiffCached
New-Alias -Name gco -Value Get-GitCheckout
New-Alias -Name gcob -Value Get-GitCheckoutBranch
New-Alias -Name glg -Value Get-GitFancyLog
New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope
New-Alias -Name gb -Value Get-GitBranch
New-Alias -Name gba -Value Get-GitBranchAll
Remove-Item alias:gc -Force
New-Alias -Name gc -Value Get-GitCommit