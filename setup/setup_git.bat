@ECHO off

SETLOCAL
:MAIN
    SET CURRENT_DIR=%~dp0
    SET DOTFILES=%CURRENT_DIR%..\dotfiles
    SET CONFIG_PATH=%1
    IF "%CONFIG_PATH%" == "" SET CONFIG_PATH=%USERPROFILE%\.local

    SET GITCONFIG_PATH=%USERPROFILE%/.gitconfig
    IF EXIST "%GITIGNORE_PATH%" GOTO :EOF
    COPY "%DOTFILES%\.gitconfig" "%GITCONFIG_PATH%"

    SET GITIGNORE_PATH=%CONFIG_PATH%\.gitignore
    IF EXIST "%GITIGNORE_PATH%" GOTO :SKIPGITIGNORE
    COPY "%DOTFILES%\.gitignore" "%GITIGNORE_PATH%"
    :SKIPGITIGNORE

    git config --global core.excludesfile %GITIGNORE_PATH%

    CALL PPrint "e-mail:"
    for /f "tokens=*" %%i in ('gum input --placeholder "email"') do git config --global user.email "%%i"

    CALL PPrint "Name:"
    for /f "tokens=*" %%i in ('gum input --placeholder "name"') do git config --global user.name "%%i"

    git lfs install
    
    GOTO :EOF
ENDLOCAL
