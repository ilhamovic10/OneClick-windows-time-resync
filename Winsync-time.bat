@echo off
setlocal enabledelayedexpansion

:: ======================================================
:: Project:     Windows 11 Time & Timezone Auto-Fix
:: Author:      Elham1x0
:: Copyright:   (c) 2026 Elham1x0. All rights reserved.
:: License:     MIT License
:: Repository:  https://github.com/Elham1x0/OneClick-windows-time-resync
:: ======================================================

:: Check for Administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [INFO] Administrator privileges required. Elevating...
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

title One-Click Windows Time Fixer - by Elham1x0

echo ======================================================
echo          Windows 11 Time Auto-Fix & Resync
echo                Developed by: Elham1x0
echo ======================================================
echo.

echo [1/3] Enabling automatic location-based time zone...
sc config tzautoupdate start= auto >nul 2>&1
net start tzautoupdate >nul 2>&1

echo [2/3] Starting Windows Time Service (w32time)...
net stop w32time >nul 2>&1
sc config w32time start= auto >nul 2>&1
net start w32time >nul 2>&1

echo [3/3] Synchronizing clock with network time servers...
w32tm /resync /force >nul 2>&1

if %errorlevel% neq 0 (
    echo.
    echo [!] Standard sync failed. Initializing automatic repair sequence...
    echo     * Stopping corrupted time services...
    net stop w32time >nul 2>&1
    
    echo     * Unregistering and rebuilding w32time service catalog...
    w32tm /unregister >nul 2>&1
    timeout /t 1 /nobreak >nul
    w32tm /register >nul 2>&1
    
    echo     * Injecting fallback NTP pools (time.windows.com, pool.ntp.org)...
    w32tm /config /manualpeerlist:"time.windows.com,0x9 pool.ntp.org,0x9" /syncfromflags:manual /reliable:yes /update >nul 2>&1
    
    echo     * Restarting time service...
    net start w32time >nul 2>&1
    timeout /t 2 /nobreak >nul
    
    echo     * Retrying synchronization...
    w32tm /resync /force >nul 2>&1
    
    if !errorlevel! neq 0 (
        echo.
        echo [ERROR] Auto-repair failed to reach NTP servers.
        echo         Ensure you are connected to the internet and disconnect any active VPN.
    ) else (
        echo [SUCCESS] Auto-repair resolved the issue. Clock synchronized!
    )
) else (
    echo [SUCCESS] Clock synchronized successfully!
)

echo.
echo ======================================================
echo Current Configuration:
for /f "delims=" %%i in ('tzutil /g') do echo Time Zone:    %%i
echo System Time:  %date% %time%
echo ======================================================
echo.
pause