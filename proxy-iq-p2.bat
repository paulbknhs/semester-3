@ECHO OFF
SETLOCAL
ECHO.
ECHO   alte Einstellungen
ECHO ======================
ECHO.
FOR /F "Skip=2 tokens=3*" %%i IN ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /V "ProxyServer"') DO SET "ProxyServer=%%i"
REM ECHO %ProxyServer%
IF "%ProxyServer%"=="" (
	ECHO.
	ECHO Proxy-Einstellungen nicht vorhanden, werden nun gesetzt!
	ECHO.
) ELSE (
	ECHO Proxy-Einstellungen sind vorhanden
	ECHO Proxy-Server:Port
	ECHO %ProxyServer%
)

ECHO.
FOR /F "Skip=2 tokens=3*" %%i IN ('REG QUERY "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /V "ProxyEnable"') DO SET "ProxyEnable=%%i"
REM ECHO %ProxyEnable%
IF "%ProxyEnable%"=="0x1" (
	ECHO Proxy war eingeschaltet
) ELSE (
	ECHO Proxy war ausgeschaltet
)

ECHO.
ECHO ------------------------
ECHO.
ECHO.
ECHO Setze neue Einstellungen
ECHO ------------------------
ECHO.
IF %ProxyEnable%==0x1 (
	REM Proxy-Einstellungen waren gesetzt - also AUSSCHALTEN
	ECHO     Schalte Verwendung des Proxy-Server AUS
	REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 0 /f
	ECHO.
	echo     Loesche Proxy-Server-Einstellung
	REG DELETE "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /f
	ECHO.
	ECHO Proxy ist nun AUSGESCHALTET
	ECHO.
) ELSE (
	REM Proxy-Einstellungen waren NICHT gesetzt - also EINSCHALTEN
	ECHO Setze Proxy-Server auf:    192.168.64.1:3128
	REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer /t REG_SZ /d "192.168.64.1:3128" /f
	ECHO.
	ECHO     Setze Proxy-Ausnahmen auf: 127.0.0.1
	REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ /d "127.0.0.1;<local>" /f
	ECHO.
	ECHO     Schalte Proxy-Server:      EIN
	REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable /t REG_DWORD /d 1 /f
	ECHO.
	ECHO     Proxy ist nun EINGESCHALTET
	ECHO.
	ECHO ACHTUNG: Bitte im Firefox die Einstellungen aendern:
	ECHO     Erweitert - Netzwerk - Einstellungen...
	ECHO     * Proxy-Einstellungen des Systems verwenden
	ECHO.
)

PAUSE
ENDLOCAL
