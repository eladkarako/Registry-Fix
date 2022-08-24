@echo off
::  stops "Windows Font Cache Service"  and  "Windows Presentation
::  Foundation Font Cache 3.0.0.0" (if exist), clears the FS cache 
::  and re-enables them. A reboot is needed.  You may want to keep
::  "Windows Presentation Foundation Font Cache 3.0.0.0"  disabled
::  if you have any issues with higher than normal CPU on a legacy
::  Dot.Net applications.    /Created By Elad Karako. August 2017.
echo.
echo Font-Cache Fix.

  sc  config  "FontCache"          start=disabled      2>nul 1>nul
  sc  config  "FontCache3.0.0.0"   start=disabled      2>nul 1>nul
  sc  config  "WPFFontCache_v0400" start=disabled      2>nul 1>nul
    
  sc  stop    "FontCache"                              2>nul 1>nul
  net stop    "FontCache" /y                           2>nul 1>nul
  sc  stop    "FontCache3.0.0.0"                       2>nul 1>nul
  net stop    "FontCache3.0.0.0" /y                    2>nul 1>nul
  sc  stop    "WPFFontCache_v0400"                     2>nul 1>nul
  net stop    "WPFFontCache_v0400" /y                  2>nul 1>nul
    
  del /f /q   "%SystemRoot%\System32\FNTCACHE.DAT"     2>nul 1>nul
  del /f /q   "%SystemRoot%\SysWOW64\FNTCACHE.DAT"     2>nul 1>nul

  del /f /q   "%SystemRoot%\System32\StaticCache.dat"  2>nul 1>nul
  del /f /q   "%SystemRoot%\SysWOW64\StaticCache.dat"  2>nul 1>nul

  del /f /q   "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache*.dat"             2>nul 1>nul
  del /f /q   "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache\~FontCache*.dat"  2>nul 1>nul
  del /f /q   "%SystemRoot%\ServiceProfiles\LocalService\AppData\Local\FontCache\FontCache*.dat"   2>nul 1>nul
  
  sc  config  "FontCache"          start=auto          2>nul 1>nul
::sc  config  "FontCache3.0.0.0"   start=auto          2>nul 1>nul
::sc  config  "WPFFontCache_v0400" start=auto          2>nul 1>nul

echo Done.
echo.
echo note: please restart (by yourself).
echo.
pause