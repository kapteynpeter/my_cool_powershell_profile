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


function Get-ChildItemUnix ($args) {
    if ($args -eq "-l")
    {
        Get-ChildItem
    }
    else {
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
                        # don't display files with a leading "."
                        if ($items[$c][0] -ne ".") {
                            $array[$row, $col] = $items[$c] + "  "

                            # keep track of the widths so you know the largest width in each colom
                            if ($array[$row, $col].Length -gt $col_widths[$col]) {
                                $col_widths[$col] = $array[$row, $col].Length
                            }
                        } else {
                            $col--
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
}