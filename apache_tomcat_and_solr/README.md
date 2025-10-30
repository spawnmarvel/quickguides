# Apache Tomcat and Solr


https://tomcat.apache.org/

## Logging

Some issues

* https://community.bmc.com/s/article/tomcat7-stdout-log-file-has-grown-to-over-70GB  

That's a very common issue with Tomcat on Windows. The file, often named stdout.log or catalina.out (depending on how Tomcat is installed/run), grows indefinitely because, unlike the other rotating logs, it captures the raw \text{stdout} and \text{stderr} streams without any built-in rotation mechanism.
Here are the three best options for you, ranging from fixing the root cause to just turning it off.

### Option 1: Disable Redirection (Turn it Off)

If you have other, properly rotating log files (like catalina.log and the application's logs), you can safely disable the \text{stdout} and \text{stderr} redirection, which is what is creating the large file.

This method applies if Tomcat is running as a Windows Service (which is the default or common way to run it).
 * Open the Tomcat Service Manager:
   * Go to your Tomcat bin directory (e.g., C:\Program Files\Apache Software Foundation\Tomcat X.Y\bin).
   * Run the configuration utility for your service. The file is usually named tomcat9w.exe (or tomcat8w.exe, etc., matching your version).
 * Navigate to the Logging Tab:
   * In the Tomcat Service Manager window, click on the "Logging" tab.
 * Clear the Redirection Fields:
   * Find the fields for "Redirect Stdout" and "Redirect Stderr".
   * Remove the value in these fields (they might be set to auto or a file path like logs\stdout.log). Leave them completely empty.
 * Apply and Restart:
   * Click "Apply" and "OK".
   * Restart the Tomcat Windows Service for the changes to take effect.

Tomcat will now stop logging to that large \text{stdout.log} file.

### Option 2: Reduce the Logging Level (Recommended Fix)

The \text{stdout} file often grows huge because your application or a library (like Hibernate, Spring, etc.) is set to a DEBUG or INFO logging level and is also printing to the console (\text{stdout}), which gets captured.
The standard Tomcat logs use the Java Util Logging (JULI) framework, configured in:
$CATALINA_HOME\conf\logging.properties
 * Edit logging.properties: Open the file in a text editor.
 * Remove Console Handler from JULI: The log messages handled by JULI often go to both the rotating catalina.log AND the non-rotating \text{stdout} (via the ConsoleHandler). To prevent duplication and massive \text{stdout} growth, look for this line (or similar):
   .handlers = 1catalina.org.apache.juli.AsyncFileHandler, java.util.logging.ConsoleHandler

   Change it to remove the ConsoleHandler:
   .handlers = 1catalina.org.apache.juli.AsyncFileHandler

 * Check Application/Library Logging: If the logs are from your application, you need to find its logging configuration (e.g., Log4j, Logback, or the application's logging.properties) and either:
   * Increase the log level (e.g., from DEBUG to WARN or ERROR).
   * Remove the ConsoleAppender from your application's configuration.
 * Restart Tomcat.

### Option 3: Implement Log Rotation (Advanced)

Since Tomcat on Windows lacks a native rotation mechanism for \text{stdout}/\text{stderr}, you would have to use an external tool like:
 * A Scheduled Task: Write a small script (PowerShell/batch) that runs daily, stops the service, deletes/compresses the log, and restarts the service.
 * Third-party Log Rotation Utility: Use a tool like log4j (which has file size-based rotation) to take over all logging, or use a tool like Apache's rotatelogs (which is often used with Apache HTTP Server, but can be configured for Tomcat on Windows as well). This is generally complex and overkill compared to simply disabling the \text{stdout} redirection.


### Temporary files



# Solr

##