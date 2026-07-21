@echo off
:: setup_tasks.bat
:: Jalankan file ini dengan cara klik kanan > "Run as administrator"
:: Pastikan semua file .ps1 ada di folder yang SAMA dengan .bat ini

set FOLDER=%~dp0

echo Mendaftarkan scheduled task...

schtasks /Create /TN "AutoSleep_1_Reminder2230" /TR "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%FOLDER%reminder_2230.ps1\"" /SC DAILY /ST 22:30 /F

schtasks /Create /TN "AutoSleep_2_Reminder2245" /TR "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%FOLDER%reminder_2245.ps1\"" /SC DAILY /ST 22:45 /F

schtasks /Create /TN "AutoSleep_3_Reminder2257" /TR "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%FOLDER%reminder_2257.ps1\"" /SC DAILY /ST 22:57 /F

schtasks /Create /TN "AutoSleep_4_ShutdownRoutine" /TR "powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File \"%FOLDER%shutdown_routine.ps1\"" /SC DAILY /ST 23:00 /F

echo.
echo Selesai! 4 task berhasil didaftarkan:
echo   22:30 - Reminder mulai bersiap
echo   22:45 - Reminder jangan mulai kerjaan baru
echo   22:57 - Final warning 3 menit
echo   23:00 - Tutup app + shutdown
echo.
echo Cek di Task Scheduler (search "Task Scheduler" di Start Menu) untuk verifikasi.
pause
