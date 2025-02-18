SET CONFIG_PATH=%1
SET GITIGNORE_PATH=%CONFIG_PATH%\.gitignore

IF EXIST "%GITIGNORE_PATH%" GOTO :SKIPGITIGNORE
curl "https://raw.githubusercontent.com/github/gitignore/main/Global/Windows.gitignore" -o "%GITIGNORE_PATH%"
git config --global core.excludesfile %GITIGNORE_PATH%
:SKIPGITIGNORE

CALL PPRINT "e-mail:"
for /f "tokens=*" %%i in ('gum input --placeholder "email"') do git config --global user.email "%%i"

CALL PPRINT "Name:"
for /f "tokens=*" %%i in ('gum input --placeholder "name"') do git config --global user.name "%%i"

git lfs install
