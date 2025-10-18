@echo off
REM =============================================
REM Flutter Build Script for Windows 11
REM Cleans, gets dependencies, and builds release APK or Web
REM Usage:
REM    build.bat          → builds APK
REM    build.bat --web    → builds Web
REM =============================================

echo =============================================
echo Cleaning Flutter project...
echo =============================================
call flutter clean
IF %ERRORLEVEL% NEQ 0 (
    echo Error: flutter clean failed!
    pause
    exit /b %ERRORLEVEL%
)

echo =============================================
echo Getting Flutter dependencies...
echo =============================================
call flutter pub get
IF %ERRORLEVEL% NEQ 0 (
    echo Error: flutter pub get failed!
    pause
    exit /b %ERRORLEVEL%
)

REM =============================================
REM Check for command-line argument
REM =============================================
call flutter build apk --release
IF %ERRORLEVEL% NEQ 0 (
    echo Error: flutter pub get failed!
    pause
    exit /b %ERRORLEVEL%


IF %ERRORLEVEL% NEQ 0 (
    echo Error: Flutter build failed!
    pause
    exit /b %ERRORLEVEL%
)

echo =============================================
echo Build process completed successfully!
echo =============================================
pause
