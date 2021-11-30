$folder=powershell get-date -format "{dd-MMM-yyyy__HH_mm}"

Invoke-Expression "& $env:windir\system32\inetsrv\appcmd.exe  add backup ""$folder-IIS"""
xcopy "C:\Windows\System32\inetsrv\backup\$folder-IIS\*" "d:\Deployment\$folder\IIS-config" /i /s /y

Invoke-Expression "& 'C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe' --% -verb:sync -source:iisapp=""YourSite/YourWeservice"" -dest:package=D:\Deployment\$folder\site.zip"
