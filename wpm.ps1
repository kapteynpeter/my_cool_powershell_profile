$test_text = "The quick brown fox jumped over the lazy dog"
write-host $test_text "`r" -NoNewline

$key = $null
$c = 0

$StopWatch = New-Object -TypeName System.Diagnostics.Stopwatch 
$StopWatch.start()

while ($c -lt $test_text.Length) 
{
    $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    write-host -ForegroundColor Black  $key.character -NoNewline
    $c += 1
}
$StopWatch.stop()

$elapsed = $StopWatch.Elapsed

$num_words = ([regex]::Matches($test_text, " " )).count
$num_words
$cpm = $num_words / $elapsed.TotalMinutes

"your words per minute was {0} words per minute" -f $cpm

# # Write a line at the top of the screen (first line)
# Clear-Host
# Write-Host ('x' * 20) -ForegroundColor Gray

# # Place the cursor back at the start of the first line
# $host.UI.RawUI.CursorPosition = @{ x = 0; y = 0 }

# # Partially overwrite the original line.
# Write-Host ('y' * 10) -ForegroundColor Yellow

