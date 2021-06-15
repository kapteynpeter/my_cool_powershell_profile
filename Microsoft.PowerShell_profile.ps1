

# --------------------------------------------------------------------------- #
# Git Aliases
# --------------------------------------------------------------------------- #
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

# --------------------------------------------------------------------------- #
# Navigation Aliases
# --------------------------------------------------------------------------- #
function Set-Traeger { Set-Location c:/traeger }
function Set-Storyboard { Set-Location c:/traeger/gooey_storyboard }
function Set-Gooey { Set-Location c:/traeger/gooey/gooey }
function Set-Kirby { Set-Location c:/traeger/kirbyapp }

function Set-Bootloader-Gooey { Set-Location c:/traeger/bootloader_gooey/bootloader }

New-Alias -Name traeger -Value Set-Traeger
New-Alias -Name story -Value Set-Storyboard
New-Alias -Name gooey -Value Set-Gooey
New-Alias -Name kirby -Value Set-Kirby
New-Alias -Name boot -Value Set-Bootloader-Gooey

# --------------------------------------------------------------------------- #
# Random functions
# --------------------------------------------------------------------------- #
function remove { & Remove-Item -LiteralPath $args -Force -Recurse }
New-Alias -Name rm -Value remove -Force -Option AllScope


function Copy-Item-Recurse( $source, $dest ) {
    Copy-Item -Path $source -Destination $dest -Recurse
}
Remove-Item alias:cp -Force
New-Alias -Name cp -Value Copy-Item-Recurse


function up {
    param( [int] $num_dirs )

    for ( $i = 1; $i -le $num_dirs; $i ++ ) {
        Set-Location ..
    }
}

function ascii($chars, $hex) {
    foreach ( $char in $chars.ToCharArray() ) {
        if ($hex -eq "hex") {
            $fmt = "0x" + ([int]$char).tostring('x')
            Write-Output $fmt
        } else {
            [byte][char]$char
        }
    }
}

function Get-ChildItemUnixSimple {
    Write-Output $Host.UI.RawUI.WindowSize.Width
    $items = Get-ChildItem
    foreach ( $item in $items ) {
        $firstchar = [string] $item.Name[0]
        if ( $firstchar.contains('.') -eq $false ) {
            if ( $item.GetType() -eq [System.IO.DirectoryInfo]){
                Write-Host $item.Name "  " -ForegroundColor "Green" -NoNewline
            } elseif ( $item.GetType() -eq [System.IO.FileInfo] ) {
                Write-Host $item.Name "  " -ForegroundColor "Cyan" -NoNewline
            }
        }
    }
}


function Get-ChildItemUnix {
    $items = Get-ChildItem
    [System.Collections.ArrayList]$items  = $items.name
    $max_cols = $items.Count
    $num_cols = 0
    $num_rows = 0

    # try out all row/col configs to find the one that fits
    # ie the config that maximizes cols
    for ($i = $max_cols; $i -ge 1; $i--){
        $num_cols = $i
        $num_rows = [Math]::Ceiling($items.Count / $num_cols)
        $c = 0
        $array = New-Object 'string[,]' $num_rows, $num_cols
        $col_widths = @(0) * $num_cols

        # fit the directory items into the array with this row/col config
        for ($row = 0; $row -lt $num_rows; $row++){
            for ($col = 0; $col -lt $num_cols; $col++){
                try {
                    $array[$row, $col] = $items[$c] + "  "

                    # keep track of the widths so you know the largest width in each colom
                    if ($array[$row, $col].Length -gt $col_widths[$col]) {
                        $col_widths[$col] = $array[$row, $col].Length
                    }
                } catch {}
                $c = $c + 1
            }
        }

        # check if this row/col config will fit in the console horizontally
        $console_len = $Host.UI.RawUI.WindowSize.Width
        $total_row_len = 0
        foreach($width in $col_widths) { $total_row_len = $total_row_len + $width }
        if ($total_row_len -lt $console_len) {
            break
        }
    }

    # print it to console
    for($i = 0; $i -lt $num_rows; $i++){
        for($j = 0; $j -lt $num_cols; $j++){
            Write-Host $array[$i, $j] -NoNewline
            $diff = $col_widths[$j] - $array[$i, $j].Length 
            if($diff -gt 0) {
                $diffstr = " " * $diff
                Write-Host $diffstr -NoNewline
            }
        }
        Write-host ""
    }
}

Remove-Item alias:ls -Force
New-Alias -Name ls -Value Get-ChildItemUnix

# --------------------------------------------------------------------------- #
# Assorted suffs
# --------------------------------------------------------------------------- #
function c { code $args }

Import-Module oh-my-posh
Set-PoshPrompt -Theme stelbent.minimal

# . "C:\Users\peterkapteyn\Documents\WindowsPowerShell\print_string.ps1"
