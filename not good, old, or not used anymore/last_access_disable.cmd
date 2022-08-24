@echo off
echo.
echo going to disable last-access on system (enabling NtfsDisableLastAccessUpdate)

@echo on
fsutil behavior set disablelastaccess 1

@echo off
echo.
echo current status:

@echo on
fsutil behavior query disablelastaccess


pause