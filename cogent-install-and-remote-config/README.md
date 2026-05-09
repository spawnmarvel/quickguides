
# Cogent install


## Install

* Download and run
* CogentDataHubFull_x64-11.0.5-260331-Windows.exe
* C:\Program Files\Cogent
* Select all
* Start Cogent Datahub som it creates the files

Since v11, change the admin password

* admin, limaecho456. 
* Stop Cogent Datahub and kill it from task manager.

Lets move the files and configure Cogent.

* Move the content in C:\Users\user\AppData\Roaming\Cogent DataHub\
* C:\CogentBase
* Make a Scripts folder also, lets keep it empty for now.
* Edit the target path for the Cogent DataHub.exe file (desktop)

```ps1
# from 
"C:\Program Files\Cogent\Cogent DataHub\CogentDataHub.exe" -P
# to new -h for home
"C:\Program Files\Cogent\Cogent DataHub\CogentDataHub.exe" -H C:\CogentBase
```
* Start Cogent, Cogent is running interactive.


Before connecting to a DataHub instance remotely to configure it, you must first run it as a normal program, not a service, and prepare it in two ways

## Install and remote config V11

* Set the Organization to Local, and in the Users tab, under Users, click the Add button and select Add BuiltIn User

* remotemika, linux100

* In the Default Roles section, uncheck the RequireTotpAuthentication button because this is an automatic, non-interactive connection.


https://cogentdatahub.com/library/documentation/


https://follow-e-lo.com/2025/09/22/cogent-install-v-11-remote-config/

## Remote Config and DataHub as a Windows Service


* datahub-configuration-videos

https://cogentdatahub.com/library/videos/#datahub-configuration-videos

* Remote Config and DataHub as a Windows Service

https://www.youtube.com/watch?v=SsHfEQHk640&list=PL94JESkkGcmJpyxzHd5emYMyv3jpcFC2R
