@echo off
chcp 65001 >nul
title עדכון תצוגה מקדימה עבור BAT

echo מעדכן הגדרות עבור קובצי BAT...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$monacoGuid = '{D8034CFA-F34B-41FE-AD45-62FCBB52A6DA}';" ^
    "$shellexKey = '{8895b1c6-b41f-4c1c-a562-0d564250836f}';" ^
    "$handlers = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PreviewHandlers' -ErrorAction SilentlyContinue;" ^
    "if ($handlers) {" ^
    "    foreach ($p in $handlers.PSObject.Properties) {" ^
    "        if ($p.Value -like '*Monaco*') { $monacoGuid = $p.Name; break }" ^
    "    }" ^
    "};" ^
    "$targets = @('.bat', 'batfile', 'cmdfile');" ^
    "foreach ($target in $targets) {" ^
    "    $p = \"HKCU:\Software\Classes\$target\ShellEx\$shellexKey\";" ^
    "    New-Item -Path $p -Force | Out-Null;" ^
    "    Set-ItemProperty -Path $p -Name '(Default)' -Value $monacoGuid;" ^
    "    Set-ItemProperty -Path \"HKCU:\Software\Classes\$target\" -Name 'PerceivedType' -Value 'text';" ^
    "    Set-ItemProperty -Path \"HKCU:\Software\Classes\$target\" -Name 'Content Type' -Value 'text/plain';" ^
    "};" ^
    "Write-Host '[PowerToys] קובצי BAT ו-CMD עודכנו בהצלחה!' -ForegroundColor Green;"

echo.
echo מרענן את סייר הקבצים...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo הסתיים! בדוק כעת קובץ BAT בסייר.
timeout /t 3 >nul