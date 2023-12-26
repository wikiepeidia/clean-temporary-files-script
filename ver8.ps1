# Delete-TrashFiles.ps1

Write-Host "Delete trash files for Windows - version 10.0 - https://stackoverflow.com/questions/10925193/access-for-delete-files-through-a-batch-file-is-denied-at-windows-7"

# Combine similar deletion operations
$extensionsToDelete = '*.tmp', '*._mp', '*.log', '*.gid', '*.chk', '*.old',"*.bak","*.swp"
Remove-Item -Path "$env:SystemDrive\$extensionsToDelete" -Force -Recurse

Remove-Item -Path "$env:SystemDrive\recycled\*.*" -Force -Recurse
Remove-Item -Path "$env:windir\*.bak", "$env:windir\prefetch\*.*" -Force -Recurse
Remove-Item -Path "$env:windir\temp" -Force -Recurse
New-Item -ItemType Directory -Path "$env:windir\temp" | Out-Null

Remove-Item -Path "$env:userprofile\cookies\*.*", "$env:userprofile\recent\*.*" -Force
Remove-Item -Path "$env:userprofile\Local Settings\Temporary Internet Files\*.*" -Force -Recurse
Remove-Item -Path "$env:userprofile\Local Settings\Temp\*.*" -Force -Recurse
Remove-Item -Path "$env:userprofile\recent\*.*" -Force -Recurse

# Additional and more locations
Remove-Item -Path "$env:SystemDrive\*.swp" -Force -Recurse

# Parallelize deletion using PowerShell background jobs
$jobs = @()

# Add all deletion tasks to the $jobs array
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:windir\temp\*.*" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\appdata\local\temp\*.*" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\Application Data\Microsoft\Outlook\*.ost" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\AppData\Local\Microsoft\Windows\INetCache\*.*" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\AppData\Local\Temp\*.*" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Cookies\*.*" -Force -Recurse }
$jobs += Start-Job -ScriptBlock { Remove-Item -Path "$env:userprofile\AppData\Roaming\Microsoft\Windows\Recent\*.*" -Force -Recurse }

# Wait for all background jobs to complete
$jobs | Wait-Job | Receive-Job

Write-Host "The removal of trash files completed successfully. Thanks for using PTM's software"

# Pause to keep the console open
Pause