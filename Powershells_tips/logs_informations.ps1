# non optimize powershell for get log information

# directly on server :
## log list with name, size & more in csv
$csv = Get-WinEvent -ListLog * -ComputerName $env:COMPUTERNAME | Select-Object LogName, LogMode, filesize, MaximumSizeInBytes, RecordCount, IsEnabled, @{name='ComputerName'; expression={$env:COMPUTERNAME}}
$csv | Export-Csv $env:HOMEPATH\Desktop\output.csv -NoTypeInformation

## Count all incident last 7 days for stats
$log = Get-WinEvent -ListLog * -ComputerName $env:COMPUTERNAME | % {Get-WinEvent -ComputerName $env:COMPUTERNAME -FilterHashTable @{LogName='*'; StartTime=((Get-Date).AddHours(-168))}}
write-host $env:COMPUTERNAME : $log.count



# Remote exec

$S = 'server1','server2','server3','server4'

$csv = ForEach ($Server in $S) {
  Get-WinEvent -ListLog * -ComputerName $Server |
    Select-Object LogMode, Logsize, MaximumSizeInBytes, RecordCount, LogName,
      @{name='ComputerName'; expression={$Server}}
}
$csv | Export-Csv $env:HOMEPATH\Desktop\output.csv -NoTypeInformation


ForEach ($Server in $S) {
  $log = Get-WinEvent -ListLog * -ComputerName $Server | % {Get-WinEvent -ComputerName $Server -FilterHashTable @{LogName='*'; StartTime=((Get-Date).AddHours(-168))}}
  write-host $Server : $log.count
}
