@ECHO OFF

:MAIN
   SET PYVERSION=%1
   IF "%PYVERSION%" == "" SET PYVERSION=3.11

   SETLOCAL
   SET GUM_CHOOSE_SELECTED=pre-commit,ruff,tox,tldr
   SET TOOLS=pre-commit ruff tox tldr copier cookiecutter nbmanips mypy jupyterlab
   for /f %%a in ('gum choose --no-limit %TOOLS%') do CALL :UVINSTALL %PYVERSION% %%a
   ENDLOCAL

   GOTO :EOF


:UVINSTALL
   SET PYVERSION=%1
   SET PACKAGE=%2

   SET EXTRA=
   IF "%PACKAGE%"=="poetry" SET EXTRA=--with pip-system-certs
   IF "%PACKAGE%"=="pre-commit" SET EXTRA=--with pre-commit-uv
   IF "%PACKAGE%"=="tox" SET EXTRA=--with tox-uv

   uv tool install -p %PYVERSION% %EXTRA% --force %PACKAGE%
   GOTO :EOF
