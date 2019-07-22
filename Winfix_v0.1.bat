@ECHO OFF
chcp 65001
color 8b
title Winfix v0.1
mode con:cols=64 lines=16

// 2019.07.22 \\

:VISSZA
cls

echo. ==============================================================
echo. I                                                            I
echo. I                       Made by: Bazsee                      I
echo. I                                                            I
echo. I         This file is made to optimize the Windows          I
echo. I                  and to disable telemetry                  I
echo. ==============================================================
echo.
echo. Deleting OneDrive [1]
echo. Run [r]
echo. System info [i]
echo. Download [d] info at the input [l]
echo. Deleting Overwolf [v] 
echo. Delete default W10 apps [a]
echo.
set /p input=input: 

if %input%==r						 goto TISZTITAS
if %input%==i						 goto INFO
if %input%==1						 goto 1D
if %input%==d						 goto LET
if %input%==v						 goto UV
if %input%==a						 goto BAPP
if %input%==l						 goto DINFO

		:DINFO
@ECHO OFF
cls
echo.The "Download" menu downloads these programs:
echo.
echo.    Google Chrome         DotnetFX           Winrar  
echo.    Discord               Dropbox            Java
echo.    Teamspeak 3           CCleaner           VLC player
echo.    Steam                          
echo.    
echo.
echo Press a key to return...
pause >nul
goto VISSZA

		:1D
@ECHO OFF
cls

set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"

echo Closing OneDrive...
taskkill /f /im OneDrive.exe > NUL 2>&1
ping 127.0.0.1 -n 5 > NUL 2>&1

if exist %x64% (
%x64% /uninstall
) else (
%x86% /uninstall
)
ping 127.0.0.1 -n 5 > NUL 2>&1

echo Deleting remained files...
rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1 
REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
echo.
echo.


goto VISSZA

              :INFO
@echo off
mode con:cols=100 lines=50
systeminfo
echo.Videocard:
wmic path win32_VideoController get name
echo.
echo Press a key to return...
pause >nul
goto VISSZA
             
             :BEZARAS
exit
             :TISZTITAS
@ECHO OFF
cls

//credits to https://github.com/Sycnex/Windows10Debloater
//this is an extended version

*** OPTIMIZATION ***

	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DownloadMode /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSync /t REG_DWORD /d 2 /f
	reg add "HKLM\Software\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d "0" /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoDownload" /t REG_DWORD /d "2" /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "GPU Priority" /t REG_DWORD /d "8" /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" /v "Priority" /t REG_DWORD /d "6" /f
	reg add "HKCU\Control Panel\Desktop" /v "UserPreferencesMask" /t REG_BINARY /d "9012078012000000" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d "1" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v "NetworkThrottlingIndex" /t REG_DWORD /d "1" /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v DODownloadMode /t REG_DWORD /d 0 /f

*** Executed date***

//reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Manufacturer" /t REG_SZ /d "Winfix v0.1 | executed date: %date% " /f

*** SCHEDULED TASKS tweaks ***

	schtasks /Change /TN "Microsoft\Windows\AppID\SmartScreenSpecific" /Disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\ProgramDataUpdater" /Disable
	schtasks /Change /TN "Microsoft\Windows\Application Experience\StartupAppTask" /Disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
	schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /Disable
	schtasks /Change /TN "Microsoft\Windows\Autochk\Proxy" /Disable
	schtasks /Change /TN "Microsoft\Windows\CloudExperienceHost\CreateObjectTask" /Disable
	schtasks /Change /TN "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /Disable
	schtasks /Change /TN "Microsoft\Windows\DiskFootprint\Diagnostics" /Disable 
	schtasks /Change /TN "Microsoft\Windows\FileHistory\File History (maintenance mode)" /Disable
	schtasks /Change /TN "Microsoft\Windows\Maintenance\WinSAT" /Disable
	schtasks /Change /TN "Microsoft\Windows\NetTrace\GatherNetworkInfo" /Disable
	schtasks /Change /TN "Microsoft\Windows\PI\Sqm-Tasks" /Disable
	schtasks /Change /TN "Microsoft\Windows\Time Synchronization\ForceSynchronizeTime" /Disable
	schtasks /Change /TN "Microsoft\Windows\Time Synchronization\SynchronizeTime" /Disable
	schtasks /Change /TN "Microsoft\Windows\Windows Error Reporting\QueueReporting" /Disable

*** Set Windows Explorer to start on This PC instead of Quick Access ***

	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f

*** Remove Telemetry & Data Collection ***

	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata" /v PreventDeviceMetadataFromNetwork /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v DisableSettingSyncUserOverride /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "ContentDeliveryAllowed" /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenEnabled" /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SoftLandingEnabled" /t REG_DWORD /d "0" /f
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\WINEVT\Channels\Microsoft-Windows-Application-Experience/Program-Telemetry" /v "Enabled" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d "0" /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices" /v TCGSecurityActivationDisabled /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v DisableFileSyncNGSC /t REG_DWORD /d "1" /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\safer\codeidentifiers" /v authenticodeenabled /t REG_DWORD /d 0 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v DontSendAdditionalData /t REG_DWORD /d 1 /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d "1" /f
	reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d "1" /f
	reg add "HKLM\Software\Policies\Microsoft\Windows\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d "0" /f
	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackDocs" /t REG_DWORD /d 0 /f
	reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f
	reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v UxOption /t REG_DWORD /d 1 /f

*** WiFi Sense: HotSpot Sharing ***

	reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v value /t REG_DWORD /d 0 /f
	reg add "HKLM\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v value /t REG_DWORD /d 0 /f

*** Show hidden ***

	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSuperHidden" /t REG_DWORD /d 1 /f
	reg add "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t  REG_DWORD /d 0 /f

*** Disable Some Service ***

	sc stop DiagTrack
	sc config DiagTrack start= disabled

	sc stop diagnosticshub.standardcollector.service
	sc config diagnosticshub.standardcollector.service start= disabled

	sc stop dmwappushservice
	sc config dmwappushservice start= disabled

	sc stop WMPNetworkSvc
	sc config WMPNetworkSvc start= disabled

	sc stop RemoteRegistry
	sc config RemoteRegistry start= disabled

	sc stop TrkWks
	sc config TrkWks start= disabled

	sc stop SysMain
	sc config SysMain start= disabled

	sc stop MapsBroker
	sc config MapsBroker start= disabled

	sc stop RetailDemo
	sc config RetailDemo start= disabled

	sc stop SharedAccess
	sc config SharedAccess start= disabled

	sc stop RpcLocator
	sc config RpcLocator start= disabled

	sc stop SharedAccess
	sc config SharedAccess start= disabled

	sc stop SharedAccess
	sc config SharedAccess start= disabled

cls
echo Done, press a key to return
pause >nul
goto VISSZA

		:LET

cls
echo Downloading Ninite...
cd C:\Users\%USERNAME%\Downloads
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ninite.com/.net4.8-adoptjavax11-adoptjavax8-chrome-discord-dropbox-steam-teamviewer14-vlc-winrar/ninite.exe', 'ninite.exe')"
powershell -Command "Invoke-WebRequest https://ninite.com/.net4.8-adoptjavax11-adoptjavax8-chrome-discord-dropbox-steam-teamviewer14-vlc-winrar/ninite.exe -OutFile ninite.exe"
START C:\Users\%USERNAME%\Downloads\ninite.exe
cls
echo Downloading Ninite...
echo Downloading Teamspeak 3...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://files.teamspeak-services.com/releases/client/3.3.0/TeamSpeak3-Client-win64-3.3.0.exe', 'TeamSpeak3-Client-win64-3.3.0.exe')"
START C:\Users\%USERNAME%\Downloads\TeamSpeak3-Client-win64-3.3.0.exe /S
cls
Dism /online /enable-feature /featurename:NetFX3 /All /Source:%setupdrv%:\sources\sxs /LimitAccess
cls
echo Downloading Ninite...
echo Downloading Teamspeak 3...
echo Downloading: DotnetFx 3 and 3.5 ...
cls
Dism /online /enable-feature /featurename:NetFX4 /All /Source:%setupdrv%:\sources\sxs /LimitAccess
cls
echo Downloading Ninite...
echo Downloading Teamspeak 3...
echo Downloading: DotnetFx 3 , 3.5 ...
echo Downloading: DotnetFx 4.0+ ...
cls
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.ccleaner.com/ccsetup559.exe', 'ccsetup559.exe')"
START /wait C:\Users\%USERNAME%\Downloads\ccsetup559.exe /S
cls
echo Downloading Ninite...
echo Downloading Teamspeak 3...
echo Downloading: DotnetFx 3 , 3.5 ...
echo Downloading: DotnetFx 4.0+ ...
echo Downloading: CCleaner ...
echo please wait
TIMEOUT 5
START C:\"Program Files (x86)"\Overwolf\OWUninstaller.exe /qb
cls
echo Downloading Ninite...
echo Downloading Teamspeak 3...
echo Downloading: DotnetFx 3 , 3.5 ...
echo Downloading: DotnetFx 4.0+ ...
echo Downloading: CCleaner ...
echo Deleting OverWolf...

goto VISSZA

:UV
START C:\"Program Files (x86)"\Overwolf\OWUninstaller.exe /qb
goto VISSZA

		:BAPP

*** Deletes the least used W10 apps***

PowerShell -Command "Get-appxpackage -allusers *3dbuilder* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *windowsalarms* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *Appconnector* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *CandyCrushSaga* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *CandyCrushSodaSaga* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *zunemusic* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *windowsmaps* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *Messaging* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *bingfinance* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *zunevideo* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *bingnews* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *WindowsScan* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *bingsports* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *Twitter* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *CandyCrushSaga* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *CandyCrushSodaSaga* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.SkypeApp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Getstarted* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.RemoteDesktop* | Remove-AppxPackage"
PowerShell -Command "Get-appxpackage -allusers *windowscommunicationsapps* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.WindowsFeedbackHub* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.XboxGameOverlay* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.GetHelp* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.BingNews* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.MixedReality.Portal* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.OneConnect* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Microsoft.Asphalt8Airborne* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *AdobeSystemsIncorporated.AdobePhotoshopExpress* | Remove-AppxPackage"
PowerShell -Command "Get-AppxPackage -allusers *Facebook* | Remove-AppxPackage"

goto VISSZA
