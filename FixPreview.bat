@echo off
chcp 65001 >nul
title הגדרת תצוגה מקדימה - PowerToys ו-Notepad

echo מגדיר תצוגה מקדימה לפי הדרישות...
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$monacoGuid = '{D8034CFA-F34B-41FE-AD45-62FCBB52A6DA}';" ^
    "$txtGuid    = '{1531d583-8375-4d3f-b5fb-d23bbd169f22}';" ^
    "$shellexKey = '{8895b1c6-b41f-4c1c-a562-0d564250836f}';" ^
    "$handlers = Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PreviewHandlers' -ErrorAction SilentlyContinue;" ^
    "if ($handlers) {" ^
    "    foreach ($p in $handlers.PSObject.Properties) {" ^
    "        if ($p.Value -like '*Monaco*') { $monacoGuid = $p.Name; break }" ^
    "    }" ^
    "};" ^
    "$codeExts = @('.js', '.json', '.bat', '.gs');" ^
    "foreach ($ext in $codeExts) {" ^
    "    $p = \"HKCU:\Software\Classes\$ext\ShellEx\$shellexKey\";" ^
    "    New-Item -Path $p -Force | Out-Null;" ^
    "    Set-ItemProperty -Path $p -Name '(Default)' -Value $monacoGuid;" ^
    "    Set-ItemProperty -Path \"HKCU:\Software\Classes\$ext\" -Name 'PerceivedType' -Value 'text';" ^
    "    Write-Host \"[PowerToys] הגדרת תצוגה עבור $ext הצליחה\" -ForegroundColor Green;" ^
    "};" ^
    "$txtPath = \"HKCU:\Software\Classes\.txt\ShellEx\$shellexKey\";" ^
    "New-Item -Path $txtPath -Force | Out-Null;" ^
    "Set-ItemProperty -Path $txtPath -Name '(Default)' -Value $txtGuid;" ^
    "Set-ItemProperty -Path 'HKCU:\Software\Classes\.txt' -Name 'PerceivedType' -Value 'text';" ^
    "Write-Host '[Windows TXT] הגדרת תצוגה עבור .txt הצליחה' -ForegroundColor Cyan;"

echo.
echo מרענן את סייר הקבצים...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo הכל הוגדר בהצלחה! החלון ייסגר בעוד 3 שניות.
timeout /t 3 >nul