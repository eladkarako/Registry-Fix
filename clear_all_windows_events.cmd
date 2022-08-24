::@echo off
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :DO_CLEAR "%%G")
echo.
echo All Event Logs have been cleared!
goto END

:DO_CLEAR
echo clearing %1
wevtutil.exe cl %1
goto :eof

:END
pause
exit /b 0