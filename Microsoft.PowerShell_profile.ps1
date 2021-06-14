

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

# New-Alias -Name gst -Value Get-GitStatus -Force -Option AllScope
# New-Alias -Name gd -Value Get-Gitdiff
# New-Alias -Name gdc -Value Get-GitDiffCached
# New-Alias -Name gco -Value Get-GitCheckout
# New-Alias -Name gcob -Value Get-GitCheckoutBranch
# New-Alias -Name glg -Value Get-GitFancyLog
# New-Alias -Name ga -Value Get-GitAdd -Force -Option AllScope
# New-Alias -Name gb -Value Get-GitBranch
# New-Alias -Name gba -Value Get-GitBranchAll
# Remove-Item alias:gc -Force
# New-Alias -Name gc -Value Get-GitCommit

# --------------------------------------------------------------------------- #
# Navigation Aliases
# --------------------------------------------------------------------------- #
function Set-Traeger { Set-Location c:/traeger }
function Set-Storyboard { Set-Location c:/traeger/gooey_storyboard }
function Set-Gooey { Set-Location c:/traeger/gooey/gooey }
function Set-Kirby { Set-Location c:/traeger/kirbyapp }

function Set-Bootloader-Gooey { Set-Location c:/traeger/bootloader_gooey/bootloader }

# New-Alias -Name traeger -Value Set-Traeger
# New-Alias -Name story -Value Set-Storyboard
# New-Alias -Name gooey -Value Set-Gooey
# New-Alias -Name kirby -Value Set-Kirby
# New-Alias -Name boot -Value Set-Bootloader-Gooey

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

function Get-ChildItemUnix {
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


function split_list ($list) {
    $middle = $list.Count / 2
    $middle_plus_one = $middle + 1
    $end = $list.Count
    [System.Collections.ArrayList]$a = $list[1..$middle]
    [System.Collections.ArrayList]$b = $list[$middle_plus_one..$end]
    $outlist = [System.Collections.ArrayList]@()
    $outlist = $outlist + ""
    $outlist = $outlist + ""
    $outlist[0] = $a
    $outlist[1] = $b
    return $outlist
}

function pad ($list){
    for($i = 0; $i -lt $list.Count; $i++){
        $list[$i] = $list[$i] + "  "
    }
    return $list
}

function equalify ($list){
    $a = $list[0]
    $b = $list[1]
    for ($i = 0; $i -lt $a.Count; $i ++){
        if ($a[$i].Length -gt $b[$i].Length)
        {
            $diff = $a[$i].Length - $b[$i].Length
            if ($b[$i].Length -gt 0)
            {
                $b[$i] = $b[$i] + (" " * $diff)
            } else {
                $b = $b + (" " * $a[$i].Length)
                $b = [System.Collections.ArrayList]$b
            }
        } else {
            $diff = $b[$i].Length - $a[$i].Length
            $a[$i] = $a[$i] + (" " * $diff)
        }
    }
    $list[0] = $a
    $list[1] = $b
    return $list
}

function len ($list){
    $l = 0
    foreach ($item in $list ) {
        $l = $l + $item.Length
    }
    return $l
}

function lss {
    $items = Get-ChildItem
    [System.Collections.ArrayList]$items  = $items.name

    $console_len = $Host.UI.RawUI.WindowSize.Width
    $items_len = len($items)
    if ($items_len -gt $console_len){
        $items = split_list($items)
        $items[0] = pad($items[0])
        $items[1] = pad($items[1])
        $items = equalify($items)
        $l = len($items[0])
        while ( $l -gt $console_len ) {
            $temp = [System.Collections.ArrayList]@()
            for ($i = 0; $i -lt $items.Count; $i++)
            {
                $ol = split_list($items[$i])
                $ol = equalify($ol)
                $temp.add($ol[0])
                $temp.add($ol[1])
            }
            $items = $temp
            $l = len($items[0])
        }
        write-host "here"
        foreach($list in $items){
            foreach($item in $list){
                Write-Host $item -NoNewline
            }
            Write-host ""
        }
    } else {
        $items
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
