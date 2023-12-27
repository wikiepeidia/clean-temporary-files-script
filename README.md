# Clean Temporary Files Script

This script is designed to remove any temporary files from your computer.

## Table of Contents
- [Usage](#Usage)
- [Benefit](#Benefits)
- [Contribution](#sources)
- [Script explain in the nutshell](#structures)
- [Release](#Releases)
- [Notices](#Notices)
## Usage:
- Right-click the batch file and select "Run as administrator" to initiate the cleaning process.
- For PowerShell, you need to run `Set-ExecutionPolicy -ExecutionPolicy bypass` to execute the script. If you have never run any PowerShell scripts before, you may need to run it as an administrator for full performance.

## Benefits:
- A file size of less than 5KB is sufficient to clean most temporary files on your computer without the need for additional software.
- It helps save space on your PC, especially if you do not have enough space to download a cleaning software.

## Sources:
- [Stack Overflow (2020-2021)](https://stackoverflow.com/questions/10925193/access-for-delete-files-through-a-batch-file-is-denied-at-windows-7)
- Chat GPT
- GitHub Copilot

## Structures:
The script will attempt to remove files with the following extensions: `.tmp`, `._mp`, `.log`, `.gid`, `.chk`, `.old`, `.bak`, and `.swp`.

## Releases:
- [Download Latest Release](https://github.com/wikiepeidia/clean-temporary-files-script/releases)

### v0
- Build 0 (2020-2021, existed since June 2012 - Stack Overflow)
- Taken from Stack Overflow (in [Sources](#Sources))
- Slightly modified some texts.

### v1
- Build 1 (26/12/2023)
- Used Chat GPT to identify potential locations of temporary files (26/12/23)

### v1.1
- Build 2 (26/12/2023)
- Used Chat GPT to extend the coverage of temporary file locations (26/12/23)

### v1.2
- Build 3 (26/12/2023)
- Optimized the batch file using Chat GPT to increase deletion speed.

### V2 alpha
- Build 4 (26/12/2023)
- Utilized PowerShell to improve performance
- Does not contain logs and exits quickly due to the absence of a pause function

### V2 beta
- Build 5 (26/12/2023)
- Improved deletion speed but did not fix the bugs present in v2 alpha

### v2 RC
- Build 6 (26/12/2023)
- Attempted to use a custom log file, but it was unsuccessful
- Added a pause function

### v2 test release 1
- Build 7 (26/12/2023)
- Log still not showing

### v2 test release 2
- Build 8 (26/12/2023)
- Fixed an unapproved word using GitHub Copilot
- Log still not showing, but the deletion was successful

### Other V2 versions
- Attempts were made to use Copilot and Chat GPT, but none of them provided working logs (builds: 10-20)
- Therefore, if you use PowerShell, you will not have logs except for access denied files. Please use ver8.ps1 (build 10).

## Notices:
- Certain files are currently in use, which is normal, and you may encounter an "access is denied" message.
- Please remember that this script will delete files contain any of the above [extension](#structures) in it, for instance: *.old, *.THISISTHEOLDFILE... 
- Batch files can run in PowerShell, but vice versa will not work.
- It is important to note that renaming your files with any of the listed extensions poses a high risk of permanent data loss. Deleted files cannot be recovered, so it is recommended to double-check before running the script.
- For PowerShell, you need to run `Set-ExecutionPolicy -ExecutionPolicy bypass` if you have never run PowerShell scripts before.
- PowerShell can delete much faster but will not provide logs of the deleted files. If you prefer not to see a log of the deleted files, consider using PowerShell for the cleaning process.
