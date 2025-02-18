:PRINT
   where /q gum
   IF ERRORLEVEL 1 (
      ECHO %1
      GOTO :EOF
   )
   gum format --theme dark %1
   GOTO :EOF