/* Version 4.4 */
require ("Application");

class TimedUpdate Application
{
    points = [];
    updateSecs = 1;
    file_name = "C:\\CogentBase\\scripts\\tags.txt";
    log_file_name = "C:\\CogentBase\\scripts\\write_log.txt";

    // Array to store values 1 to 60 and a tracker for the current index
    val_array = array();
    current_idx = 0;

    trim_spaces = t;
    path_separator = ";";
    file_is_8bit_ansi = t;
}

method TimedUpdate.Trim (str)
{
    local i=0, j, len;
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
    local current, val, ts, log_ptr;
    
    // Pick the value from the array based on the current step
    val = .val_array[.current_idx];
    
    // Open the log file in append mode
    log_ptr = open(.log_file_name, "a", nil);
    
    with point in .points do
    {
        current = datahub_read(point);
        if (current[0])
        {
            ts = date();
            
            // Perform the DataHub write for ALL points in the list
            datahub_write(point, val, 1, OPC_QUALITY_GOOD);
            
            // Only log if the point matches the specific tag
            if (point == "default:tag-osho-01")
            {
                // Log to the Script Log window
                princ(ts, " - [LOGGED] ", point, " | Value: ", val, "\n");
                
                if (log_ptr)
                {
                    // Using standard write function as requested
                    write(log_ptr, ts, " - Point: ", point, " | Value: ", val, " | Quality: GOOD\n");
                }
            }
        }
    }
    
    if (log_ptr)
        close(log_ptr);

    // Move to the next number in the array, reset to 0 if we hit 60
    .current_idx++;
    if (.current_idx >= 60)
        .current_idx = 0;
}

method TimedUpdate.readCSVFileAddPoints (filename)
{
    local fptr = open (filename, "r", nil);
    local line, i, counter_points = 0, ii = 0, point_builder = "";

    if (fptr)
    {
        while ((line = read_line(fptr)) != _eof_)
        {
            if (.file_is_8bit_ansi)
                line = strcvt(line);
                
            if (line != "")
            {
                line = list_to_array(string_split(line, ";", 0, nil, nil, nil, "\\", nil));
                if (.trim_spaces)
                {
                    for (i=0; i<length(line); i++)
                        line[i] = .Trim(line[i]);
                }
                if (length(line) == 1) {
                    ii++;
                    point_builder = string("default:", line[0]);
                    .points[counter_points] = point_builder;
                    point_builder = "";
                    counter_points++;
                }
            }
        }
        princ("Total tags loaded: " , ii, "\n");
        close (fptr);
    }
    else
    {
        local s = strerror(errno());
        princ (class_name(self), ": Could not open file: ", filename, ": ", s, "\n");
    }
}

/* Constructor: Runs once when the script starts */
method TimedUpdate.constructor ()
{
    princ(date(),"  ---- Starting TimedUpdate (Sequence 1-60) ----\n");
    
    // Fill the array with values 1 through 60
    local k;
    for (k = 0; k < 60; k++)
    {
        .val_array[k] = k + 1;
    }
    
    .readCSVFileAddPoints(.file_name);
    
    // Start the timer
    .TimerEvery (.updateSecs, `(@self).doUpdate());
    
    princ(date(),"  ---- Initialization Complete ----\n");
}

method TimedUpdate.destructor ()
{
}

/* Start the program */
ApplicationSingleton (TimedUpdate);