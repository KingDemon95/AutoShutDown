@echo off
:: change_times.bat
:: Cara pakai: edit angka jam di bagian "EDIT DI SINI" di bawah,
:: simpen file, terus klik kanan > "Run as administrator"

:: =========================================================
:: EDIT DI SINI (format 24 jam, HH:MM)
:: =========================================================
set TIME_REMINDER1=22:30
set TIME_REMINDER2=22:45
set TIME_REMINDER3=22:57
set TIME_SHUTDOWN=23:00
:: =========================================================

echo Mengubah jadwal...
echo   Reminder 1 (mulai bersiap)   -> %TIME_REMINDER1%
echo   Reminder 2 (jangan mulai)    -> %TIME_REMINDER2%
echo   Reminder 3 (3 menit lagi)    -> %TIME_REMINDER3%
echo   Shutdown routine             -> %TIME_SHUTDOWN%
echo.

schtasks /Change /TN "AutoSleep_1_Reminder2230" /ST %TIME_REMINDER1%
schtasks /Change /TN "AutoSleep_2_Reminder2245" /ST %TIME_REMINDER2%
schtasks /Change /TN "AutoSleep_3_Reminder2257" /ST %TIME_REMINDER3%
schtasks /Change /TN "AutoSleep_4_ShutdownRoutine" /ST %TIME_SHUTDOWN%

echo.
echo Selesai! Cek Task Scheduler kalau mau verifikasi.
pause
