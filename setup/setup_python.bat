@ECHO OFF

:MAIN
   SET PYVERSION=3.12

   SET CONFIG_PATH=%1
   IF "%CONFIG_PATH%" == "" SET CONFIG_PATH=%USERPROFILE%\.local
   SET EXE_PYTHON_PATH=%CONFIG_PATH%\py%PYVERSION%

   uv python install %PYVERSION%
   uv venv -p %PYVERSION% --allow-existing --seed --no-project --system-site-packages --prompt base-%PYVERSION% "%EXE_PYTHON_PATH%"

   ECHO @"%EXE_PYTHON_PATH%\Scripts\python.exe" %%* > %CONFIG_PATH%\bin\python%PYVERSION%.bat

   CALL UpdatePath %CONFIG_PATH%\bin
   CALL UpdatePath %EXE_PYTHON_PATH%\Scripts
   GOTO :EOF
