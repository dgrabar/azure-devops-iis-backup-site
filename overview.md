# Android Mobile App Tasks for Azure DevOps (VSTS)

## Quick overview

The tasks available in this extension are:

- AndroidVersionExtract

Provided are powershell core and a TS script.

Check the [Github](https://github.com/dgrabar/azure-devops-mobile-tasks) for source code.

## Android - Extract app versionName and versionCode
Task to extract app versionName and versionCode from the AndroidManifest.xml file at build time.


## Example of usage from Azure

Extract app versionName and versionCode at build time:

```yml
- task: android-manifest-extract-version-name-code@1
  inputs:
    pathToAndroidManifest: ...
```

After task execution following variables will be available for the next tasks:
- VERSION_NAME
- VERSION_CODE

## Example of retrieving Android app versionName and versionCode from VS Code:

For the `AndroidVersionExtract`:

```
PowerShell: $env:INPUT_pathToAndroidManifest="..\Properties\AndroidManifest.xml"

PowerShell: tsc task.ts; node task.js
```