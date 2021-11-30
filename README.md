---
layout: page
title: Backup IIS config and website before deployment using Powershell
description: .
---

In order to backup your local IIS config files and backing up whole site, you can use Powershell script to perform this operation as part of your manual or streamlined DevOps release/deployment phase.



### Creating Powershell job as part of your release pipeline

With Azure DevOps you can create Powershell task to be run as part of your release pipeline as shown:

![Azure Powershell task](images/azure_iis_job.png)


### Powershell script

Run the following script as part of Powershell script job:

    $folder=powershell get-date -format "{dd-MMM-yyyy__HH_mm}"

    Invoke-Expression "& $env:windir\system32\inetsrv\appcmd.exe add backup ""$folder-IIS"""

    xcopy "C:\Windows\System32\inetsrv\backup\$folder-IIS\*" "d:\Deployment\$folder\IIS-config" /i /s /y

    Invoke-Expression "& 'C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe' --% -verb:sync -source:iisapp=""Yourwebsite/YourWebservice"" -dest:package=D:\Deployment\$folder\site.zip"
    

Ok, what do we have here:

First, we create temp variable where backup files will be outputted:

    $folder=powershell get-date -format "{dd-MMM-yyyy__HH_mm}"

Here, we are using Powershell 'get-date' function and we will format date to format acceptable for folder name on Windows drive. 


Then we are creating IIS config backup using native 'appcmd' app with dynamically named subfolder inside '.\inetsrv' folder. 

    Invoke-Expression "& $env:windir\system32\inetsrv\appcmd.exe add backup ""$folder-IIS"""

Note the way we are getting local 'Windows' path by using Powershell supported PATH: '$env:windir'.

Afterwards, we copy backup folder to the destination backup folder using 'xcopy' command:

    xcopy "C:\Windows\System32\inetsrv\backup\$folder-IIS\*" "d:\Deployment\$folder\IIS-config" /i /s /y

The crucial step is the usage of existing'msdeploy' app which is used for various deplyoments scenarios, in this case backing up the whole site:

    Invoke-Expression "& 'C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\msdeploy.exe' --% -verb:sync -source:iisapp=""Yourwebsite/YourWebservice"" -dest:package=D:\Deployment\$folder\site.zip"

If you don't have 'msdeploy' app installed, you can downlaod it from [here](https://www.iis.net/downloads/microsoft/web-deploy).

### Checking the output of Powershell task result

Once this job finishes, following should be seen inside destination backup folder:

![Output of Powershell task](images/backup_task_output.png)
