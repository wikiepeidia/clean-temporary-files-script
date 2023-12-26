@echo off

echo Delete trash files for Windows - version 2.0 - https://stackoverflow.com/questions/10925193/access-for-delete-files-through-a-batch-file-is-denied-at-windows-7

del /f /s /q %systemdrive%\*.tmp
del /f /s /q %systemdrive%\*._mp
del /f /s /q %systemdrive%\*.log 
del /f /s /q %systemdrive%\*.gid
del /f /s /q %systemdrive%\*.chk
del /f /s /q %systemdrive%\*.old 
del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak
del /f /s /q %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" 
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\recent\*.*"

rem Additional locations
del /f /s /q %systemdrive%\*.bak
del /f /s /q %systemdrive%\*.swp
del /f /s /q %windir%\temp\*.*
del /f /s /q %userprofile%\appdata\local\temp\*.*
del /f /s /q "%userprofile%\Application Data\Microsoft\Outlook\*.ost"

rem More locations
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\*.*"
del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
del /f /s /q "%userprofile%\AppData\Local\Temp\*.*"
del /f /s /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\*.*"
del /f /s /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*"

echo The removal of trash files completed successfully. Thanks for using PTM's software
echo. & pause
