. "C:\Users\peterkapteyn\Documents\WindowsPowerShell\ls.ps1"
. "C:\Users\peterkapteyn\Documents\WindowsPowerShell\assorted_helpers.ps1"
. "C:\Users\peterkapteyn\Documents\WindowsPowerShell\git-aliases.ps1"
. "C:\Users\peterkapteyn\Documents\WindowsPowerShell\location-aliases.ps1"
# . "C:\Users\peterkapteyn\Documents\WindowsPowerShell\print_string.ps1"


Remove-Item alias:ls -Force
New-Alias -Name ls -Value Get-ChildItemUnix
New-Alias -Name ll -Value Get-ChildItem

Import-Module oh-my-posh
Set-PoshPrompt -Theme stelbent.minimal
