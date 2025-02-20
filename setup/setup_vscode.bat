@ECHO off

SETLOCAL
:MAIN
    REM gum confirm "Setup VS Code ?" --default=false --affirmative "Yes" --negative "No" || GOTO :EOF

    SET ROOT_DIR=%~dp0..
    SET TARGET_PATH=%APPDATA%\Code\User\settings.json

    CALL WInstall Microsoft.VisualStudioCode code --override "'/VERYSILENT /mergetasks=!addcontextmenufolders'"
    
    COPY "%ROOT_DIR%\dotfiles\vscode\settings.json" "%TARGET_PATH%"

    for /f %%f in ('pyjson5 --as-json %ROOT_DIR%\.vscode\extensions.json ^| jq .recommendations[]') do code --install-extension %%f
    GOTO :EOF
ENDLOCAL
