@echo off

echo Delete trash files for Windows - version 3.0 - https://stackoverflow.com/questions/10925193/access-for-delete-files-through-a-batch-file-is-denied-at-windows-7

:: Combine similar deletion operations
del /f /s /q %systemdrive%\*.tmp %systemdrive%\*._mp %systemdrive%\*.log %systemdrive%\*.gid %systemdrive%\*.chk %systemdrive%\*.old

del /f /s /q %systemdrive%\recycled\*.*
del /f /s /q %windir%\*.bak %windir%\prefetch\*.*
rd /s /q %windir%\temp & md %windir%\temp
del /f /q %userprofile%\cookies\*.*
del /f /q %userprofile%\recent\*.*
del /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*" 
del /f /s /q "%userprofile%\Local Settings\Temp\*.*"
del /f /s /q "%userprofile%\recent\*.*"

:: Additional and more locations
del /f /s /q %systemdrive%\*.swp

:: Parallelize deletion using start command (adjust as needed)
start /B del /f /s /q %windir%\temp\*.*
start /B del /f /s /q %userprofile%\appdata\local\temp\*.*
start /B del /f /s /q "%userprofile%\Application Data\Microsoft\Outlook\*.ost"

start /B del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\INetCache\*.*"
start /B del /f /s /q "%userprofile%\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
start /B del /f /s /q "%userprofile%\AppData\Local\Temp\*.*"
start /B del /f /s /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Cookies\*.*"
start /B del /f /s /q "%userprofile%\AppData\Roaming\Microsoft\Windows\Recent\*.*"

echo The removal of trash files completed successfully. Thanks for using PTM's software
echo. & pause
