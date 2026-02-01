@echo off
setlocal ENABLEDELAYEDEXPANSION

REM Build and upload Flutter APK to Google Drive via rclone
REM Usage:
REM   scripts\build_and_upload.bat [remote_name] [remote_folder] [drive_root_id]
REM Defaults:
REM   remote_name   = mydrive
REM   remote_folder = Nyxis
REM   drive_root_id = (optional) Google Drive folder ID to restrict rclone's root

REM Change to repo root (this script is under scripts/)
pushd "%~dp0.." >nul 2>&1

REM Parameters / defaults
set "REMOTE=%~1"
if "%REMOTE%"=="" set "REMOTE=mydrive"
set "DEST_DIR=%~2"
if "%DEST_DIR%"=="" set "DEST_DIR=Nyxis"
REM Optional: Google Drive root folder ID to restrict rclone access to a single folder
set "DRIVE_ROOT_ID=%~3"
REM Default folder ID (can be overridden by arg 3 or env var RCLONE_DRIVE_ROOT_ID)
set "DEFAULT_DRIVE_ROOT_ID="
if "%DRIVE_ROOT_ID%"=="" if not "%RCLONE_DRIVE_ROOT_ID%"=="" set "DRIVE_ROOT_ID=%RCLONE_DRIVE_ROOT_ID%"
if "%DRIVE_ROOT_ID%"=="" set "DRIVE_ROOT_ID=%DEFAULT_DRIVE_ROOT_ID%"

REM Build destination path (allow '.' to mean root of the remote)
set "DEST_PATH=/"
if not "%DEST_DIR%"=="." set "DEST_PATH=/%DEST_DIR%/"

REM Locations
set "APK_DIR=build\app\outputs\flutter-apk"
set "APK_FILE=app-debug.apk"
set "APK_PATH=%APK_DIR%\%APK_FILE%"
set "LOG_DIR=build_logs"
if not exist "%LOG_DIR%" mkdir "%LOG_DIR%" >nul 2>&1

REM Derive version from Git: name = latest tag, number = commit count
set "BUILD_NAME="
for /f "usebackq delims=" %%v in (`git describe --tags --abbrev^=0 2^>nul`) do set "BUILD_NAME=%%v"
if "%BUILD_NAME%"=="" set "BUILD_NAME=1.0.0"

set "BUILD_NUMBER="
for /f "usebackq delims=" %%c in (`git rev-list --count HEAD 2^>nul`) do set "BUILD_NUMBER=%%c"
if "%BUILD_NUMBER%"=="" set "BUILD_NUMBER=0"

set "APP_VER=%BUILD_NAME%+%BUILD_NUMBER%"

echo [prep] Running flutter pub get...
call flutter pub get > "%LOG_DIR%\flutter_pub_get.log" 2>&1
if errorlevel 1 (
  echo pub get failed. See "%LOG_DIR%\flutter_pub_get.log"
  set "SCRIPT_ERROR=1"
  goto :end
)

echo [1/4] Building debug APK (%APP_VER%)...
call flutter build apk --debug --build-name %BUILD_NAME% --build-number %BUILD_NUMBER% -v > "%LOG_DIR%\flutter_build_debug.log" 2>&1
if errorlevel 1 (
  echo Build failed. See "%LOG_DIR%\flutter_build_debug.log"
  echo --- First 40 lines of build log ---
  for /f "usebackq delims=" %%L in (`powershell -NoProfile -Command Get-Content -TotalCount 40 -Path ^"%LOG_DIR%\flutter_build_debug.log^"`) do echo %%L
  echo --- End snippet ---
  set "SCRIPT_ERROR=1"
  goto :end
)

if not exist "%APK_PATH%" (
  echo APK not found at "%APK_PATH%". Build may have failed.
  set "SCRIPT_ERROR=1"
  goto :end
)

for %%F in ("%APK_PATH%") do set "APK_SIZE=%%~zF"
set "UPLOAD_APK=%APK_DIR%\app-%APP_VER%-debug.apk"
copy /y "%APK_PATH%" "%UPLOAD_APK%" >nul
echo Built: %UPLOAD_APK% (%APK_SIZE% bytes)

echo [2/4] Locating rclone...
set "RCLONE="
for /f "usebackq delims=" %%I in (`where rclone 2^>nul`) do (
  set "RCLONE=%%I"
  goto :have_rclone
)

REM Common WinGet install path fallback
if exist "%LOCALAPPDATA%\Microsoft\WinGet\Packages\Rclone.Rclone_Microsoft.Winget.Source_8wekyb3d8bbwe\rclone-v1.70.3-windows-amd64\rclone.exe" (
  set "RCLONE=%LOCALAPPDATA%\Microsoft\WinGet\Packages\Rclone.Rclone_Microsoft.Winget.Source_8wekyb3d8bbwe\rclone-v1.70.3-windows-amd64\rclone.exe"
)

:have_rclone
if "%RCLONE%"=="" (
  echo rclone not found. Ensure it is installed and on PATH.
  set "SCRIPT_ERROR=1"
  goto :end
)

echo Using rclone: %RCLONE%

REM Extra rclone options (e.g., restrict to a specific Drive folder)
set "RCLONE_EXTRA_OPTS="
if not "%DRIVE_ROOT_ID%"=="" set "RCLONE_EXTRA_OPTS=--drive-root-folder-id %DRIVE_ROOT_ID%"

echo [3/4] Uploading APK to %REMOTE%:%DEST_PATH% ...
call "%RCLONE%" copy "%UPLOAD_APK%" %REMOTE%:"%DEST_PATH%" --progress %RCLONE_EXTRA_OPTS% > "%LOG_DIR%\rclone_upload.log" 2>&1
if errorlevel 1 (
  echo Upload failed. See "%LOG_DIR%\rclone_upload.log"
  set "SCRIPT_ERROR=1"
  goto :end
)

echo [4/4] Generating shareable link...
set "SHARE_URL="
for /f "usebackq delims=" %%L in (`call "%RCLONE%" link %REMOTE%:"%DEST_PATH%app-%APP_VER%-debug.apk" %RCLONE_EXTRA_OPTS% 2^>nul`) do (
  set "SHARE_URL=%%L"
)

if not "%SHARE_URL%"=="" (
  echo Shareable link: %SHARE_URL%
) else (
  echo Link generation failed. The file may be restricted.
  echo You can try making the folder public in Drive, then re-run, or share manually.
)

set "SCRIPT_ERROR=0"
goto :end

:end
echo.
if "%SCRIPT_ERROR%"=="1" (
  echo Completed with errors. See logs in "%LOG_DIR%".
) else (
  echo Completed successfully.
)
echo.
popd >nul 2>&1
exit /b %SCRIPT_ERROR%
