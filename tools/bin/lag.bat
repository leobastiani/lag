@ECHO OFF
SETLOCAL EnableDelayedExpansion

if EXIST %temp%\lag.txt (
	set /p ans=lag.bat is already been running, should it run again? [y]:
	if ["!ans!"] == ["y"] (
		del %temp%\lag.txt
	)
)

if NOT EXIST %temp%\lag.txt (
	echo.>%temp%\lag.txt
	call netlimiter start %*
	if ["%ERRORLEVEL%"] NEQ ["0"] (
		pause
		goto:eof
	)
	if ["%~1"] == [""] (
		call hide me
	)
	nircmdc waitprocess "LeagueClient.exe"
	call netlimiter stop %*
	del %temp%\lag.txt
	if ["%~1"] == [""] (
		call show me
	)
	exit
)
