@echo off
chcp 65001 2>nul >nul

set "EXIT_CODE=0"

::make sure batch is ran "as admin" (this is an unofficial way)
net.exe session 1>nul 2>nul
if ["%ErrorLevel%"] NEQ ["0"] ( goto ERROR_NOTADMIN )

echo [INFO] OK. Ran As Admin. Continue... 1>&2
echo. 1>&2


echo -----------------------------  1>&2
echo - This will take a while... -  1>&2
echo -----------------------------  1>&2
echo. 1>&2

::looking for NGEN.EXE, favoring x64 versions, fallback to DotNet 2.0.
set "FILE_EXE=C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe"
if exist "%FILE_EXE%" ( goto OKCONTINUE )

set "FILE_EXE=C:\Windows\Microsoft.NET\Framework\v4.0.30319\ngen.exe"
if exist "%FILE_EXE%" ( goto OKCONTINUE )

set "FILE_EXE=C:\Windows\Microsoft.NET\Framework64\v2.0.50727\ngen.exe"
if exist "%FILE_EXE%" ( goto OKCONTINUE )

set "FILE_EXE=C:\Windows\Microsoft.NET\Framework\v2.0.50727\ngen.exe"
if exist "%FILE_EXE%" ( goto OKCONTINUE )


goto ERROR_NOTFOUNDNGENEXE


:OKCONTINUE
call "C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe" "executeQueuedItems"
set "EXIT_CODE=%ErrorLevel%"

echo. 1>&2
echo [INFO] DONE.   1>&2

goto END


::----------------------------------------------------

:ERROR_NOTADMIN
set "EXIT_CODE=1111"
echo [ERROR] you need to run this batch file "as admin". 1>&2
goto END

:ERROR_NOTFOUNDNGENEXE
set "EXIT_CODE=2222"
echo [ERROR] can not find ngen.exe for some reason, not v4 and not v2. weird!   1>&2
goto END

:END
::pause
exit /b %EXIT_CODE%



::------------------------
:: this will drain the queue of ngen, 
:: ngen will self execute copies itself and mscorsvw.exe when needed, 
:: showing many (if you have .Net SDK installed) or just few (if you only have .Net runtime) messages of "Compiling assembly"
:: even errors such as:
::   Failed to load dependency stdole of assembly...
::   The system cannot find the file specified...
::   Failed to load dependency...
:: are fine. this is just kind of cache. which can be done on the run of a .net application, but by pre-doing it, it loads .net applications faster.
:: usually the exit code is 0 (success) regardless of the error messages (example, shown above), but I explicitly return it anyway. the exit-code is stored so its value will not be effected by side-executions of command such as 'pause', 'echo' and such...
:: it is best to let the batch and ngen and mscorsvw finish. corrupted compiled assembly can be tricky to identify and repair.
:: Elad Karako June 2020.
::--------------------------------------------------
