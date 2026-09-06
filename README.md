# Windows 11 Time & Timezone Resync

A lightweight batch utility designed to fix desynchronized clocks and automatically adjust local time zones on Windows 10 and 11 devices (especially after travel or waking from sleep).

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
git clone https://github.com/ilhamovic10/OneClick-windows-time-resync.git
cd windows-time-resync
sync-time.bat