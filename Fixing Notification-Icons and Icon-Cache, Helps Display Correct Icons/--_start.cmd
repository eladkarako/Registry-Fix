::@echo off

pushd "%~sdp0"


del /f /q "%LocalAppData%\IconCache.db"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\ExplorerStartup*.*"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\NotifyIcon\*.*"

echo general:fixes, uncheck all, check just 'clear windows icon cache'. click fix-close, close program.
call "CodecTweakTool.exe"

del /f /q "%LocalAppData%\IconCache.db"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\iconcache_*.db"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\ExplorerStartup*.*"
del /f /q "%LocalAppData%\Microsoft\Windows\Explorer\NotifyIcon\*.*"


reg import "clear_reg_cache_of_tray_notification_streams.reg"

echo please manually reset your computer. everything should be fine after that.
pause

popd
exit /b 0