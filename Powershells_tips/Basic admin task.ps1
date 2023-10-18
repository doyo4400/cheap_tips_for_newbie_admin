# Create schedule task with powershell

$UserId = samaccountname

 

$actions = (New-ScheduledTaskAction -Execute "powershell.exe" -Argument 'Set-ItemProperty -name "ProxyServer" -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings" -Value "http://proxy.contoso.com:3128"')

$trigger = New-ScheduledTaskTrigger -Once -At 7am -RepetitionDuration  (New-TimeSpan -Days 1)  -RepetitionInterval  (New-TimeSpan -Minutes 5)

$principal = New-ScheduledTaskPrincipal -UserId $UserId -RunLevel Highest -LogonType S4U

$settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun

$task = New-ScheduledTask -Action $actions -Principal $principal -Trigger $trigger -Settings $settings

Register-ScheduledTask 'setting proxy' -InputObject $task

 
#delete task
Unregister-ScheduledTask -TaskName "setting proxy" -Confirm:$false
