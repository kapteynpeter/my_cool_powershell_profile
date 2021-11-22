function Set-Traeger { Set-Location c:/traeger }
function Set-Storyboard { Set-Location c:/traeger/gooey_storyboard }
function Set-Storyboard2 { Set-Location c:/traeger/storyboard2 }
function Set-Gooey { Set-Location c:/traeger/gooey/gooey }
function Set-Kirby { Set-Location c:/traeger/kirbyapp }
function Set-Bootloader-Gooey { Set-Location c:/traeger/bootloader_gooey/bootloader }

function Set-Profile { Set-Location c:/Users/peterkapteyn/Documents/WindowsPowershell }

New-Alias -Name traeger -Value Set-Traeger
New-Alias -Name story -Value Set-Storyboard
New-Alias -Name story2 -Value Set-Storyboard2
New-Alias -Name gooey -Value Set-Gooey
New-Alias -Name kirby -Value Set-Kirby
New-Alias -Name boot -Value Set-Bootloader-Gooey
New-Alias -Name profile -Value Set-Profile