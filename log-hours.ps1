function Get-HoursWorked {
    param(
      [parameter(Mandatory=$true,
      ParameterSetName="clockIn")]
      [switch]
      $clockIn,
  
      [parameter(Mandatory=$true,
      ParameterSetName="clockOut")]
      [switch]
      $clockOut,

      [parameter(Mandatory=$true,
      ParameterSetName="startLunch")]
      [switch]
      $startLunch,

      [parameter(Mandatory=$true,
      ParameterSetName="endLunch")]
      [switch]
      $endLunch
      )

      $outfile = $profile_path + "/hours.csv"

      if (-Not (test-path $outfile)) {
        {} | Select "date","timein","timeout", "lunchtimein", "lunchtimeout" | Export-Csv $outfile
      }

}

# add a clock in clock out feature
# add a log feature in case you forgot to clock in or out
# make it compatible with the sweetness

# param(
#   # [single] $timeIn,
#   # [single] $timeOut,
#   # [single] $timeLunch,
#   # [Parameter(Mandatory=$true)][bool]$username
# )
# $timeOut
# $timeIn
# $timeLunch
# $hoursWorked = $timeOut - $timeIn - $timeLunch
# "You worked {0} today" -f $hoursWorked


# usage 
# log-hours < -clockin | -clockout | -clockinlunch | -clockoutlunch >
# log-hours -gethours < today | <string containing date> >