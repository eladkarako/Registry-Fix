Message = "To work correctly, the script will close" & vbCR
Message = Message & "and restart the Windows Explorer shell." & vbCR
Message = Message & "This will not harm your system." & vbCR & vbCR
Message = Message & "Continue?"

X = MsgBox(Message, vbYesNo, "Notice")

If X = 6 Then

On Error Resume Next

Set WshShell = WScript.CreateObject("WScript.Shell")

WshShell.RegDelete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TrayNotify\IconStreams"
WshShell.RegDelete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\TrayNotify\PastIconsStream"

Set WshShell = Nothing

On Error GoTo 0

For Each Process in GetObject("winmgmts:"). _
	ExecQuery ("select * from Win32_Process where name='explorer.exe'")
   Process.terminate(0)
Next

MsgBox "Finished.", 4096, "Done"

Else 

MsgBox "No changes were made to your system.", 4096, "User Cancelled"

End If