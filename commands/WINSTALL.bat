:MAIN
    SET APP_ID=%1
    SET CMD_NAME=%2
    SET VERSION=%3

    if not "%VERSION%"=="" SET EXTRA=-v "%VERSION%"

    winget install -e --id %APP_ID% %EXTRA%

    WHERE /q %CMD_NAME%
    IF NOT ERRORLEVEL 1 GOTO :EOF

    SET PACKAGES_PATH=%USERPROFILE%\AppData\Local\Microsoft\WinGet\Packages
    for /f %%f in ('dir /b "%PACKAGES_PATH%\%APP_ID%*"') do SET PACKAGE_DIR=%%f

    IF NOT %PACKAGE_DIR% == "" CALL UpdatePath %PACKAGES_PATH%\%PACKAGE_DIR%

    GOTO :EOF
