@ECHO off

:MAIN
    gum confirm "Setup VS Code ?" --default=false --affirmative "Yes" --negative "No" || GOTO :EOF

    SET CURRENT_DIR=%~dp0
    SET TARGET_PATH=%APPDATA%\Code\User\settings.json

    CALL WInstall Microsoft.VisualStudioCode code --override "'/VERYSILENT /mergetasks=!addcontextmenufolders'"
    
    COPY "%CURRENT_DIR%..\dotfiles\vscode\settings.json" "%TARGET_PATH%"
    GOTO :EOF
