# Windows 11 Time & Timezone Resync

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/platform-windows-blue)](https://www.microsoft.com/windows)
[![Language](https://img.shields.io/badge/language-Batch-orange)](https://en.wikipedia.org/wiki/Batch_file)
[![GitHub release](https://img.shields.io/github/v/release/Elham1x0/OneClick-windows-time-resync?color=green)](https://github.com/Elham1x0/OneClick-windows-time-resync/releases/latest)
[![GitHub last commit](https://img.shields.io/github/last-commit/Elham1x0/OneClick-windows-time-resync)](https://github.com/Elham1x0/OneClick-windows-time-resync/commits/main)

---

> **One-click self-healing clock and timezone fixer for Windows 10 & 11.**  
> Built for laptops plagued by dying CMOS batteries, sleep/wake desyncs, and unresponsive Windows Time services.

---

### 🛑 The Problem

When your laptop battery drops to 0% or your internal CMOS coin-cell dies, Windows forgets what year it is. You boot up to find:
* Every HTTPS page throwing `NET::ERR_CERT_DATE_INVALID`.
* Messaging and authentication apps crashing or failing to handshake.
* The built-in Windows Settings "Sync now" button stalling with generic error messages.

**`Winsync-time.bat`** fixes this in a single click: it auto-elevates to Administrator, sets your time zone via Windows location services, and forces an immediate network resynchronization. If the standard sync fails, it triggers an automatic repair sequence to rebuild the time service and restore your clock.

## Features

- **Auto-Elevation:** Automatically triggers the Windows UAC prompt to request required administrative privileges.
- **Location-Aware Time Zone:** Configures and starts the `tzautoupdate` service so Windows dynamically selects the correct local time zone.
- **Forced Resync:** Restarts the Windows Time Service (`w32time`) and forces an immediate NTP query against configured time servers.
- **Zero Dependencies:** Pure Batch/PowerShell; runs natively out of the box.
- **Automated Self-Healing:** Detects sync failures (e.g., service unresponsiveness or registry corruption), automatically unregisters/reregisters `w32time`, applies fallback NTP server pools, and completes the sync without requiring manual intervention.

## Requirements

- Windows 10 or Windows 11
- Active internet connection
- **Location Services enabled** (`Settings` > `Privacy & security` > `Location`) for automatic time zone updates

## Usage

### Option 1: Double-Click
1. Download `sync-time.bat`.
2. Double-click the file.
3. Click **Yes** when prompted by User Account Control (UAC).

### Option 2: Command Line (Admin)
```cmd
git clone https://github.com/Elham1x0/OneClick-windows-time-resync.git
cd windows-time-resync
sync-time.bat
