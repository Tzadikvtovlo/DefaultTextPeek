@echo off
chcp 65001 >nul
title הגדרת תצוגה מקדימה כטקסט

if "%~1"=="" (
    echo גרור קובץ אחד או יותר על גבי קובץ סקריפט זה.
    pause
    exit /b
)

:: מעבר על כל הקבצים שנגררו
for %%F in (%*) do (
    set "ext=%%~xF"
    if not defined ext (
        echo לקובץ "%%~nxF" אין סיומת, דולג.
    ) else (
        :: הגדרת תצוגה מקדימה של טקסט בחלונית
        reg add "HKCU\Software\Classes\%%~xF\ShellEx\{8895b1c6-b41f-4c1c-a562-0d564250836f}" /ve /d "{1531d583-8375-4d3f-b5fb-d23bbd169f22}" /f >nul
        reg add "HKCU\Software\Classes\%%~xF" /v "PerceivedType" /d "text" /f >nul
        echo הוגדרה תצוגה מקדימה עבור הסיומת: %%~xF
    )
)

echo.
echo מרענן את סייר הקבצים...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo הפעולה הסתיימה בהצלחה!
timeout /t 3 >nul