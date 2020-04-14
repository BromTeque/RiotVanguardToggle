@ECHO OFF
REM TODO Add more failure/error states/handlers.



REM Change "root" to Riot Vanguard install location
SET root=C:\Program Files\Riot Vanguard



REM Detect if script is run as admin. If it itsn't it pauses and then quits.
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	ECHO.
) ELSE (
	ECHO ######## ERROR: ADMINISTRATOR PRIVILEGES REQUIRED ########
	ECHO This script must be run as administrator to work properly! 
	ECHO Right click -^> Run as administrator to fix.
	ECHO.
	PAUSE
	EXIT /B 1
)

REM Informs user that the script will reboot their PC. Then pauses until user continues.
ECHO.
ECHO.
ECHO ################ This BAT file WILL reboot your PC! ################
ECHO.
ECHO.
ECHO.
PAUSE

REM Toggles, "enables" or "disables" vgk.sys by renaming the file.
CD %root%
FOR /F "tokens=3 delims=: " %%H IN ('sc query vgk ^| findstr "        STATE"') DO (
	IF /I "%%H" EQU "RUNNING" (
		REN "vgk.sys" "vgk.DISABLED"
	) ELSE (
		REN "vgk.DISABLED" "vgk.sys"
	)
)

REM Reboots computer.
TIMEOUT /T 30
SHUTDOWN -R -T 00