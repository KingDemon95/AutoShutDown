# reminder_2245.ps1 - Notifikasi jam 22:45
Add-Type -AssemblyName System.Windows.Forms

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Warning
$notify.BalloonTipTitle = "Jangan Mulai Kerjaan Baru"
$notify.BalloonTipText  = "15 menit lagi laptop shutdown. Jangan buka project atau tugas baru dulu."
$notify.Visible = $true
$notify.ShowBalloonTip(10000)

Start-Sleep -Seconds 11
$notify.Dispose()
