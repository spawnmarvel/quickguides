/* All user scripts should derive from the base "Application"
   class */

require ("Application");
require ("WindowsSupport");
require ("OPCSupport");
/* Get the Gamma library functions and methods for ODBC and/or
 * Windows programming.  Uncomment either or both. */

//require ("WindowsSupport");
//require ("ODBCSupport");

/* Applications share the execution thread and the global name
 * space, so we create a class that contains all of the functions
 * and variables for the application.  This does two things:
 *   1) creates a private name space for the application, and
 *   2) allows you to re-load the application to create either
 *      a new unique instance or multiple instances without
 *      damaging an existing running instance.
 */
class MyApp Application
{
	connection_name = "OPC000";
	opc_connection;
}

/* Use methods to create functions outside the 'main line'. */
method MyApp.sampleMethod ()
{
	princ("samplemethod \n");
	local  i=0;
	while (i < 5)
	{
		princ(i);
		princ("\n");
		i++;
	}
}

method MyApp.addOPCItem (itemname, pointname)
{
	princ("add opc item \n");
	.opc_connection.addItem(pointname, itemname, OPC_NODE_LEAF,
			    .path_separator);
}

/* Use methods to create functions outside the 'main line'. */
method MyApp.loadfileStartMain ()
{
	local opc = new OPCConnection();
	opc.setServer(.connection_name);
	.opc_connection = opc;
	princ("loadfile start main \n");
	
	filename = "C:\\CogentBase\\2024\\scripts\\tags.txt"; // Change this to your file path
    // princ(filename); // correct
    
    // https://cogentdatahub.com/docs/index.html#re-read.html
    fp = open(filename, "r");  // Open the file for reading
    if (fp == nil)             // Check if the file was opened successfully
    {
        princ("Error: Could not open file.\n ");
		princ(filename);
        return;
    }
    else
    {
    	princ("Info: Could open file: ", filename, "\n");
		
    }
   
	expr = read(fp);       // Read the file
    princ(expr, "\n");
    
    
    local  i=0;
    local line;
    while ((line = read_line(fp)) !=_eof_)
	{
		// all tags can be printed
        //princ(line, "\n");
        
        // do stuff, such add add to .AddOPCItem(line)
        // https://cogentdatahub.com/docs/index.html#re-dhs-opcitemloaderg.html
        //.addOPCItem.(line, line);
    	i++;
	}
	princ("Tags from file: ", i, "\n");
    
	close(fp);                 // Close the file when done
    princ("Finished reading file.\n");
    // ok to here, reads the first tag
}

/* Write the 'main line' of the program here. */
method MyApp.constructor ()
{
	princ(date(),"  -------------------Starting OPCItemloader -------------------------------\n");
	princ("**** \n");
    princ("Read tags from list start.\n");
    princ("version 1.12\n");
    
    princ("Apply my config \n");
    // call method
    .sampleMethod();
    .loadfileStartMain();
    princ("Apply my config \n");
    .opc_connection.applyConfig();
    princ("Reload opc connection \n");
    .opc_connection.reload(0);
    princ("\n");
    princ(date()," -----------------Finished OPCItemloader -------------------------------\n");
    
    
   
    
  
}

/* Any code to be run when the program gets shut down. */
method MyApp.destructor ()
{
}

/* Start the program by instantiating the class.  If your
 * constructor code does not create a persistent reference to
 * the instance (self), then it will be destroyed by the
 * garbage collector soon after creation.  If you do not want
 * this to happen, assign the instance to a global variable, or
 * create a static data member in your class to which you assign
 * 'self' during the construction process.  ApplicationSingleton()
 * does this for you automatically. */
ApplicationSingleton (MyApp);