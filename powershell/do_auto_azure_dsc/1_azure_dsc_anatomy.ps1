# 1 Anatomy
Configuration MyDscConfiguration {              ##1 The configuration block is the outermost script block. It starts with the Configuration keyword, and you provide a name.
    Node "localhost" {                          ##2 The node block determines the names of .mof files that are generated when you compile the configuration
    # Node @('WEBSERVER1', 'WEBSERVER2', 'WEBSERVER3')
        WindowsFeature MyFeatureInstance {      ##3 One or more resource blocks can specify the resources to configure.
            Ensure = 'Present'
            Name = 'Web-Server'
        }
    }
}
MyDscConfiguration -OutputPath C:\temp\         ##4 This call invokes the MyDscConfiguration block. It's like running a function. When you run a configuration block, it's compiled into a Managed Object Format (MOF) document.

# 2 Configuration data in a DSC script
# In a configuration data block, you can provide data that the configuration process might need. You apply this data to named nodes, or you apply it globally across all nodes.

$datablock =
@{
    AllNodes = # If you want to set a property to the same value in each node, in the AllNodes array, specify NodeName = "*".
    @(
        @{
            NodeName = "WEBSERVER1"
            SiteName = "WEBSERVER1-Site"
        },
        @{
            NodeName = "WEBSERVER2"
            SiteName = "WEBSERVER2-Site"
        },
        @{
            NodeName = "WEBSERVER3"
            SiteName = "WEBSERVER3-Site"
        }
    );
}