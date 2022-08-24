@echo off
echo.
echo going to enable last-access on system (disabling NtfsDisableLastAccessUpdate)

@echo on
fsutil behavior set disablelastaccess 0

@echo off
echo.
echo current status:

@echo on
fsutil behavior query disablelastaccess


pause