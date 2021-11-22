
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

function c { code . }

function speed-test { . "C:\asst\wpm\wpm.ps1"}

function source-iogencmds { ". 'C:\Program Files\Crank_Software\Storyboard_Engine\6.2.202003130919.36509v\win32-x86-opengles_2.0-obj\bin\cmds.ps1'" }
