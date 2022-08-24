https://gist.github.com/eladkarako/8fb9c9c15722909dd0f3658169ab710a#file-run-registry-as-nt-authority-system-and-change-some-stuff-you-normally-can-not-md



you'll need:
1. `PsExec64.exe` - from `PSTools.zip` in https://docs.microsoft.com/en-us/sysinternals/downloads/psexec  
2. registry workshop - https://www.download.io/registry-workshop-download-windows.html  
3. 7zip - your own or https://github.com/eladkarako/7z_bundle
4. cmd (you have it already).
5. ability to run programs as (normal) admin.

<hr/>

prepare:
1. 7zip-extract files from `RegistryWorkshop.exe` to a folder, no need to install or run it.  
2. unzip `PSTools.zip` to another folder.  

<hr/>

then:
1. run `cmd` as admin. window title should say `Administrator: C:\Windows\system32\cmd.exe`.
2. change dir (`cd`) to where you've extracted the files from `PSTools.zip`.
3. run: `PsExec64.exe -accepteula -nobanner -sid "C:\users\Elad\Desktop\RegistryWorkshop\RegWorkshop64.exe"`. change `C:\users\Elad\Desktop\RegistryWorkshop\` to where you've actually extracted the RegistryWorkshop files to.  

<hr/>

on RegistryWorkshop:
1. click `Tools` menu, choose `Settings`.
2. check-ON: `Try to open registry keys by force if access is denied`, click OK, close the program.
3. open it again (3. run: `PsExec64.exe -accepteula -nobanner -sid "C:\users\Elad\Desktop\RegistryWorkshop\RegWorkshop64.exe"`. change `C:\users\Elad\Desktop\RegistryWorkshop\` to where you've actually extracted the RegistryWorkshop files to).

<img src="https://user-images.githubusercontent.com/415238/184405423-cfdf0373-d075-41a4-8934-149eafb25e41.png" />  

4. navigate to various keys and change them.

<hr/>

example:  

I'll change various power-scheme settings to make closing a laptop-lid do nothing,  
this will include what Windows is considering the "default" values.  
it will also cover all the available power-schemes not just the one that is currently active.  

1. select the very top `registry` head of the "tree". press CTRL+F and look for `5ca83367-6e45-459f-a27b-476b1d01c936`.

<img src="https://user-images.githubusercontent.com/415238/184406139-c48a7b80-67a8-4e84-828f-7378b9bb9373.png" />  

2. click the first result, in my case `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936`  
change to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936\DefaultPowerSchemeValues\381b4222-f694-41f0-9685-ff5bb260df2e` that's one power-scheme,  
double click `AcSettingIndex` and change its value to `0`, repeat for `DcSettingIndex`,  
switch to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936\DefaultPowerSchemeValues\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c`,  
do the same,  
and again with  
`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936\DefaultPowerSchemeValues\a1841308-3541-4fab-bc81-f71556f20b4a`  

repeat to other results,  
look in their sub-tree for AC and DC and change their value to `0`, in my case I had to change their value from `2` which means hibernate to `0` for do nothing.  

3. the reason you have to do this is since the Windows 10 is notoriously BAD, and often does not update the proper registry values,  
but only its visual value,  
so you often puzzled since you obviously see the new value has changed and its value is kept,  
but the actual effect you've expected doesn't work.  

you often see Google searches such as "Windows 10 power-scheme lid close settings do nothing is not working" or similar results,  
in my case I've identified the (very serious bug) a lot of time ago, when I've tried to set the screen lock timeout.  

4. importing external reg files is also possible, but it does not work very well since the registry workshop doesn't really parse the entire file,  
and import the values one by one you would expect with the Windows API that executed as nt authority system,  
but instead it just calls `reg import` in the background.  
that's lazy programing.

so for this file:  

```reg
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\a1841308-3541-4fab-bc81-f71556f20b4a\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\7648efa3-dd9c-4e3e-b566-50f929386280]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\96996bc0-ad50-47ec-923b-6f41874dd9eb]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

;---------------------------------------------------------------------------------------

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\a1841308-3541-4fab-bc81-f71556f20b4a\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\User\PowerSchemes\381b4222-f694-41f0-9685-ff5bb260df2e\4f971e89-eebd-4455-a8de-9e59040e7347\5ca83367-6e45-459f-a27b-476b1d01c936]
"DCSettingIndex"=dword:00000000
"ACSettingIndex"=dword:00000000

```

you'll better go manually for each location and change the values manually!

5. if you'll try to use `PsExec64.exe -accepteula -nobanner -i -s "C:\Windows\System32\reg.exe" "import" "your-reg-file.reg"` you'll notice it won't work (exit code non-zero), and when you view the changes afterwards, you'll see nothing has changed.

6. use this guide to apply various setting changes when you see something is not working for you.

<hr/>
<br/>


