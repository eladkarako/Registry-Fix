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
regsvr32 /s wuapi.dll 
regsvr32 /s wups.dll
regsvr32 /s wuaueng.dll
regsvr32 /s wuaueng1.dll
regsvr32 /s wucltui.dll
regsvr32 /s wuweb.dll
regsvr32 /s jscript.dll
regsvr32 /s atl.dll
regsvr32 /s softpub.dll
regsvr32 /s msxml3.dll
:Added next two DLLs in v1.03
regsvr32 /s wups2.dll
regsvr32 /s msxml.dll
regsvr32 /s qmgr.dll
regsvr32 /s qmgrprxy.dll

::Elad Addon. Register CPL fixes missings parts of windows.
regsvr32 /s ALSNDMGR.CPL
regsvr32 /s CRSWPP.DLL
regsvr32 /s CRYPTDLG.DLL
regsvr32 /s CSSEQCHK.DLL
regsvr32 /s DSSENH.DLL 
regsvr32 /s Daxctle.ocx
regsvr32 /s FPWPP.DLL
regsvr32 /s FTPWPP.DLL
regsvr32 /s Gpkcsp.dll
regsvr32 /s IEDKCS32.DLL
regsvr32 /s INITPKI.DLL
regsvr32 /s MSR2C.DLL
regsvr32 /s MSTIME.DLL
regsvr32 /s POSTWPP.DLL
regsvr32 /s PhysX.cpl
regsvr32 /s RSAENH.DLL 
regsvr32 /s RTSndMgr.CPL
regsvr32 /s Sccbase.dll
regsvr32 /s Slbcsp.dll
regsvr32 /s WEBPOST.DLL
regsvr32 /s WINTRUST.DLL
regsvr32 /s WPWIZDLL.DLL
regsvr32 /s access.cpl
regsvr32 /s acelpdec.ax
regsvr32 /s actxprxy.dll
regsvr32 /s appwiz.cpl
regsvr32 /s asctrls.ocx
regsvr32 /s browseui.dll
regsvr32 /s browseui.dll /I 
regsvr32 /s browsewm.dll
regsvr32 /s bthprops.cpl
regsvr32 /s cdfview.dll
regsvr32 /s comcat.dll
regsvr32 /s corpol.dll
regsvr32 /s cryptdlg.dll
regsvr32 /s cryptext.dll
regsvr32 /s danim.dll
regsvr32 /s datime.dll
regsvr32 /s desk.cpl
regsvr32 /s dispex.dll
regsvr32 /s dxmasf.dll
regsvr32 /s dxtmsft.dll
regsvr32 /s dxtrans.dll
regsvr32 /s firewall.cpl
regsvr32 /s hdwwiz.cpl
regsvr32 /s hhctrl.ocx
regsvr32 /s hlink.dll
regsvr32 /s icmfilter.dll
regsvr32 /s iepeers.dll
regsvr32 /s iesetup.dll /i
regsvr32 /s ils.dll
regsvr32 /s imgutil.dll
regsvr32 /s inetcfg.dll
regsvr32 /s inetcomm.dll
regsvr32 /s inetcpl.cpl
regsvr32 /s infocardcpl.cpl
regsvr32 /s inseng.dll
regsvr32 /s intl.cpl
regsvr32 /s irprops.cpl
regsvr32 /s javacpl.cpl
regsvr32 /s joy.cpl
regsvr32 /s jscript.dll
regsvr32 /s l3codecx.ax
regsvr32 /s licdll.dll
regsvr32 /s licmgr10.dll
regsvr32 /s lmrt.dll
regsvr32 /s main.cpl
regsvr32 /s mlang.dll
regsvr32 /s mmefxe.ocx
regsvr32 /s mmsys.cpl
regsvr32 /s mobsync.dll
regsvr32 /s mpg4ds32.ax
regsvr32 /s msapsspc.dllspcCreateSspiReg
regsvr32 /s msdxm.ocx
regsvr32 /s mshtml.dll
regsvr32 /s mshtmled.dll
regsvr32 /s msident.dll
regsvr32 /s msieftp.dll
regsvr32 /s msinet.ocx
regsvr32 /s msnsspc.dllspcCreateSspiReg
regsvr32 /s msoeacct.dll
regsvr32 /s msrating.dll
regsvr32 /s msxml.dll
regsvr32 /s ncpa.cpl
regsvr32 /s netsetup.cpl
regsvr32 /s nusrmgr.cpl
regsvr32 /s nvcpl.cpl
regsvr32 /s nwc.cpl
regsvr32 /s occache.dll
regsvr32 /s occache.dll /i
regsvr32 /s odbccp32.cpl
regsvr32 /s oleaut32.dll
regsvr32 /s pngfilt.dll
regsvr32 /s powercfg.cpl
regsvr32 /s regwizc.dll
regsvr32 /s rsabase.dll
regsvr32 /s scrobj.dll
regsvr32 /s scrrun.dll mstinit.exeetup
regsvr32 /s sendmail.dll
regsvr32 /s shdoc401.dll
regsvr32 /s shdoc401.dll /i
regsvr32 /s shdocvw.dll
regsvr32 /s shdocvw.dll /I
regsvr32 /s softpub.dll
regsvr32 /s sysdm.cpl
regsvr32 /s tdc.ocx
regsvr32 /s telephon.cpl
regsvr32 /s thumbvw.dll
regsvr32 /s timedate.cpl
regsvr32 /s urlmon.dll
regsvr32 /s urlmon.dll /i
regsvr32 /s vbscript.dll
regsvr32 /s voxmsdec.ax
regsvr32 /s webcheck.dll
regsvr32 /s wininet.dll
regsvr32 /s wscui.cpl
regsvr32 /s wshext.dll
regsvr32 /s wshom.ocx
regsvr32 /s wuaucpl.cpl



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