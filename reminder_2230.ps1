# reminder_2230.ps1 - Notifikasi jam 22:30
Add-Type -AssemblyName System.Windows.Forms

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.BalloonTipTitle = "Mulai Bersiap Tidur"
$notify.BalloonTipText  = "30 menit lagi laptop akan shutdown otomatis. Mulai wind down ya."
$notify.Visible = $true
$notify.ShowBalloonTip(10000)

Start-Sleep -Seconds 11
$notify.Dispose()
