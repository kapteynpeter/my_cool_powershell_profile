

# function squarels () {
#     $console_len = $Host.UI.RawUI.WindowSize.Width
#     $side_len = $console_len - 10

#     $items = Get-ChildItem
#     $items  = $items.name
#     foreach($item in $items) {
#         $raw += ($item + "  ")
#     }
#     $c = 0
#     $sq_str = New-Object 'string[,]' $side_len, $side_len
#     for($i = 0; $i -lt $top_len; $i++) {
#         $sq_str[$i, 0] = $raw[$c]
#         $c++
#     }
#     for($i = 0; $i -lt $side_len; $i++){
#         $j = $side_len - 1
#         $sq_str[$i, $j] = $raw[$c]
#         $c++
#     }

#     for($i = 0; $i -lt $side_len; $i++) {
#         for($j = 0; $j -lt $side_len; $j++) {
#             Write-Host -NoNewline $sq_str[$i, $j]
#         }
#         Write-Host ""
#     }
    
    

# }
# squarels