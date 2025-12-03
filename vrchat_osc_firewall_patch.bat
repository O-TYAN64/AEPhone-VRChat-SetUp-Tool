@echo off
chcp 932 >nul
title VRChat OSC Firewall Patch (Auto Detect)

echo =========================================
echo VRChat OSC Firewall Patch
echo =========================================
echo.

:MENU
echo 1. 全ドライブから VRChat.exe を検索（steamapps 配下のみ）
echo 2. 手動でパスを入力
echo.
set /p CHOICE="選択してください (1 または 2): "

if "%CHOICE%"=="1" goto SEARCH
if "%CHOICE%"=="2" goto MANUAL
echo 選択が無効です。もう一度入力してください。
echo.
goto MENU

:SEARCH
echo 全ドライブから VRChat.exe を検索中...
echo 少し時間がかかる場合があります。
echo.

REM --- PowerShell で全ドライブ検索（steamapps\common\VRChat\VRChat.exe） ---
set "VRC_PATH="
for /f "usebackq delims=" %%p in (`powershell -NoProfile -Command ^
    "try { Get-ChildItem -Path 'C:\','D:\','E:\','F:\','G:\','H:\' -Filter 'VRChat.exe' -Recurse -ErrorAction SilentlyContinue | Where-Object { $_.FullName -match '\\steamapps\\common\\VRChat\\VRChat.exe$' } | Select-Object -First 1 -ExpandProperty FullName } catch {}"`) do (
    set "VRC_PATH=%%p"
)

if "%VRC_PATH%"=="" (
    echo -------------------------------------
    echo VRChat.exe が見つかりませんでした。
    echo 手動でパスを入力してください。
    echo -------------------------------------
    goto MANUAL
)

goto FOUND

:MANUAL
:MANUAL_INPUT
set /p VRC_PATH="VRChat.exe のフルパスを入力してください: "
if exist "%VRC_PATH%" (
    goto FOUND
) else (
    echo 指定されたパスは存在しません。もう一度入力してください。
    echo.
    goto MANUAL_INPUT
)

:FOUND
echo -------------------------------------
echo VRChat.exe を検出:
echo "%VRC_PATH%"
echo -------------------------------------

:FWMENU
echo ファイアウォール設定を追加しますか？
echo 1. はい
echo 2. いいえ
set /p FWCHOICE="選択してください (1 または 2): "

if "%FWCHOICE%"=="1" goto FIREWALL
if "%FWCHOICE%"=="2" goto END
echo 選択が無効です。もう一度入力してください。
echo.
goto FWMENU

:FIREWALL
echo ファイアウォールに VRChat.exe を追加中...
netsh advfirewall firewall add rule name="VRChat OSC - VRChat.exe" dir=in action=allow program="%VRC_PATH%" enable=yes
netsh advfirewall firewall add rule name="VRChat OSC - VRChat.exe OUT" dir=out action=allow program="%VRC_PATH%" enable=yes

echo OSC ポート (9000/9001) を開放中...
REM --- UDP 9000 ---
netsh advfirewall firewall add rule name="VRChat OSC UDP 9000 IN" dir=in action=allow protocol=UDP localport=9000
netsh advfirewall firewall add rule name="VRChat OSC UDP 9000 OUT" dir=out action=allow protocol=UDP localport=9000

REM --- UDP 9001 ---
netsh advfirewall firewall add rule name="VRChat OSC UDP 9001 IN" dir=in action=allow protocol=UDP localport=9001
netsh advfirewall firewall add rule name="VRChat OSC UDP 9001 OUT" dir=out action=allow protocol=UDP localport=9001

echo.
echo 完了しました！
echo 自動検出した VRChat.exe を使用して OSC 用ファイアウォール設定を追加しました。
echo PCの再起動を推奨します。
goto END

:END

pause
exit /b
