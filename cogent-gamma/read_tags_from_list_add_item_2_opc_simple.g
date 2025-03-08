 

require ("Application");
require ("WindowsSupport");
require ("OPCSupport");

class OPCItemLoader Application
{
    connection_name = "OPC00012";
    // Change this to the connection name of the connection to edit
    file_name = "C:\\CogentBase\\2024\\scripts\\tags.txt"; // Change this to your file path
    // Change this to the full path and file name containing  
    
    opc_connection;
}


method OPCItemLoader.ReadCSVFile (filename)
{
    local fptr = open (filename, "r", nil);
    local line;
    local i = 0;
    if (fptr)
    {
        while ((line = read_line(fptr)) != _eof_)
        {
           princ(line);
           princ("\n");
           .AddOPCItem(line, line);
           i++;
        }
        princ("Total tags " , i, "\n");
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
    .opc_connection.addItem(pointname, itemname, OPC_NODE_LEAF);
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
{
	princ(date(),"  ---- Starting OPCItemloader ----\n");
    .LoadFromCSV(.connection_name, .file_name);
    princ(date()," ---- Finished OPCItemloader ----\n");
}

/* Any code to be run when the program gets shut down. */
method OPCItemLoader.destructor ()
{
}

ApplicationSingleton (OPCItemLoader);