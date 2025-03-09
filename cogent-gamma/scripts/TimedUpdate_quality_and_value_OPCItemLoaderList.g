/*
 * This script runs a timer that periodically updates the timestamp on
 * a set of data points without changing their values.
 */

require ("Application");

/*
 * Modify the list of point names here to change which points will be
 * written. Modify the update time (in seconds) to change the write
 * frequency
 */

class TimedUpdate Application
{
	
	//points = [ "default:tag-osho-01", "default:tag-osho-02","default:tag-osho-03" ];
	points = [];
	updateSecs = 1;
	file_name = "C:\\CogentBase\\2024\\scripts\\tags.txt";
	
	// if  Object TimedUpdate has no member named: file_is_8bit_ansi
	// add the vars as class vars
	
	// Change this to the full path and file name containing  
    // the item and point names
    trim_spaces = t;
    // set to nil to preserve leading and trailing spaces in item
    // names
    path_separator = ";";
    // Characters used to split point names into tree components
    file_is_8bit_ansi = t;
    // Set to t if file uses 8-bit extended ANSI, nil if 7-bit ASCII
    // or UTF-8
	
	
}
method TimedUpdate.Trim (str)
{
    local	i=0, j, len;
    len = strlen(str);
    while (i < len && (str[i] == ' ' || str[i] == '\t'))
        i++;

    j = len - 1;
    while (j >= i && (str[j] == ' ' || str[j] == '\t'))
        j--;
	
    if (j>=i)
        str = substr(str, i, j-i+1);
    else
        str = "";
    str;
}

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

method TimedUpdate.readCSVFileAddPoints (filename)

{
	
	local		fptr = open (filename, "r", nil);
    local		line, i;
    local       counter_points;
    counter_points = 0; // start at 0
    local ii = 0;
    local point_builder;
    point_builder = "";
    if (fptr)
    {
        while ((line = read_line(fptr)) != _eof_)
        {
            if (.file_is_8bit_ansi)
                line = strcvt(line);
                
            if (line != "")
            {
                line = list_to_array(string_split(line, ";",
						  0, nil,
						  nil, nil,
						  "\\", nil));
                if (.trim_spaces)
                {
                    for (i=0; i<length(line); i++)
                    {
                        line[i] = .Trim(line[i]);
                    }
                }
                if (length(line) == 1) {
					//princ(line[0]); //tag-osho-03; since  line = list_to_array(string_split(line, ";", and not ","
					//princ("\n");
					ii++;
					// this works
					//.points[counter_points] = string("default:tag-osho-04");
					
					
					point_builder = string("default:", line[0]);
					
					//princ("Point builder: ", point_builder);
				
					.points[counter_points] = point_builder;
					point_builder = "";
					counter_points++;
                }
				
            }
            //princ("\n");
			//princ(length(.points));
			//princ("\n");
        }
         princ("Total tags updated (value, quality and time) " , ii, "\n");
        close (fptr);
    }
    else
    {
        local s = strerror(errno());
        princ (class_name(self), ": Could not open file: ",
	       filename, ": ", s, "\n");
    }
}

/* Write the 'main line' of the program here.
   This is where we start the timer. */
method TimedUpdate.constructor ()
{
	princ(date(),"  ---- Starting TimedUpdate quality and value ----\n");
	// start try to fill the arry
	
	.readCSVFileAddPoints(.file_name);
	// end try to fill array
	
	
	
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
	princ(date(),"  ---- Ended TimedUpdate quality and value ----\n");
}

/* Any code to be run when the program gets shut down. */
method TimedUpdate.destructor ()
{
}

/* Start the program by instantiating the class. */
ApplicationSingleton (TimedUpdate);