

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

function get-greater ([string]$str1,[string] $str2){
    if($str1.Length -gt $str2.Length){
        return $str1, $str2, 1
    } else {
        return $str2, $str1, 2
    }
}

function split_list ($list) {
    $middle = $list.Count / 2
    $middle_plus_one = $middle + 1
    $end = $list.Count
    $a = $list[1..$middle]
    $b = $list[$middle_plus_one..$end]
    $outlist = [System.Collections.ArrayList]@()
    $outlist = $outlist + ""
    $outlist = $outlist + ""
    $outlist[0] = $a
    $outlist[1] = $b
    return $outlist
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

function lss {
    $items = Get-ChildItem
    [System.Collections.ArrayList]$items  = $items.name
    $items = split_list($items)
    
    $items = equalify($items)
    foreach ($item in $items){
        $len = 0
        foreach($it in $item){
            $len = $len + $it.length
            write-host "here"
        }
        $len
    }

}

# function Get-ChildItemUnixFancy {
#     $console_len = $Host.UI.RawUI.WindowSize.Width
#     $items = Get-ChildItem
#     $str_len = 0
#     foreach($item in $items){
#         $str_len = $str_len + $item.Name.Length
#     }
#     $num_times_to_divide_by_two = [Math]::Ceiling($str_len/($console_len * 2))
#     Write-Output $console_len
#     # Write-Output $str_len
#     # Write-Output $num_times_to_divide_by_two
    
#     $num_cols = $items.Length
#     # Write-Output $num_cols
#     for($i = 1; $i -le $num_times_to_divide_by_two; $i++){
#         $num_cols = $num_cols / 2
#     }
#     $num_cols = [Math]::Ceiling($num_cols)

#     # Write-Output $num_cols

#     $idx = 0
#     $col_index = 0
#     $num_rows = $items.Length / $num_cols
#     # Write-Output $items.Length
#     # Write-Output $num_cols
#     # Write-Output $num_rows
#     $array =  New-Object system.Array[][] $num_rows, $num_cols
#     # Write-Output $array
#     for ($i = 0; $i -lt $items.Length; $i++){
#         $my_str = "({0},{1})={2}" -f $col_index, $idx, $items[$i].Name
#         # Write-Output $my_str
#         $array[$col_index][$idx] = $items[$i].Name
#         $idx = $idx + 1
#         if ((($idx % $num_cols) -eq 0) -and ( $i -ne 0)) {
#             $s = "{0} % {1} = {2}" -f $i, $num_cols, ($i%$num_cols)
#             # Write-Output $s
#             $col_index = $col_index + 1
#             $idx = 0
#         }
#     }

#     foreach($row in $array) {

#         Write-Output $row
#         Write-Output ""
#         Write-Output ""
#     }

#     for($i = 0; $i -lt $array.Length; $i++){
#         for($j = 0; $j -lt $array[0].Length; $j++){
#             $str = $array[$i][$j] + "  "
#             Write-Host $str -NoNewline
#         }
#         Write-Output ""
#     }
# }


# 1 2 3 4 5 6 7 8
# arr[0][0] = 1
# arr[0][1] = 2
# arr[0][2] = 3
# arr[1][0] = 4
# arr[1][1] = 5
# arr[col][idx]

# idx = 0
# col_index = 0
# for i < len:
#     arr[col_index][idx]
#     idx++
#     if i % 3:
#         col_index ++
#         idx = 0

Remove-Item alias:ls -Force
New-Alias -Name ls -Value Get-ChildItemUnix

# --------------------------------------------------------------------------- #
# Assorted suffs
# --------------------------------------------------------------------------- #
function c { code $args }

Import-Module oh-my-posh
Set-PoshPrompt -Theme stelbent.minimal

# . "C:\Users\peterkapteyn\Documents\WindowsPowerShell\print_string.ps1"
