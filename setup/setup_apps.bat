@ECHO Off

:MAIN
   SETLOCAL
   SET CURRENT_DIR=%~dp0.
   SET GUM_CHOOSE_SELECTED=vscode
   SET TOOLS=vscode,obisidian,syncthing,rust,logseq,powershell,gimp,node.js
   for /f %%a in ('gum choose --no-limit %TOOLS%') do CALL :WINGET_INSTALL %%a
   ENDLOCAL

   GOTO :EOF


:WINGET_INSTALL
   SET PACKAGE=%1

   IF "%PACKAGE%"=="vscode" CALL "%CURRENT_DIR%\setup_vscode.bat"
   IF "%PACKAGE%"=="rust" CALL "%CURRENT_DIR%\setup_rust.bat"
   IF "%PACKAGE%"=="node.js" CALL "%CURRENT_DIR%\setup_node.bat"
   IF "%PACKAGE%"=="obisidian" CALL WInstall Obsidian.Obsidian
   IF "%PACKAGE%"=="powershell" CALL WInstall Microsoft.PowerShell
   IF "%PACKAGE%"=="syncthing" CALL WInstall SyncTrayzor.SyncTrayzor
   IF "%PACKAGE%"=="logseq" CALL WInstall Logseq.Logseq
   IF "%PACKAGE%"=="gimp" CALL WInstall GIMP.GIMP

   GOTO :EOF
