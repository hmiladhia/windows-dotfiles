:MAIN
    IF NOT DEFINED EXTRA_PATH SET EXTRA_PATH=
    SET "APP_ID=%1"
    SET "CMD_NAME=%2"
    shift
    shift
    SET "ARGS=%*"

    winget install -e --id %APP_ID% %EXTRA%

    CALL RefreshPath %EXTRA_PATH%

    WHERE /q %CMD_NAME%
    IF NOT ERRORLEVEL 1 GOTO :EOF

    SET PACKAGES_PATH=%USERPROFILE%\AppData\Local\Microsoft\WinGet\Packages
    for /f %%f in ('dir /b "%PACKAGES_PATH%\%APP_ID%*"') do SET PACKAGE_DIR=%%f

    IF %PACKAGE_DIR% == "" GOTO :EOF
    CALL UpdatePath %PACKAGES_PATH%\%PACKAGE_DIR%
    CALL RefreshPath %EXTRA_PATH%

    GOTO :EOF
