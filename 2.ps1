# Delete-TrashFiles.ps1

Write-Host "Delete trash files for Windows - version 5.0 - https://stackoverflow.com/questions/10925193/access-for-delete-files-through-a-batch-file-is-denied-at-windows-7"

# Combine similar deletion operations
$extensionsToDelete = '*.tmp', '*._mp', '*.log', '*.gid', '*.chk', '*.old'
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

# Parallelize deletion using PowerShell background jobs for all locations
$locations = @(
    "$env:windir\temp\*.*",
    "$env:userprofile\appdata\local\temp\*.*",
    "$env:userprofile\Application Data\Microsoft\Outlook\*.ost",
    "$env:userprofile\AppData\Local\Microsoft\Windows\INetCache\*.*",
    "$env:userprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*",
    "$env:userprofile\AppData\Local\Temp\*.*",
    "$env:userprofile\AppData\Roaming\Microsoft\Windows\Cookies\*.*",
    "$env:userprofile\AppData\Roaming\Microsoft\Windows\Recent\*.*"
)

# Start background jobs for parallel deletion
$jobs = $locations | ForEach-Object {
    Start-Job -ScriptBlock { param($location) Remove-Item -Path $location -Force -Recurse } -ArgumentList $_
}

# Wait for all background jobs to complete
$jobs | Wait-Job | Receive-Job

Write-Host "The removal of trash files completed successfully. Thanks for using PTM's software"
