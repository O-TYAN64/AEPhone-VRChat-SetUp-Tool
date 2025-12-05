@echo off
chcp 65001 >nul
title USBケーブル通信チェック (ADB)

echo =========================================
echo        USBケーブル通信チェックツール
echo =========================================
echo ※初回起動時は「adb.exe の許可」を求められる場合があります
echo.

REM --- adb.exe 存在確認 ---
where adb >nul 2>&1
if %errorlevel% neq 0 (
    echo adb.exe が見つかりません
    echo adb.exe をこのフォルダに置くか PATH を通してください
    pause
    exit /b
)

echo adbサーバーを起動中...(初回は数秒かかる場合があります)

REM --- 初回の許可待ちで固まるのを避けるため2回実行 ---
adb start-server >nul 2>&1
timeout /t 1 >nul
adb start-server >nul 2>&1

echo デバイスを確認中...
adb devices > "%TEMP%\adb_check.txt"

findstr /R "device$" "%TEMP%\adb_check.txt" >nul
if %errorlevel%==0 (
    echo.
    echo ✔ 通信可能なUSBケーブルです！（ADB接続OK）
    echo.
    pause
    exit /b
)

findstr /R "unauthorized$" "%TEMP%\adb_check.txt" >nul
if %errorlevel%==0 (
    echo.
    echo ✔ 通信可能ですが、Android側でUSBデバッグ許可が必要です
    echo ※スマホの画面に表示される許可ダイアログを確認してください
    echo.
    pause
    exit /b
)

echo.
echo ✘ 通信不可：充電専用ケーブルの可能性があります
echo.
pause
