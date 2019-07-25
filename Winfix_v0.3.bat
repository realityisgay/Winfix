@ECHO OFF
chcp 65001
color fc
version date 2019.07.22
title Winfix v0.2
mode con:cols=50 lines=3


>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (

    echo         You should run it as administrator!
    echo       Requesting administrative privileges...
    goto UAC

) else ( goto GOTA )

:UAC
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:GOTA
    pushd "%CD%"
    CD /D "%~dp0"

mode con:cols=64 lines=16
color 8b
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

//reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OEMInformation" /v "Manufacturer" /t REG_SZ /d "Winfix v0.2 | executed date: %date% " /f

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
	schtasks /Change /TN "NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable
	schtasks /Change /TN "NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable


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

	sc stop NvTelemetryContainer
	sc config NvTelemetryContainer start= disabled

netsh advfirewall firewall add rule name="Winfix telemetry block" ^
   dir=in interface=any action=block remoteip=13.76.218.117,13.76.219.191,13.76.219.210,13.77.112.132,13.78.235.126,13.78.235.247,13.79.239.69,13.79.239.82,13.80.12.54,13.81.5.53,13.88.145.128,13.107.3.128,13.107.3.254,13.107.5.80,13.107.5.88,13.107.6.156,13.107.6.158,13.107.6.254,13.107.13.88,13.107.18.11,13.107.18.254,13.107.21.200,13.107.21.229,13.107.42.11,13.107.42.12,13.107.42.13,13.107.42.254,13.107.46.88,13.107.47.88,13.107.49.254,13.107.128.254,13.107.136.254,13.107.255.72,13.107.255.73,13.107.255.74,23.96.52.53,23.96.208.208,23.97.61.137,23.97.178.173,23.97.209.97,23.99.109.44,23.99.109.64,23.99.116.116,23.99.121.207,23.100.122.175,23.101.156.198,23.101.158.111,40.69.176.16,40.70.0.108,40.74.70.63,40.77.225.248,40.77.230.45,40.79.48.16,40.83.74.46,40.83.127.51,40.83.150.233,40.85.78.63,40.89.135.48,40.90.23.0-40.90.23.255,40.90.136.1,40.90.136.19,40.90.136.20,40.90.136.163,40.90.136.166,40.90.136.180,40.90.190.179,40.91.76.238,40.97.161.50,40.101.12.130,40.101.18.242,40.101.19.146,40.101.46.178,40.101.80.178,40.101.83.18,40.101.124.194,40.101.137.18,40.102.34.194,40.112.72.44,40.112.75.175,40.112.90.122,40.112.91.29,40.113.0.16,40.113.97.222,40.114.54.223,40.114.140.1,40.114.241.141,40.115.33.128,40.117.96.136,40.117.190.72,40.118.61.1,40.118.103.7,40.118.106.130,40.121.213.159,40.126.1.166,40.126.9.5,40.127.128.174,40.127.142.76,40.127.195.156,51.136.15.177,51.136.37.147,51.140.65.84,51.140.98.69,51.140.127.197,51.141.26.229,51.141.32.51,51.141.166.104,51.144.108.120,52.97.135.114,52.97.146.34,52.97.151.50,52.97.151.82,52.98.66.98,52.109.8.19,52.109.8.20,52.109.8.21,52.109.12.18,52.109.12.19,52.109.12.20,52.109.12.21,52.109.12.22,52.109.12.23,52.109.12.24,52.109.76.30,52.109.76.31,52.109.76.32,52.109.76.33,52.109.76.34,52.109.76.35,52.109.76.36,52.109.76.40,52.109.88.6,52.109.88.34,52.109.88.35,52.109.88.36,52.109.88.37,52.109.88.38,52.109.88.39,52.109.88.40,52.109.88.44,52.109.120.17,52.109.120.18,52.109.120.19,52.109.120.20,52.109.120.21,52.109.120.22,52.109.120.23,52.109.124.18,52.109.124.19,52.109.124.20,52.109.124.21,52.109.124.22,52.109.124.23,52.109.124.24,52.113.194.131,52.136.230.174,52.138.148.87,52.138.148.89,52.138.148.159,52.142.114.2,52.142.114.176,52.142.119.134,52.156.196.151,52.156.204.185,52.158.238.42,52.163.118.68,52.164.191.55,52.164.227.208,52.164.251.44,52.166.110.64,52.166.110.215,52.166.120.77,52.167.88.112,52.168.24.174,52.169.71.150,52.170.194.77,52.171.136.200,52.173.152.64,52.176.224.96,52.178.161.41,52.178.163.85,52.178.193.116,52.179.13.204,52.183.104.36,52.184.82.129,52.184.168.116,52.225.136.36,52.230.10.183,52.230.240.94,52.232.16.77,52.232.19.76,52.232.69.150,52.233.199.249,52.239.150.170,52.239.151.138,52.239.151.170,52.239.157.138,52.239.157.202,52.239.177.36,52.239.177.68,52.239.177.100,52.239.184.10,52.239.184.42,52.239.207.100,64.4.16.212,64.4.16.214,64.4.16.216,64.4.16.218,64.4.23.0-64.4.23.255,64.4.54.18,64.4.54.22,64.4.54.253,64.4.54.254,65.52.98.231,65.54.187.128,65.54.187.130,65.54.187.131,65.54.187.132,65.54.187.134,65.54.198.196,65.55.108.23,65.55.130.50,65.55.223.0-65.55.223.255,104.40.210.32,104.40.211.35,104.41.219.140,104.42.41.237,104.43.203.255,104.44.80.172,104.44.88.24,104.44.88.28,104.44.88.103,104.45.18.177,104.46.91.34,104.208.248.16,104.214.77.221,104.214.220.181,104.215.146.200,131.253.14.227,131.253.14.229,131.253.14.230,131.253.14.231,131.253.61.0-131.253.61.255,134.170.178.97,134.170.185.70,134.170.188.248,137.116.44.10,137.116.234.82,137.117.142.136,137.117.144.39,137.117.235.16,138.91.122.49,157.55.56.0-157.55.56.255,157.55.109.7,157.55.109.224,157.55.109.226,157.55.109.228,157.55.109.230,157.55.109.232,157.55.129.21,157.55.134.136,157.55.134.138,157.55.134.140,157.55.134.142,157.55.135.128,157.55.135.130,157.55.135.132,157.55.135.134,157.56.57.5,168.63.18.79,168.63.102.42,191.237.208.126,191.239.213.197,204.79.197.0-204.79.197.255,204.152.141.244,207.46.7.252,207.46.26.12,207.46.26.14,207.46.26.16,207.46.26.18,207.46.101.29,207.46.153.155,207.46.194.14,207.46.194.25,207.46.194.33,207.46.194.40,207.46.223.94,13.66.56.243,13.68.31.193,13.68.82.8,13.78.130.220,13.78.232.226,13.78.233.133,13.92.194.212,20.44.86.43,23.99.49.121,23.102.4.253,23.102.21.4,23.103.182.126,40.68.222.212,40.69.153.67,40.70.220.248,40.70.221.249,40.77.228.47,40.77.228.87,40.77.228.92,40.77.232.101,40.79.85.125,40.90.221.9,40.115.3.210,40.115.119.185,51.140.40.236,51.141.13.164,51.143.111.7,51.143.111.81,52.114.6.46,52.114.6.47,52.114.7.37,52.114.32.6,52.114.32.7,52.114.32.8,52.114.74.43,52.114.74.44,52.114.74.45,52.114.75.78,52.114.75.79,52.114.75.150,52.114.76.34,52.114.76.35,52.114.76.37,52.114.77.33,52.114.77.34,52.114.77.137,52.114.88.20,52.114.88.28,52.114.88.29,52.114.128.8,52.114.128.9,52.114.128.10,52.114.128.43,52.114.128.44,52.114.128.58,52.114.132.21,52.114.132.22,52.114.132.23,52.114.132.73,52.114.132.74,52.114.158.50,52.114.158.52,52.114.158.53,52.114.158.91,52.114.158.92,52.114.158.102,52.138.204.217,52.138.216.83,52.155.172.105,52.158.208.111,52.164.240.33,52.164.240.59,52.164.241.205,52.169.189.83,52.170.83.19,52.174.22.246,52.178.38.151,52.178.147.240,52.178.151.212,52.178.178.16,52.178.223.23,52.183.114.173,52.229.39.152,52.230.85.180,52.236.42.239,52.236.43.202,65.52.100.7,65.52.100.9,65.52.100.11,65.52.100.91,65.52.100.92,65.52.100.93,65.52.100.94,65.52.161.64,65.55.29.238,65.55.44.51,65.55.44.54,65.55.44.108,65.55.44.109,65.55.83.120,65.55.113.11,65.55.113.12,65.55.113.13,65.55.176.90,65.55.252.43,65.55.252.63,65.55.252.70,65.55.252.71,65.55.252.72,65.55.252.93,65.55.252.190,65.55.252.202,66.119.147.131,104.41.207.73,104.43.137.66,104.43.139.21,104.43.140.223,104.43.228.53,104.43.228.202,104.43.237.169,104.45.11.195,104.45.214.112,104.46.1.211,104.46.38.64,104.210.4.77,104.210.40.87,104.210.212.243,104.214.35.244,131.253.6.87,131.253.6.103,131.253.40.37,134.170.30.202,134.170.30.203,134.170.30.204,134.170.30.221,134.170.52.151,134.170.235.16,157.56.74.250,157.56.91.77,157.56.106.184,157.56.106.185,157.56.106.189,157.56.113.217,157.56.121.89,157.56.124.87,157.56.149.250,157.56.194.72,157.56.194.73,157.56.194.74,168.61.24.141,168.61.146.25,168.61.149.17,168.61.172.71,168.62.187.13,168.63.100.61,168.63.108.233,191.236.155.80,191.237.218.239,191.239.50.18,191.239.50.77,191.239.52.100,191.239.54.52,207.68.166.254

*** HOSTS ***


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