$profile_path = $profile.substring(0, $profile.length - 33)

# . ($profile_path + "\ls.ps1")
. ($profile_path + "\assorted_helpers.ps1")
. ($profile_path + "\git-aliases.ps1")
. ($profile_path + "\print_string.ps1")
. ($profile_path + "\location-aliases.ps1")
. ($profile_path + "\traeger-scripts.ps1")



Remove-Item alias:ls -Force
Remove-Item alias:rm -Force

New-Alias -Name which -Value Get-Command
# New-Alias -Name ls -Value Get-ChildItemUnix
# New-Alias -Name ll -Value Get-ChildItem

Import-Module posh-git
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme stelbent.minimal

Set-PSReadLineKeyHandler -Key ctrl+e `
    -BriefDescription ExplorerAtCurrentPath `
    -LongDescription "Open Explorer at Current Path" `
    -ScriptBlock {
    Start-Process -FilePath 'explorer.exe' -ArgumentList "/separate , $($pwd.Path)" -Wait
}

Set-PSReadLineKeyHandler -Key ctrl+r `
    -BriefDescription VSCodeAtCurrentPath `
    -LongDescription "Open VSCode at Current Path" `
    -ScriptBlock {
    code .
}
