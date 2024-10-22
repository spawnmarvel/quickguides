Configuration MyFirstDsc {
    Node "localhost" {
      WindowsFeature MyFeatureInstance {
        Ensure = 'Present'
        Name = 'Web-Server'
      }
      WindowsFeature Telnet-Client
        {
            Ensure = "Present"
            Name = "Telnet-Client"     
        }
    }
  }