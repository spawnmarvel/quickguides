
# Cogent install


## Upgrading to a new version

Minor

* The new version will automatically pick up any existing licenses and configuration.

Major

* Install the new DataHub archive over your existing software.
* The installer will automatically detect your existing license and configuration.

https://cogentdatahub.com/library/documentation/

## Video Remote Config and DataHub as a Windows Service


* datahub-configuration-videos

https://cogentdatahub.com/library/videos/#datahub-configuration-videos

* Video Remote Config and DataHub as a Windows Service

https://www.youtube.com/watch?v=SsHfEQHk640&list=PL94JESkkGcmJpyxzHd5emYMyv3jpcFC2R

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

## Enable Remote config V11

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

## Security update on tunnels

Start updated 26.11.2025 NB this comes after remote config is configured and Cogent is installed as a service


You should set this and change it.

* If you need to create tunnels, then test with that user (admin) on the remote Cogent Master, this user has full rights

* If you need to create a new user on slave Cogent, you must set security equal to image below

![security](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/security.png)

* Now change organization to internal and edit the mirror

![security2](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/security2.png)

There should be no permission denied in the event log now and the tunnels from master should be available on the slave.

For tunnel you do not need OPC DA node, they are auto created at slave.

https://help.softwaretoolbox.com/faq/4138



## Go to cogent-gamma for installing scripts

For a quick run of set up simulator tags

C:\CogentBase\Scripts

* tags.txt
* OPCItemLoader.g, load the tags.txt to OPC node and domain

```txt
connection_name = "OPC123";
// Change this to the connection name of the connection to edit
file_name = "C:\\CogentBase\\Scripts\\tags.txt";
```

* TimedUpdate_quality_and_value_OPCItemLoaderList_with_log_array_0_to_60.g

```txt
updateSecs = 1;
file_name = "C:\\CogentBase\\scripts\\tags.txt";
log_file_name = "C:\\CogentBase\\scripts\\write_log.txt";

[...]
 if (point == "default:tag-osho-01")


[...]
// Move to the next number in the array, reset to 0 if we hit 60
    .current_idx++;
    if (.current_idx >= 60)
        .current_idx = 0;
```

* write.log, it logs all values for tag tag-osho-01 so we have the history in a txt file, it does not log for other tags

Result, add as many tags as you like in tags.txt, and edit updateSecs, all tags goes from 0 to 60 before start at 0 again.

This is so you can easy measure if you loose some values and reciever end.


![tag simulator](https://github.com/spawnmarvel/quickguides/blob/main/cogent-install-and-remote-config/images/tag_simu.png)

## Read the full partion with python

* Edit the policy to also have listen, not only send.

run script
```py
python .\read_all.py
Connecting directly to Partition 0 from the START of the window...
[2026-05-18T18:07:36.317979+00:00] Part: 0 | Tag: tag1 | Value: 42.95 | Quality: Good
[2026-05-18T18:07:36.318225+00:00] Part: 0 | Tag: tag2 | Value: 11.14 | Quality: Good
[2026-05-18T18:07:36.318334+00:00] Part: 0 | Tag: tag3 | Value: 1.71 | Quality: Good
[2026-05-18T18:07:41.353198+00:00] Part: 0 | Tag: tag1 | Value: 40.51 | Quality: Good
[2026-05-18T18:07:41.353494+00:00] Part: 0 | Tag: tag2 | Value: 17.64 | Quality: Good
[2026-05-18T18:07:41.353605+00:00] Part: 0 | Tag: tag3 | Value: 0.09 | Quality: Good
[2026-05-18T18:07:46.404679+00:00] Part: 0 | Tag: tag1 | Value: 48.31 | Quality: Good
[2026-05-18T18:07:46.404773+00:00] Part: 0 | Tag: tag2 | Value: 12.18 | Quality: Good
[2026-05-18T18:07:46.404802+00:00] Part: 0 | Tag: tag3 | Value: 2.13 | Quality: Good
[2026-05-18T18:07:51.437593+00:00] Part: 0 | Tag: tag1 | Value: 44.65 | Quality: Good
[2026-05-18T18:07:51.437865+00:00] Part: 0 | Tag: tag2 | Value: 17.63 | Quality: Good
[2026-05-18T18:07:51.437996+00:00] Part: 0 | Tag: tag3 | Value: 4.77 | Quality: Good
[2026-05-18T18:07:56.467679+00:00] Part: 0 | Tag: tag1 | Value: 44.21 | Quality: Good
[2026-05-18T18:07:56.467774+00:00] Part: 0 | Tag: tag2 | Value: 11.73 | Quality: Good
[2026-05-18T18:07:56.467804+00:00] Part: 0 | Tag: tag3 | Value: 0.81 | Quality: Good
[2026-05-18T18:08:01.499738+00:00] Part: 0 | Tag: tag1 | Value: 46.03 | Quality: Good
[2026-05-18T18:08:01.499999+00:00] Part: 0 | Tag: tag2 | Value: 18.97 | Quality: Good
[2026-05-18T18:08:01.500110+00:00] Part: 0 | Tag: tag3 | Value: 1.19 | Quality: Good
[2026-05-18T18:08:06.536081+00:00] Part: 0 | Tag: tag1 | Value: 48.78 | Quality: Good
[2026-05-18T18:08:06.536336+00:00] Part: 0 | Tag: tag2 | Value: 18.91 | Quality: Good
[2026-05-18T18:08:06.536447+00:00] Part: 0 | Tag: tag3 | Value: 3.32 | Quality: Good
```