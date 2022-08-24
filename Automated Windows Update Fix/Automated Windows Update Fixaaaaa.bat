:
REM Windows Update FIX
REM Created by Negster22 12-6-05
REM V1.03 1-18-06 Updated to rename catroot2 folder and registered wups2.dll and msxml.dll
:
::Clears out proxy cache, places Windows Update sites in the Trusted Zone, places Windows Update sites in the exception list of IE Popup Blocker
::Starts all dependent services, registers required DLLS, empty the windows updates temporary folder, and deletes BITS pending download queue
:
REM start /w regedit.exe /s Ad-trusted.reg
cd \
color 0e
Rem Clear out proxy cache
proxycfg -d
REG QUERY "HKLM\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Internet Settings" /v Security_HKLM_only | find /i "Security_HKLM_Only" | find "1"
GOTO CONTROL%ERRORLEVEL%
:CONTROL0
REM MODIFY GLOBAL MACHINE SETTINGS
color 1f
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\microsoft.com\update" /V http /t REG_DWORD /D 2 /F
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\microsoft.com\update" /V https /t REG_DWORD /D 2 /F
REG ADD "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\microsoft.com\windowsupdate" /V http /t REG_DWORD /D 2 /F
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\update.microsoft.com" /v http /t REG_DWORD /D 2 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\update.microsoft.com" /v https /t REG_DWORD /D 2 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\windowsupdate.com" /v http /t REG_DWORD /D 2 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\windowsupdate.microsoft.com" /v http /t REG_DWORD /D 2 /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\download.microsoft.com" /v http /t REG_DWORD /D 2 /f 
:Allow popups from the following Windows Update sites in Internet Explorer
reg add "HKLM\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.microsoft.com /t REG_BINARY /f
reg add "HKLM\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.download.microsoft.com /t REG_BINARY /f
reg add "HKLM\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.windowsupdate.com /t REG_BINARY /f
reg add "HKLM\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.windowsupdate.microsoft.com /t REG_BINARY /f
GOTO CONTINUE
:CONTROL1
REM MODIFY LOCAL USER SETTINGS
color 5b
:Add Windows Update sites to the Trusted Zone of Internet Explorer (if Security_HKLM_only is not set, use HKCU)
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\microsoft.com\update" /V http /t REG_DWORD /D 2 /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\microsoft.com\update" /V https /t REG_DWORD /D 2 /F
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\microsoft.com\windowsupdate" /V http /t REG_DWORD /D 2 /F
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\update.microsoft.com" /v http /t REG_DWORD /D 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\update.microsoft.com" /v https /t REG_DWORD /D 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\windowsupdate.com" /v http /t REG_DWORD /D 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\windowsupdate.microsoft.com" /v http /t REG_DWORD /D 2 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\ZoneMap\Domains\download.microsoft.com" /v http /t REG_DWORD /D 2 /f 
:Allow popups from the following Windows Update sites in Internet Explorer
reg add "HKCU\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.microsoft.com /t REG_BINARY /f
reg add "HKCU\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.download.microsoft.com /t REG_BINARY /f
reg add "HKCU\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.windowsupdate.com /t REG_BINARY /f
reg add "HKCU\Software\Microsoft\Internet Explorer\New Windows\Allow" /v *.windowsupdate.microsoft.com /t REG_BINARY /f
:CONTINUE
:Stop the Windows Update and BITS service while applying fixes
Net stop WuAuServ
Net stop BITS
:Register required DLLs
regsvr32 /s /i wuapi.dll 
regsvr32 /s /i wups.dll
regsvr32 /s /i wuaueng.dll
regsvr32 /s /i wuaueng1.dll
regsvr32 /s /i wucltui.dll
regsvr32 /s /i wuweb.dll
regsvr32 /s /i jscript.dll
regsvr32 /s /i atl.dll
regsvr32 /s /i softpub.dll
regsvr32 /s /i msxml3.dll
:Added next two DLLs in v1.03
regsvr32 /s /i wups2.dll
regsvr32 /s /i msxml.dll
regsvr32 /s /i qmgr.dll
regsvr32 /s /i qmgrprxy.dll

::Elad Addon. Register CPL fixes missings parts of windows.
regsvr32 /s /i ALSNDMGR.CPL
regsvr32 /s /i CRSWPP.DLL
regsvr32 /s /i CRYPTDLG.DLL
regsvr32 /s /i CSSEQCHK.DLL
regsvr32 /s /i DSSENH.DLL 
regsvr32 /s /i Daxctle.ocx
regsvr32 /s /i FPWPP.DLL
regsvr32 /s /i FTPWPP.DLL
regsvr32 /s /i Gpkcsp.dll
regsvr32 /s /i IEDKCS32.DLL
regsvr32 /s /i INITPKI.DLL
regsvr32 /s /i MSR2C.DLL
regsvr32 /s /i MSTIME.DLL
regsvr32 /s /i POSTWPP.DLL
regsvr32 /s /i PhysX.cpl
regsvr32 /s /i RSAENH.DLL 
regsvr32 /s /i RTSndMgr.CPL
regsvr32 /s /i Sccbase.dll
regsvr32 /s /i Slbcsp.dll
regsvr32 /s /i WEBPOST.DLL
regsvr32 /s /i WINTRUST.DLL
regsvr32 /s /i WPWIZDLL.DLL
regsvr32 /s /i access.cpl
regsvr32 /s /i acelpdec.ax
regsvr32 /s /i actxprxy.dll
regsvr32 /s /i appwiz.cpl
regsvr32 /s /i asctrls.ocx
regsvr32 /s /i browseui.dll
regsvr32 /s /i browseui.dll
regsvr32 /s /i browsewm.dll
regsvr32 /s /i bthprops.cpl
regsvr32 /s /i cdfview.dll
regsvr32 /s /i comcat.dll
regsvr32 /s /i corpol.dll
regsvr32 /s /i cryptdlg.dll
regsvr32 /s /i cryptext.dll
regsvr32 /s /i danim.dll
regsvr32 /s /i datime.dll
regsvr32 /s /i desk.cpl
regsvr32 /s /i dispex.dll
regsvr32 /s /i dxmasf.dll
regsvr32 /s /i dxtmsft.dll
regsvr32 /s /i dxtrans.dll
regsvr32 /s /i firewall.cpl
regsvr32 /s /i hdwwiz.cpl
regsvr32 /s /i hhctrl.ocx
regsvr32 /s /i hlink.dll
regsvr32 /s /i icmfilter.dll
regsvr32 /s /i iepeers.dll
regsvr32 /s /i iesetup.dll
regsvr32 /s /i ils.dll
regsvr32 /s /i imgutil.dll
regsvr32 /s /i inetcfg.dll
regsvr32 /s /i inetcomm.dll
regsvr32 /s /i inetcpl.cpl
regsvr32 /s /i infocardcpl.cpl
regsvr32 /s /i inseng.dll
regsvr32 /s /i intl.cpl
regsvr32 /s /i irprops.cpl
regsvr32 /s /i javacpl.cpl
regsvr32 /s /i joy.cpl
regsvr32 /s /i jscript.dll
regsvr32 /s /i l3codecx.ax
regsvr32 /s /i licdll.dll
regsvr32 /s /i licmgr10.dll
regsvr32 /s /i lmrt.dll
regsvr32 /s /i main.cpl
regsvr32 /s /i mlang.dll
regsvr32 /s /i mmefxe.ocx
regsvr32 /s /i mmsys.cpl
regsvr32 /s /i mobsync.dll
regsvr32 /s /i mpg4ds32.ax
regsvr32 /s /i msapsspc.dllspcCreateSspiReg
regsvr32 /s /i msdxm.ocx
regsvr32 /s /i mshtml.dll
regsvr32 /s /i mshtmled.dll
regsvr32 /s /i msident.dll
regsvr32 /s /i msieftp.dll
regsvr32 /s /i msinet.ocx
regsvr32 /s /i msnsspc.dllspcCreateSspiReg
regsvr32 /s /i msoeacct.dll
regsvr32 /s /i msrating.dll
regsvr32 /s /i msxml.dll
regsvr32 /s /i ncpa.cpl
regsvr32 /s /i netsetup.cpl
regsvr32 /s /i nusrmgr.cpl
regsvr32 /s /i nvcpl.cpl
regsvr32 /s /i nwc.cpl
regsvr32 /s /i occache.dll
regsvr32 /s /i occache.dll
regsvr32 /s /i odbccp32.cpl
regsvr32 /s /i oleaut32.dll
regsvr32 /s /i pngfilt.dll
regsvr32 /s /i powercfg.cpl
regsvr32 /s /i regwizc.dll
regsvr32 /s /i rsabase.dll
regsvr32 /s /i scrobj.dll
regsvr32 /s /i scrrun.dll mstinit.exeetup
regsvr32 /s /i sendmail.dll
regsvr32 /s /i shdoc401.dll
regsvr32 /s /i shdoc401.dll
regsvr32 /s /i shdocvw.dll
regsvr32 /s /i shdocvw.dll
regsvr32 /s /i softpub.dll
regsvr32 /s /i sysdm.cpl
regsvr32 /s /i tdc.ocx
regsvr32 /s /i telephon.cpl
regsvr32 /s /i thumbvw.dll
regsvr32 /s /i timedate.cpl
regsvr32 /s /i urlmon.dll
regsvr32 /s /i urlmon.dll
regsvr32 /s /i vbscript.dll
regsvr32 /s /i voxmsdec.ax
regsvr32 /s /i webcheck.dll
regsvr32 /s /i wininet.dll
regsvr32 /s /i wscui.cpl
regsvr32 /s /i wshext.dll
regsvr32 /s /i wshom.ocx
regsvr32 /s /i wuaucpl.cpl



:
::Clear all the pending downloads from BITS & let BITS recreate qmgr0.dat and qmgr1.dat
cd %ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader
del *.* /Q
:
: Rename the Catroot2  directory, since it is automatically recreated by Windows
:
net stop cryptsvc
IF EXIST %systemroot%\system32\catroot2 attrib -r -s -h %systemroot%\system32\catroot2
REM Make allowances for the fix having been run more than once. Check if the dir was already renamed in prior run 
IF EXIST %systemroot%\system32\oldcatroot2 rmdir /Q /S %systemroot%\system32\oldcatroot2
IF EXIST %systemroot%\system32\catroot2 ren %systemroot%\system32\catroot2 oldcatroot2
:
cd %WINDIR%
::See if temp dir exists from previous execution of script, and delete if it does (XP & 2000)
IF EXIST Sdold rmdir /Q /S Sdold
:Clear old data but save Windows Update temp dir
attrib -r -h -s SoftwareDistribution
ren SoftwareDistribution Sdold
:
:Stop and start the Automatic Update service,  so it will recreate the temp folder
Net start WuAuServ
Net stop WuAuServ
:
:Now restore Update History file from backup
attrib -r -h -s SoftwareDistribution
mkdir %WINDIR%\SoftwareDistribution\DataStore
copy %WINDIR%\Sdold\DataStore\DataStore.edb %WINDIR%\SoftwareDistribution\DataStore\
:
:Now restore EventsLog file from backup
COPY /y %WINDIR%\Sdold\ReportingEvents.log %WINDIR%\SoftwareDistribution\
:
:Restart automatic updates service. Start all other dependent services and set to automatic startup.  Set the following services to autostart 
:Background Intelligent Transfer Service (BITS),  Automatic Updates (WuAuServ), Event Log (EventLog), Cryptographic Services (CryptSvc), :Remote Procedure Call (RpcSs)
:
Net start WuAuServ
sc config WuAuServ start= auto
::Set to automatic
::Start Background Intelligent Transfer Service
Net start BITS
::Set BITS to manual
sc config BITS start= demand
::Start  Event Log Service
Net start EventLog
sc config EventLog start= auto
::Start Cryptographic Services
Net start CryptSvc
sc config CryptSvc start= auto
::Turn on Remote Procedure Call Service
Net start RpcSs
sc config RpcSs start= auto
:EXIT