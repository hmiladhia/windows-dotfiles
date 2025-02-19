@echo off

:MAIN
gum confirm "Setup VS Code ?" --default=false --affirmative "Yes" --negative "No" || GOTO :EOF

SET CURRENT_DIR=%~dp0
SET TARGET_PATH=%APPDATA%/Code/User/settings.json
WINSTALL Microsoft.VisualStudioCode code "" '/SILENT /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders"'

COPY "%~dp0../dotfiles/vscode/settings.json" "%TARGET_PATH%" > nul
GOTO :EOF
