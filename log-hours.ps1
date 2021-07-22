function Get-HoursWorked {
    param(
      [parameter(Mandatory=$true, ParameterSetName="clockIn")]    [switch]$ClockIn,
      [parameter(Mandatory=$true, ParameterSetName="clockOut")]   [switch]$ClockOut,
      [parameter(Mandatory=$true, ParameterSetName="startLunch")] [switch]$StartLunch,
      [parameter(Mandatory=$true, ParameterSetName="endLunch")]   [switch]$EndLunch,
      [parameter(Mandatory=$true, ParameterSetName="endLunch")]   [switch]$GetHoursWorked
      )

      $outfile = "C:\Users\peterkapteyn\Documents\WindowsPowershell\hours.csv"
      $date = get-date -UFormat "%m/%d/%Y"
      $time = get-date -UFormat "%R"
      
      if (-Not (test-path $outfile)) {
        {} | Select "date","timein","timeout", "lunchtimein", "lunchtimeout" | Export-Csv $outfile
      }

      
      $csv = get-content $outfile | ConvertFrom-Csv -delimiter ','
      # $csv = Import-Csv $outfile
      $row = $csv | Where-Object date -eq $date
      "row"
      $row
      
      if ($ClockIn) {
        if ($row) {
          "it already exsists my guy"
          $row.timein = $time
        } else {
          "{0},{1},,," -f $date, $time | add-content -path $outfile
        }
      } elseif ($ClockOut) {

      } elseif ($StartLunch) {

      } elseif ($EndLunch) {

      } elseif ($GetHoursWorked) {

      }

      $csv | Export-Csv $outfile

      # $csvfile.date = "tomorrow"
      # $csvfile | Export-Csv $outfile


}

# $file = get-content hours.csv | ConvertFrom-Csv -delimiter ','
# $file | where-object date -eq '07/22/2021'
# usage 
# log-hours < -clockin | -clockout | -clockinlunch | -clockoutlunch >
# log-hours -gethours < today | <string containing date> >


get-hoursworked -clockin