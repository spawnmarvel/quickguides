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

### Hello world and calling methd


![Hello world](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/hello_world.jpg)

### OPCItemLoader.g — reads a list of OPC DA tags from a CSV/TEXT file and configures DataHub points for them.

To use this script, follow these steps:

Tags.txt

```txt
tag-osho-01;
tag-osho-02;
tag-osho-03;

or (only tested with above)

tag-osho-01;tag-osho-011
tag-osho-02;tag-osho-022
tag-osho-03;tag-osho-033


```

How to
```txt
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

```

https://cogentdatahub.com/docs/index.html#re-dhs-opcitemloaderg.html

![Tags added](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/tags_added.jpg)


### TimedUpdate.g

TimedUpdate.g

TimedUpdate.g — periodically updates the timestamp on a set of DataHub points without changing their values.


https://cogentdatahub.com/docs/index.html#re-dhs-timedupdate.html



### TimedUpdate_quality_and_value.g

TimedUpdate.g is modified with

```txt


/* This is the callback that runs when the timer fires */
method TimedUpdate.doUpdate ()
{
	local	current;
	with point in .points do
	{
		current = datahub_read(point);
		if (current[0])
		{
			// preserve the current value and quality,
		        // but let the time change to the current
		        // system clock time by not specifying 
			// the time argument.  The "1" for the "force"
		        // argument indicates that the DataHub 
		        // instance should emit a change even if 
		        // the settings would normally cause this 
		        // change to be ignored.
				datahub_write(point, current[0].value, 1,
				      current[0].quality);
		}
	}
}


// to

/* This is the callback that runs when the timer fires */
method TimedUpdate.doUpdate ()
{
	local	current;
	local	val;
	
	with point in .points do
	{
		current = datahub_read(point);
		if (current[0])
		{
			val = random();
			// updates the current value and quality,
		        // and let the time change to the current
		        // system clock time by not specifying 
			// the time argument.  The "1" for the "force"
		        // argument indicates that the DataHub 
		        // instance should emit a change even if 
		        // the settings would normally cause this 
		        // change to be ignored.
		        
		        //https://cogentdatahub.com/docs/index.html#re-dhs-datahubwrite.html
		        
		        //datahub_write (pointname, value [, force, quality, timestamp])
				datahub_write(point, val, 1, OPC_QUALITY_GOOD);
		}
	}
}



```

datahub_write

https://cogentdatahub.com/docs/index.html#re-dhs-datahubwrite.html

random

https://cogentdatahub.com/docs/index.html#re-random.html

added_time_value_and_quality


![added time, value and quality](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/added_time_value_and_quality.png)



### TimedUpdate_quality_and_value_OPCItemLoaderList.g


The script uses the same txt file:

Tags.txt

```txt
tag-osho-01;
tag-osho-02;
tag-osho-03;

or (only tested with above)

tag-osho-01;tag-osho-011
tag-osho-02;tag-osho-022
tag-osho-03;tag-osho-033


```

And updates the tags from OPCItemLoader.g — reads a list of OPC DA tags from a CSV/TEXT file and configures DataHub points for them.

It uses a random value and 1 sec interval

![Tag simulation](https://github.com/spawnmarvel/quickguides/blob/main/cogent-gamma/images/tag_simulation.jpg)




