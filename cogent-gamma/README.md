# Gamma docs

https://cogentdatahub.com/docs/index.html#dhs-book.html

## Gamma example script

The code for this and other example scripts can be found in the DataHub distribution archive, typically at this location:

C:\Program Files\Cogent\Cogent DataHub\scripts\

Or online

https://cogentdatahub.com/docs/index.html#re-dhs-opcitemloaderg.html


## Chapter 3. Getting Started (just error? Cogent is running for 1 h only, restart Cogent)


1. To run an existing script for the first time, you will need to first add it to the list of scripts.
2. To add a script to the list, press the Add button and choose the script from the file selector. 
    Scripts are kept in the DataHub scripts folder.
3. If you need to edit the script before running it, press the Edit button to open the selected script in the Script Editor
4. To run the script manually, press the Load Now button.
5. To see any script output or error messages, you can press the Script Log button near the bottom of the Properties window to open the Script Log.
6. To configure a script to run automatically at startup, check the checkbox next to it . The next time you start a DataHub instance, this script will load and run automatically.
7. Once a script is started, it will continue running until the DataHub instance shuts down. To stop the script without shutting down the DataHub instance, press the Script Manager button to open the Script Application Manager.


https://cogentdatahub.com/docs/index.html#dhs-gettingstarted.html#dhs-accessingscripts


![Test edit and run](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/test_edit_run.jpg)


### Remove domains


![Remove domains](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/remove_domains.jpg)

#### Hello worlda and calling methd


![Hello world](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/hello_world.jpg)

#### OPCItemLoader.g — reads a list of OPC DA tags from a CSV/TEXT file and configures DataHub points for them.

To use this script, follow these steps:
 
1. Create the OPC connection that you want to add items to.
* Select "Manually Select Items" only in the "Item Selection"
* section.  You do not need to configure any items.  Press
* OK to save the OPC configuration, the press Apply on the
* DataHub properties dialog.

2. Open this script in the editor and change the parameters in the
* OPCItemLoader class definition.  These are documented below.

3. Close the OPC DataHub Properties window.

4. Run this script by pressing the run button in the toolbar of the editor (the right-facing blue arrow).

5. Open the OPC DataHub properties dialog, open the OPC
*  configuration for your server and verify that the items were added.
 
* If the script has problems, you should see error messages in the "Script Log" window.
* You must close the DataHub Properties window before running
* this script or the changes made by this script may be lost.
 
* You do not need to run this script each time a DataHub instance is
* started.  The configuration produced by this script will be saved
* in the DataHub configuration file permanently.

https://cogentdatahub.com/docs/index.html#re-dhs-opcitemloaderg.html

![Tags added](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/tags_added.jpg)


#### Update timestamp and set random tbd

TimedUpdate.g

TimedUpdate.g — periodically updates the timestamp on a set of DataHub points without changing their values.


https://cogentdatahub.com/docs/index.html#re-dhs-timedupdate.html



#### set_random or random tbd

random

https://cogentdatahub.com/docs/index.html#re-random.html

set_random

https://cogentdatahub.com/docs/index.html#re-setrandom.html





