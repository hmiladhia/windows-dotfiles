@ECHO off

WHERE /q winget

IF ERRORLEVEL 1 (
    ECHO winget should be installed
    PAUSE
    EXIT /B
)

:MAIN
    SET CURRENT_DIR=%~dp0.
    SET CONFIG_PATH=%USERPROFILE%\.local
    SET EXTRA_PATH=%CURRENT_DIR%\commands
    SET PATH=%EXTRA_PATH%;%PATH%
    
    CALL :INIT

    CALL PPrint "# 1. Common apps"
    CALL :INSTALL_APPS

    CALL PPrint "# 2. Git Config"
    CALL "%CURRENT_DIR%\setup\setup_git.bat" %CONFIG_PATH%

    CALL PPrint "# 3. Install Python"
    CALL "%CURRENT_DIR%\setup\setup_python.bat"
    CALL RefreshPATH %EXTRA_PATH%

    CALL PPrint "# 4. Install Python Tools"
    CALL "%CURRENT_DIR%\setup\python_tools.bat"

    CALL PPrint "# 5. Install other Apps"
    CALL "%CURRENT_DIR%\setup\setup_apps.bat"
    GOTO :EOF


:INIT
    CALL RefreshPath %EXTRA_PATH%
    
    REM workaround to accept terms
    winget list abcdfdkjlsl

    CALL WInstall charmbracelet.gum gum
    IF NOT EXIST %CONFIG_PATH% MKDIR %CONFIG_PATH%
    GOTO :EOF


:INSTALL_APPS
    CALL WInstall Git.Git git
    CALL WInstall junegunn.fzf fzf
    CALL WInstall eza-community.eza eza
    CALL WInstall jqlang.jq jq
    CALL WInstall astral-sh.uv uv

    SETX UV_NATIVE_TLS true
    SET UV_NATIVE_TLS=true
    SETX UV_HTTP_TIMEOUT 90
    SET UV_HTTP_TIMEOUT=90
    GOTO :EOF
