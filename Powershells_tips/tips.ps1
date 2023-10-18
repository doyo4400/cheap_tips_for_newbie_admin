# Make stop 
Start-Sleep -Seconds 10

# Set color in write-host
 Write-Host "Whole text is in red with background Yellow" -ForegroundColor Red -BackgroundColor Yellow

 # Get hash of file
 Get-FileHash /etc/apt/sources.list | Format-List

 # Make array
 Out-gridview

 # export result in file
  | Out-File -FilePath .\Process.txt
  | Export-Csv -Path .\Process.txt


# Know directory 
$myDirectory = [System.IO.Path]::GetDirectoryName($myInvocation.MyCommand.Definition)
$srcFile = $myDirectory + "\user.txt"

# convert lastlogontimestamp
 @{n='lastLogonTimestamp';e={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}