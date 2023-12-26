# Delete-TrashFiles.ps1

Write-Host "Delete trash files for Windows - version 10.0 - https://stackoverflow.com/questions/10925193/access-for-delete-files-through-a-batch-file-is-denied-at-windows-7"

# Function to log an entry to the console
function Log-Entry {
    param([string]$message)
    Write-Host $message
}
# Convert the function to a script block
$logEntryFunction = [scriptblock]::Create((Get-Command Log-Entry).Definition)
# Combine similar deletion operations
$extensionsToDelete = '*.tmp', '*._mp', '*.log', '*.gid', '*.chk', '*.old',".bak",".swp"
foreach ($path in $pathsToDelete) {
    $itemsToDelete = Get-ChildItem -Path $path -Recurse -Force -ErrorAction SilentlyContinue
    $itemsToDelete | ForEach-Object { Log-Entry "Deleting file: $_" }
    $itemsToDelete | Remove-Item -Force -Recurse
}
Remove-Item -Path "$env:SystemDrive\$extensionsToDelete" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }

Remove-Item -Path "$env:SystemDrive\recycled\*.*" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }
Remove-Item -Path "$env:windir\*.bak", "$env:windir\prefetch\*.*" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }
Remove-Item -Path "$env:windir\temp" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }
New-Item -ItemType Directory -Path "$env:windir\temp" | Out-Null

Remove-Item -Path "$env:userprofile\cookies\*.*", "$env:userprofile\recent\*.*" -Force | ForEach-Object { Log-Entry "Deleted files: $_" }
Remove-Item -Path "$env:userprofile\Local Settings\Temporary Internet Files\*.*" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }
Remove-Item -Path "$env:userprofile\Local Settings\Temp\*.*" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }
Remove-Item -Path "$env:userprofile\recent\*.*" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }

# Additional and more locations
Remove-Item -Path "$env:SystemDrive\*.swp" -Force -Recurse | ForEach-Object { Log-Entry "Deleted files: $_" }

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
# Start background jobs for parallel deletion
$jobs = $locations | ForEach-Object {
    Start-Job -ScriptBlock {
        param($location, $logEntry)
        $itemsToDelete = Get-ChildItem -Path $location -Force -Recurse -ErrorAction SilentlyContinue
        $itemsToDelete | ForEach-Object {
            & $logEntry "Deleting file: $_"
            Remove-Item -Path $_.FullName -Force -ErrorAction SilentlyContinue
        }
    } -ArgumentList $_, $logEntryFunction
}

# Wait for all background jobs to complete
$jobs | Wait-Job | Receive-Job

Write-Host "The removal of trash files completed successfully. Thanks for using PTM's software"
