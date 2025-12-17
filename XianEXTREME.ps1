$SHOP_NAME = "Xiancode"

# KeyAuth
$APP_NAME = "XianEXTREME"
$OWNER_ID = "nZcd3x2EX9"
$SECRET   = "9b0a1bb14b2691321ea81ffc4fafb080213bc6cc1355babdf0db5969bf8ffbb7"
$VERSION  = "1.0"
$KEYAUTH_API = "https://keyauth.win/api/1.2/"
# ==========================================

# ================= ADMIN CHECK =================
if (-not ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "❌ กรุณา Run as Administrator" -ForegroundColor Red
    Pause
    Exit
}

# ================= HWID =================
function Get-HWID {
    $cpu  = (Get-CimInstance Win32_Processor).ProcessorId
    $bios = (Get-CimInstance Win32_BIOS).SerialNumber
    $disk = (Get-CimInstance Win32_PhysicalMedia | Select-Object -First 1).SerialNumber
    return "$cpu|$bios|$disk"
}
$HWID = Get-HWID

# ================= LOGIN =================
Clear-Host
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   🔐 FiveM Boost FPS PRO EXTREME 🔐"
Write-Host "=========================================="
Write-Host " ร้าน: $SHOP_NAME"
Write-Host ""

$license = Read-Host "🔑 ใส่ License Key"

$body = @{
    type    = "license"
    key     = $license
    hwid    = $HWID
    name    = $APP_NAME
    ownerid = $OWNER_ID
    secret  = $SECRET
    version = $VERSION
}

try {
    $res = Invoke-RestMethod -Uri $KEYAUTH_API -Method POST -Body $body
} catch {
    Write-Host "❌ ไม่สามารถเชื่อมต่อ License Server" -ForegroundColor Red
    Pause
    Exit
}

if ($res.success -ne $true) {
    Write-Host "❌ License ไม่ถูกต้อง / หมดอายุ / HWID ไม่ตรง" -ForegroundColor Red
    Pause
    Exit
}

Write-Host "✅ License Active | Exp: $($res.info.expiry)" -ForegroundColor Green
Start-Sleep 1

# ================= MENU =================
Clear-Host
Write-Host "==========================================" -ForegroundColor Green
Write-Host " 🔥 FiveM Boost FPS PRO - EXTREME 🔥"
Write-Host "=========================================="
Write-Host "[1] 🚀 BOOST FPS (EXTREME MODE)"
Write-Host "[2] 🔄 RESTORE ค่าเดิม"
Write-Host "[3] 📊 ดูสถานะ MMAgent"
Write-Host "[0] ❌ ออก"
Write-Host ""

$choice = Read-Host "เลือกเมนู"

switch ($choice) {

# ================= BOOST EXTREME =================
"1" {
    Write-Host "`n🔥 เปิดโหมด EXTREME..." -ForegroundColor Red

    # MEMORY
    Disable-MMAgent -MemoryCompression

    # SYSMAIN
    Stop-Service SysMain -Force -ErrorAction SilentlyContinue
    Set-Service SysMain -StartupType Disabled

    # POWER PLAN
    powercfg -setactive SCHEME_MIN

    # CPU / GAME SCHEDULING
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Scheduling Category" /t REG_SZ /d High /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d 6 /f >nul
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d 8 /f >nul

    # POWER THROTTLING OFF
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /v PowerThrottlingOff /t REG_DWORD /d 1 /f >nul

    # MEMORY LATENCY
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v DisablePagingExecutive /t REG_DWORD /d 1 /f >nul
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v LargeSystemCache /t REG_DWORD /d 0 /f >nul

    # INPUT LAG
    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 0 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 0 /f >nul

    # GAME DVR / FSO OFF
    reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
    reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul

    # BACKGROUND / TELEMETRY
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul
    reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul

    # SAFE SERVICE CUT
    $services = "DiagTrack","MapsBroker","lfsvc","SharedAccess"
    foreach ($s in $services) {
        Stop-Service $s -Force -ErrorAction SilentlyContinue
        Set-Service $s -StartupType Disabled -ErrorAction SilentlyContinue
    }

    Write-Host "`n✅ EXTREME MODE ENABLED" -ForegroundColor Green
    Write-Host "⚠ รีสตาร์ทเครื่องก่อนเข้า FiveM" -ForegroundColor Yellow
}

# ================= RESTORE =================
"2" {
    Write-Host "`n🔄 กำลังกู้คืนระบบ..." -ForegroundColor Yellow

    Enable-MMAgent -MemoryCompression
    Set-Service SysMain -StartupType Automatic
    Start-Service SysMain -ErrorAction SilentlyContinue
    powercfg -setactive SCHEME_BALANCED

    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 20 /f >nul

    reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 1 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold1 /t REG_SZ /d 6 /f >nul
    reg add "HKCU\Control Panel\Mouse" /v MouseThreshold2 /t REG_SZ /d 10 /f >nul

    reg delete "HKCU\System\GameConfigStore" /f >nul 2>&1
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" /f >nul 2>&1

    $services = "DiagTrack","MapsBroker","lfsvc","SharedAccess"
    foreach ($s in $services) {
        Set-Service $s -StartupType Manual -ErrorAction SilentlyContinue
    }

    Write-Host "✅ Restore เสร็จเรียบร้อย" -ForegroundColor Green
}

# ================= STATUS =================
"3" {
    Get-MMAgent | Format-List
}

"0" { Exit }

Default {
    Write-Host "❌ เลือกเมนูไม่ถูกต้อง" -ForegroundColor Red
}
}

Pause
