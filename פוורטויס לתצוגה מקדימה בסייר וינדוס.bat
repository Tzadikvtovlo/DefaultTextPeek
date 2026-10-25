@echo off
chcp 65001 >nul
title הגדרת תצוגה מקדימה מתקדמת (Monaco / PowerToys)

if "%~1"=="" (
    echo גרור קובץ אחד או יותר על גבי קובץ סקריפט זה.
    pause
    exit /b
)

:: מזהה ה-Preview Handler של Monaco מבית PowerToys
set "MONACO_GUID={afbd5a44-2520-4ae0-9224-6cfce8fe4400}"

for %%F in (%*) do (
    set "ext=%%~xF"
    if not defined ext (
        echo לקובץ "%%~nxF" אין סיומת, דולג.
    ) else (
        reg add "HKCU\Software\Classes\%%~xF\ShellEx\{8895b1c6-b41f-4c1c-a562-0d564250836f}" /ve /d "%MONACO_GUID%" /f >nul
        reg add "HKCU\Software\Classes\%%~xF" /v "PerceivedType" /d "text" /f >nul
        echo הוגדרה תצוגת קוד מתקדמת עבור: %%~xF
    )
)

echo.
echo מרענן את סייר הקבצים...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo הפעולה הסתיימה בהצלחה!
timeout /t 3 >nul