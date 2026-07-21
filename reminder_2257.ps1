# reminder_2257.ps1 - Notifikasi jam 22:57 (final warning)
Add-Type -AssemblyName System.Windows.Forms

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Error
$notify.BalloonTipTitle = "3 Menit Lagi Shutdown!"
$notify.BalloonTipText  = "Save semua kerjaanmu sekarang. Jam 23:00 laptop akan menutup semua aplikasi dan mati."
$notify.Visible = $true
$notify.ShowBalloonTip(15000)

Start-Sleep -Seconds 16
$notify.Dispose()
