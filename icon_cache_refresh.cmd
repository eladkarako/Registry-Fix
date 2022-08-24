@echo off
:: A Bit Overkill of verifying what version of EXE to use (x32/x64), with error handling.
:: I use `ie4uinit.exe -ClearIconCache || ie4uinit.exe -show` as an example for an execute that exist in both-folders.
:: This is just a dictionary code, you can make it more efficient by storing the files and paths using `SET`, and even skip the x32 check or put the x32 path in a variable and optinally overwrite it, then executing the file blindly.
:: P.s just f.y.i. - executing `ie4uinit` from either x32 or x64 does not really makes a difference (this is just an example..)
::

::::::22:34 13/12/2016 does not get generated after call :( .... 
:: it is 100% safe to delete IconCache.db, since it will be generated after reboot or by calling the `ie4uinit.exe -ClearIconCache` (next command).
::if exist %LocalAppData%\IconCache.db (
::  attrib -r -a -s -h -i %LocalAppData%\IconCache.db
::  del /f /q %LocalAppData%\IconCache.db >nul
::)


if exist %WINDIR%\SysWOW64\NUL (
  if exist %WINDIR%\SysWOW64\ie4uinit.exe (
    goto X64;
  )
  goto ERR;
)
if exist %WINDIR%\System32\NUL (
  if exist %WINDIR%\System32\ie4uinit.exe (
    goto X32;
  )
  goto ERR;
)


goto EXIT
::--------------------------------------------------- this part will be-reached only by directly passing through `GOTO`-directive.
:X64
%WINDIR%\SysWOW64\ie4uinit.exe -ClearIconCache
goto EXIT

:X32
%WINDIR%\System32\ie4uinit.exe -ClearIconCache
goto EXIT

:ERR
echo ERROR.
goto EXIT

:EXIT
pause
exit

