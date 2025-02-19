SET "EXTRA_PATH=%~1"

for /f "tokens=2* delims= " %%A in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v PATH 2^>nul') do (
    SET SYSTEM_PATH="%%B"
)
CALL SET SYSTEM_PATH=%SYSTEM_PATH%
IF NOT defined SYSTEM_PATH SET SYSTEM_PATH=""
SET "SYSTEM_PATH=%SYSTEM_PATH:"=%"

for /f "tokens=2* delims= " %%A in ('reg query "HKCU\Environment" /v PATH 2^>nul') do (
    SET USER_PATH="%%B"
)
CALL SET USER_PATH=%USER_PATH%
IF NOT defined USER_PATH SET USER_PATH=""
SET "USER_PATH=%USER_PATH:"=%"

SET PATH=%SYSTEM_PATH%;%USER_PATH%
IF NOT "%EXTRA_PATH%" == "" SET PATH=%EXTRA_PATH%;%PATH%
