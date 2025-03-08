/* This script reads a set of OPC DA item names and point names from 
 * a CSV file and updates the Manually Selected Items configuration 
 * for an OPC DA connection.  The CSV file format can be one of:
 *     OPC_ITEM_ID
 * or
 *     OPC_ITEM_ID, OPC_DATAHUB_POINT_NAME
 *
 * If the OPC_DATAHUB_POINT_NAME is absent (the line contains only an
 * OPC DA item ID), then the script will create a DataHub point with 
 * the same name as the OPC item ID.  The OPC item ID is the item ID 
 * defined by the OPC DA server.
 *
 * To use this script, follow these steps:
 * 
 * 1) Create the OPC connection that you want to add items to.
 *    Select "Manually Select Items" only in the "Item Selection"
 *    section.  You do not need to configure any items.  Press
 *    OK to save the OPC configuration, the press Apply on the
 *    DataHub properties dialog.
 * 2) Open this script in the editor and change the parameters in the
 *    OPCItemLoader class definition.  These are documented below.
 * 3) Close the OPC DataHub Properties window.
 * 4) Run this script by pressing the run button in the toolbar of
 *    the editor (the right-facing blue arrow).
 * 5) Open the OPC DataHub properties dialog, open the OPC
 *    configuration for your server and verify that the items were
 *    added.
 *
 * If the script has problems, you should see error messages in the
 * "Script Log" window.
 *
 * You must close the DataHub Properties window before running
 * this script or the changes made by this script may be lost.
 *
 * You do not need to run this script each time a DataHub instance is
 * started.  The configuration produced by this script will be saved
 * in the DataHub configuration file permanently.
 *
 * Editable fields:
 *   connection_name = the name of the OPC connection to be adjusted.
 *       This is the name entered into the box marked "Connection
 *       Name:" in the "Define OPC Server" dialog of the DataHub
 *       Properties dialog.
 *   file_name = the file name containing the OPC DA item names and 
 *      point names.  The file name should contain the full path to 
 *      the file, either as a literal string or as a function like 
 *      this:
 *         file_name = "c:/path/to/file/my_file.csv";
 *         file_name = string(_config_path_, "/scripts/my_file.csv");
 *      If you use the \ character for a path separator, 
 *      you must use two of them, like this:
 *         file_name = "c:\\path\\to\\file\\my_file.csv";
 *      The file can contain either one or two strings per line 
 *      separated by commas.  If only a single string appears, it is 
 *      taken to be the OPC server item name.  The point name is 
 *      computed from the item name.  If two strings appear then the 
 *      first string is the OPC item and the second string is the 
 *      DataHub point name.  The point name will automatically be 
 *      broken into components on a "." and a tree hierarchy will be 
 *      created as if each component but the last is a tree branch.
 *   trim_spaces = t if you want the item and point names to be
 *       trimmed of all leading and trailing white space and tabs,
 *       otherwise nil.
 *   path_separator = nil if you do not want to split point names
 *       to produce a tree hierarchy, otherwise a string containing
 *       separator characters.  Normally this will be a "." character.
 */

require ("Application");
require ("WindowsSupport");
require ("OPCSupport");

class OPCItemLoader Application
{
    connection_name = "OPC000";
    // Change this to the connection name of the connection to edit
    file_name = "C:\\CogentBase\\2024\\scripts\\tags.txt";
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
    opc_connection;
}

method OPCItemLoader.Trim (str)
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

method OPCItemLoader.ReadCSVFile (filename)
{
    local		fptr = open (filename, "r", nil);
    local		line, i;
    local ii = 0;
    if (fptr)
    {
        while ((line = read_line(fptr)) != _eof_)
        {
            if (.file_is_8bit_ansi)
                line = strcvt(line);
                
            if (line != "")
            {
                line = list_to_array(string_split(line, ",",
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
                princ(line);
				princ("\n");
				ii++;
                if (length(line) == 1)
                    .AddOPCItem(line[0], line[0]);
                else if (length(line) > 1)
                    .AddOPCItem(line[0], line[1]);
            }
        }
         princ("Total tags " , ii, " added \n");
        close (fptr);
    }
    else
    {
        local s = strerror(errno());
        princ (class_name(self), ": Could not open file: ",
	       filename, ": ", s, "\n");
    }
}

method OPCItemLoader.AddOPCItem(itemname, pointname)
{
    .opc_connection.addItem(pointname, itemname, OPC_NODE_LEAF,
			    .path_separator);
}

method OPCItemLoader.LoadFromCSV(opc_conn_name, filename)
{
    local opc = new OPCConnection();
    opc.setServer(opc_conn_name);
    .opc_connection = opc;
    .ReadCSVFile(filename);
    opc.applyConfig();  
}

/* Write the 'main line' of the program here. */
method OPCItemLoader.constructor ()
{	princ(date(),"  ---- Starting OPCItemloader ----\n");
    .LoadFromCSV(.connection_name, .file_name);
    princ(date()," ---- Finished OPCItemloader ----\n");
}

/* Any code to be run when the program gets shut down. */
method OPCItemLoader.destructor ()
{
}

ApplicationSingleton (OPCItemLoader);