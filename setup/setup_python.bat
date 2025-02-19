@ECHO OFF

SETLOCAL
:MAIN
    IF NOT DEFINED EXTRA_PATH SET EXTRA_PATH=

   SET CONFIG_PATH=%1
   IF "%CONFIG_PATH%" == "" SET CONFIG_PATH=%USERPROFILE%\.local

   SET PYVERSION=%2
   IF "%PYVERSION%" == "" SET PYVERSION=3.12

   SET EXE_PYTHON_PATH=%CONFIG_PATH%\py%PYVERSION%

   uv python install %PYVERSION%
   uv venv -p %PYVERSION% --allow-existing --seed --no-project --system-site-packages --prompt base-%PYVERSION% "%EXE_PYTHON_PATH%"

   IF NOT EXIST %CONFIG_PATH%\bin MKDIR %CONFIG_PATH%\bin
   ECHO @"%EXE_PYTHON_PATH%\Scripts\python.exe" %%* > %CONFIG_PATH%\bin\python%PYVERSION%.bat

   CALL UpdatePath %CONFIG_PATH%\bin
   CALL UpdatePath %EXE_PYTHON_PATH%\Scripts
   CALL RefreshPATH %EXTRA_PATH%

   GOTO :EOF
ENDLOCAL