@echo off

:: --------------------------------
:: -  RUN AS ADMINISTRATOR.       -
:: --------------------------------
:: -  SELECT x32 or x64 VERSION   -
:: --------------------------------


::set TARGET=%windir%\system32\wbem
set TARGET=%windir%\SysWOW64\wbem

::--------------------------------------------------------Service STOP
sc config winmgmt start=disabled
net stop winmgmt /y

::--------------------------------------------------------DLL Register
%systemdrive%
cd %TARGET%
for %%e in (*.dll) do (
  call regsvr32 /s "%%e"
)

::--------------------------------------------------------Service START
call %TARGET%\wmiprvse.exe /regserver 
call %TARGET%\winmgmt.exe /regserver 
sc config winmgmt start=auto
net start winmgmt

::--------------------------------------------------------Repository Rebuild
%systemdrive%
cd %TARGET%
for %%e in (*.mof) do (
  call mofcomp "%%e"
)

for %%e in (*.mfl) do (
  call mofcomp "%%e"
)

::--------------------------------------------------------Done
pause
::::exit