@echo off
set "FILE1=%LocalAppData%\IconCache.db"
set "FILE2=%LocalAppData%\Microsoft\Internet Explorer\frameiconcache.dat"


::backing up old file (overwriting existing backup)
::xcopy /h /r /q /y "%FILE1%" "%FILE1%.old"   >nul 2>nul
::del /f /q         "%FILE1%"                 >nul 2>nul

::xcopy /h /r /q /y "%FILE2%" "%FILE2%.old"   >nul 2>nul
::del /f /q         "%FILE2%"                 >nul 2>nul


::reseting icon-cache
call ie4uinit.exe -ClearIconCache         >nul 2>nul
call ie4uinit.exe -show                   >nul 2>nul
