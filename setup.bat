@echo off

:MAIN
    SET CONFIG_PATH=%USERPROFILE%\.local
    SET CURRENT_DIR=%~dp0
    set PATH=%CURRENT_DIR%/commands;%PATH%

    CALL :INIT

    CALL PPRINT "# 1. Common apps"
    CALL :INSTALL_APPS

    CALL PPRINT "# 2. Git Config"
    CALL setup/setup_git.bat 

    CALL PPRINT "# 3. Install Python"
    CALL "%CURRENT_DIR%\setup\setup_python.bat"

    CALL PPRINT "# 4. Install Python Tools"
    CALL "%CURRENT_DIR%\setup\python_tools.bat"
    GOTO :EOF


:INIT
    where /q winget

    IF ERRORLEVEL 1 (
        ECHO winget should be installed
        PAUSE
        EXIT /B
    )

    CALL WINSTALL charmbracelet.gum gum
    IF NOT EXIST %CONFIG_PATH% MKDIR %CONFIG_PATH%
    GOTO :EOF


:INSTALL_APPS
    CALL WINSTALL Git.Git git
    CALL WINSTALL junegunn.fzf fzf
    CALL WINSTALL eza-community.eza eza
    CALL WINSTALL astral-sh.uv uv
    GOTO :EOF
