
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

![uncheck](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/remotemika.png)

* With that new user still selected, in the Roles section check the Show Available button to display all the available roles. Scroll down to the RemoteConfig role and check that box.

![remote_user](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/remote_user.png)

* Click apply

* In the DataHub Properties window, select Remote Config

* Check the boxes of the features you want to be configurable. Checking a box in the Local column allows connections only from a DataHub instance running on the same machine, 
* whereas boxes in the Remote column allow connections from a Remote Config instance running on a remote machine. If you uncheck Local and check Remote, then a user on the local machine will not be able to configure that feature.

* Local is already selected, check top local box

![local](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/local.png)

* Now search for remote config and launch it

![login](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/login.png)


https://cogentdatahub.com/library/documentation/


https://follow-e-lo.com/2025/09/22/cogent-install-v-11-remote-config/

## Remote Config and DataHub as a Windows Service


* datahub-configuration-videos

https://cogentdatahub.com/library/videos/#datahub-configuration-videos

* Remote Config and DataHub as a Windows Service

https://www.youtube.com/watch?v=SsHfEQHk640&list=PL94JESkkGcmJpyxzHd5emYMyv3jpcFC2R


## Install as service

* Exit Cogent and make sure all Cogent processes are gone.

* Open the service Manager and set path to the same as the .exe file

```ps1
C:\CogentBase

```

![service](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/service.png)

* Start service from the Manager and check service

![running](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/running.png)

* Start remote config and verify login again.

## Start updated 26.11.2025 NB this comes after remote config is configured and Cogent is installed as a service


You should set this and change it.

* If you need to create tunnels, then test with that user (admin) on the remote Cogent Master, this user has full rights

* If you need to create a new user on slave Cogent, you must set security equal to image below

![security](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/security.png)

* Now change organization to internal and edit the mirror

![security2](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/security2.png)

There should be no permission denied in the event log now and the tunnels from master should be available on the slave.

For tunnel you do not need OPC DA node, they are auto created at slave.

https://help.softwaretoolbox.com/faq/4138

