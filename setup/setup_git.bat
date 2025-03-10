@ECHO off

SETLOCAL
:MAIN
    SET CURRENT_DIR=%~dp0
    SET DOTFILES=%CURRENT_DIR%..\dotfiles
    SET CONFIG_PATH=%1
    IF "%CONFIG_PATH%" == "" SET CONFIG_PATH=%USERPROFILE%\.local

    SET GITCONFIG_PATH=%USERPROFILE%/.gitconfig
    IF EXIST "%GITCONFIG_PATH%" GOTO :EOF
    COPY "%DOTFILES%\.gitconfig" "%GITCONFIG_PATH%"

    SET GITIGNORE_PATH=%CONFIG_PATH%\.gitignore
    IF EXIST "%GITIGNORE_PATH%" GOTO :SKIPGITIGNORE
    COPY "%DOTFILES%\.gitignore" "%GITIGNORE_PATH%"
    :SKIPGITIGNORE

    git config --global core.excludesfile %GITIGNORE_PATH%

    CALL PPrint "e-mail:"
    CALL Read git config user.email
    for /f "tokens=*" %%i in ('gum input --placeholder "email" --value "%RESULT%"') do git config --global user.email "%%i"
    
    CALL PPrint "Name:"
    CALL Read git config user.name
    for /f "tokens=*" %%i in ('gum input --placeholder "name" --value "%RESULT%"') do git config --global user.name "%%i"

    git lfs install

    IF EXIST "%USERPROFILE%\.ssh\id_rsa" GOTO :EOF

    CALL Read git config user.email
    ssh-keygen -t rsa -b 4096 -C "%RESULT%"
    GOTO :EOF
ENDLOCAL
