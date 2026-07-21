# shutdown_routine.ps1 - Jam 23:00
# Auto-detect SEMUA aplikasi yang punya jendela terbuka, tutup, lalu shutdown
# dengan countdown window yang kelihatan + tombol batal
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Show-Notify {
    param($Title, $Msg, $DurationMs = 6000)
    $notify = New-Object System.Windows.Forms.NotifyIcon
    $notify.Icon = [System.Drawing.SystemIcons]::Information
    $notify.BalloonTipTitle = $Title
    $notify.BalloonTipText  = $Msg
    $notify.Visible = $true
    $notify.ShowBalloonTip($DurationMs)
    Start-Sleep -Milliseconds ($DurationMs + 500)
    $notify.Dispose()
}

function Show-CountdownAndShutdown {
    param([int]$Seconds = 30)

    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Auto Shutdown"
    $form.Size = New-Object System.Drawing.Size(340, 190)
    $form.StartPosition = "CenterScreen"
    $form.TopMost = $true
    $form.FormBorderStyle = "FixedDialog"
    $form.ControlBox = $false
    $form.MaximizeBox = $false
    $form.MinimizeBox = $false

    $lblTitle = New-Object System.Windows.Forms.Label
    $lblTitle.Text = "Laptop akan shutdown dalam:"
    $lblTitle.TextAlign = "MiddleCenter"
    $lblTitle.Font = New-Object System.Drawing.Font("Segoe UI", 11)
    $lblTitle.Dock = "Top"
    $lblTitle.Height = 40
    $form.Controls.Add($lblTitle)

    $lblTimer = New-Object System.Windows.Forms.Label
    $lblTimer.Text = "$Seconds detik"
    $lblTimer.TextAlign = "MiddleCenter"
    $lblTimer.Font = New-Object System.Drawing.Font("Segoe UI", 26, [System.Drawing.FontStyle]::Bold)
    $lblTimer.Dock = "Top"
    $lblTimer.Height = 70
    $form.Controls.Add($lblTimer)

    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Text = "Batalkan Shutdown"
    $btnCancel.Dock = "Bottom"
    $btnCancel.Height = 45
    $btnCancel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
    $form.Controls.Add($btnCancel)

    $script:remaining = $Seconds
    $script:cancelled = $false

    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 1000

    $timer.Add_Tick({
        $script:remaining--
        $lblTimer.Text = "$script:remaining detik"
        if ($script:remaining -le 5) {
            $lblTimer.ForeColor = [System.Drawing.Color]::Red
        }
        if ($script:remaining -le 0) {
            $timer.Stop()
            $form.Close()
        }
    })

    $btnCancel.Add_Click({
        $script:cancelled = $true
        $timer.Stop()
        $form.Close()
    })

    $timer.Start()
    $form.Add_Shown({ $form.Activate() })
    [void]$form.ShowDialog()

    return $script:cancelled
}

# =========================================================
# PROCESS YANG TIDAK BOLEH DITUTUP
# Tambahin di sini kalau ada aplikasi lain yang mau dibiarin tetap nyala
# =========================================================
$excludeList = @(
    "explorer",
    "powershell", "pwsh", "powershell_ise",
    "ApplicationFrameHost", "ShellExperienceHost", "StartMenuExperienceHost",
    "SearchHost", "TextInputHost", "SystemSettings",
    "dwm", "csrss", "winlogon", "wininit", "smss", "svchost",
    "sihost", "fontdrvhost", "RuntimeBroker", "conhost"
)

Show-Notify "Menutup Aplikasi" "Mendeteksi dan menutup semua aplikasi yang sedang terbuka..."

$targets = Get-Process | Where-Object {
    $_.MainWindowTitle -ne "" -and ($excludeList -notcontains $_.ProcessName)
}

$appNames  = $targets | Select-Object -ExpandProperty ProcessName -Unique
$targetIds = $targets | Select-Object -ExpandProperty Id

foreach ($t in $targets) {
    try { $t.CloseMainWindow() | Out-Null } catch {}
}

Start-Sleep -Seconds 10

foreach ($procId in $targetIds) {
    Get-Process -Id $procId -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}

$summary = if ($appNames.Count -gt 0) { ($appNames -join ", ") } else { "Tidak ada aplikasi yang perlu ditutup" }
Show-Notify "Selesai" "Ditutup: $summary"

# Countdown window dengan tombol batal
$cancelled = Show-CountdownAndShutdown -Seconds 30

if (-not $cancelled) {
    Stop-Computer -Force
} else {
    Show-Notify "Shutdown Dibatalkan" "Kamu membatalkan auto-shutdown malam ini."
}
