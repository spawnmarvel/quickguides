/*
 * This script runs a timer that periodically updates the timestamp on
 * a set of data points without changing their values.
 */

 // https://cogentdatahub.com/docs/index.html#re-dhs-timedupdate.html

require ("Application");

/*
 * Modify the list of point names here to change which points will be
 * written. Modify the update time (in seconds) to change the write
 * frequency
 */

class TimedUpdate Application
{
	points = [ "default:tag-osho-01", "default:tag-osho-02","default:tag-osho-03" ];
	updateSecs = 1;
}

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

/* Write the 'main line' of the program here.
   This is where we start the timer. */
method TimedUpdate.constructor ()
{
	princ(date(),"  ---- Starting TimedUpdate ----\n");
	// The .TimerEvery function will start counting when the
        // script starts running, so it will not be synchronized with
        // a particular time of day.
	.TimerEvery (.updateSecs, `(@self).doUpdate());
	
	// If you want to synchronize the update with the time of day,
	// say exactly on each half-hour, you would use the .TimerAt
	// function.  The arguments are .TimerAt(day, month, year,
	// hour, minute, second, callback_function)
	// Specify nil to mean "any".  Specify a list to give
	// multiple values. For example, this will perform the update
	// at (0 and 30 minutes) and 0 seconds past every hour:
	// .TimerAt (nil, nil, nil, nil, list(0, 30), 0,
	//           `(@self).doUpdate());
	princ(date(),"  ---- Ended TimedUpdate ----\n");
}

/* Any code to be run when the program gets shut down. */
method TimedUpdate.destructor ()
{
}

/* Start the program by instantiating the class. */
ApplicationSingleton (TimedUpdate);