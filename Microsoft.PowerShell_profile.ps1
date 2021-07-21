$profile_path = $profile.substring(0, $profile.length - 33)

. ($profile_path + "\ls.ps1")
. ($profile_path + "\assorted_helpers.ps1")
. ($profile_path + "\git-aliases.ps1")
. ($profile_path + "\print_string.ps1")
. ($profile_path + "\location-aliases.ps1")
. ($profile_path + "\traeger-scripts.ps1")

Remove-Item alias:ls -Force
New-Alias -Name ls -Value Get-ChildItemUnix
New-Alias -Name ll -Value Get-ChildItem

Import-Module posh-git
# Import-Module oh-my-posh
# Set-PoshPrompt -Theme stelbent.minimal
