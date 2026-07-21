# 🌙 SleepLock

SleepLock is a Windows desktop application designed to help users build a healthier sleep routine. Instead of relying on willpower alone, SleepLock reminds you when it's time to wrap up your work, safely closes open applications, and automatically shuts down your computer at your scheduled bedtime.

## ✨ Features

- 🛌 Bedtime reminders before shutdown.
- 📢 Non-intrusive notifications in the bottom-right corner.
- 💾 Gives you time to save your work.
- 🖥️ Automatically closes open applications.
- ⚠️ Displays a final shutdown countdown.
- ❌ Cancel the shutdown anytime during the countdown.
- 🔧 Fully customizable schedule and excluded applications.

---

## 📥 Installation

1. Download all project files.
2. Place them inside the same folder (for example: `C:\AutoShutdown\`).
3. Right-click **setup_tasks.bat** and select **Run as administrator**.
4. Done! SleepLock will automatically register all required tasks in **Windows Task Scheduler**.

No additional software is required.

---

## ⏰ Daily Schedule

### 🕥 10:30 PM — Start Getting Ready for Bed

A gentle notification appears in the bottom-right corner, reminding you to start preparing for bed.

The notification disappears automatically after a few seconds.

---

### 🕥 10:45 PM — Avoid Starting New Tasks

Another reminder encourages you not to begin any new work so you can finish on time.

---

### 🕚 10:57 PM — Final Reminder

A final notification appears:

> **⚠️ Your computer will shut down in 3 minutes. Please save your work.**

This notification stays on screen longer to make sure you notice it.

---

### 🕚 11:00 PM — Shutdown Routine

At your scheduled bedtime, SleepLock automatically begins the shutdown process.

The application will:

1. Display a notification indicating that applications are being closed.
2. Detect all currently open applications.
3. Ignore essential Windows system processes.
4. Close each application normally (similar to clicking the **X** button).
5. Wait for a few seconds, allowing you to save unsaved work if prompted.
6. Force close any applications that are still running after the waiting period.
7. Display a notification showing which applications were closed.
8. Show a 30-second shutdown countdown.

During the countdown, you can click **Cancel Shutdown** if you decide to continue using your computer.

If no action is taken before the countdown reaches zero, Windows will automatically shut down.

---

## ⚙️ Customization

You can easily customize SleepLock.

### Change Reminder Times

Want to use a different schedule? It's easy.

1. Make sure **`change_times.bat`** is in the same folder as the other SleepLock files.
2. Open **`change_times.bat`** with **Notepad**.
3. Edit the time values at the top of the file.

```batch
set TIME_REMINDER1=22:30
set TIME_REMINDER2=22:45
set TIME_REMINDER3=22:57
set TIME_SHUTDOWN=23:00
```

4. Save the file.
5. Right-click **`change_times.bat`** and select **Run as administrator**.

All scheduled tasks will be updated automatically with your new reminder and shutdown times.

### Keep certain applications open

If there are applications you don't want SleepLock to close automatically, simply add their process names to the **`$excludeList`** inside the shutdown_routine.ps1.

Example:

```powershell
$excludeList = @(
    "explorer",
    "qbittorrent"
)
```

---

## 🔔 Notifications

All reminders are displayed as standard Windows notifications in the bottom-right corner.

They are lightweight, non-blocking, and disappear automatically without interrupting your work.

---

## ⚠️ Important Notes

- Save your work when the final reminder appears.
- Unsaved applications may display a **Save Changes** dialog before closing.
- Applications that remain open after the waiting period will be force-closed to ensure the shutdown completes on time.
- You can always cancel the shutdown during the final 30-second countdown.

---

# 📄 License

This project is open source and available under the Apache 2.0 License.
