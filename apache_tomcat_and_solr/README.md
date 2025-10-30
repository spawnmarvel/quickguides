# Apache Tomcat and Solr

https://tomcat.apache.org/


## Apache tomcat and solr memory, hm.

There are two places, one for apache tomcat and one for solr.

You've hit a common point of confusion when running Solr inside Tomcat! 

The core issue is that Tomcat and Solr do not run in separate Java Virtual Machines (JVMs) in this deployment scenario; 
* they both run within the single Tomcat JVM.Therefore, you only need to set the heap memory ($\text{-Xms}$ and $\text{-Xmx}$) once, on the Tomcat process.

The Single JVM Principle 🧠
When you deploy Solr as a .war file (e.g., solr.war) into a standard Tomcat installation:

Tomcat Starts the JVM: Tomcat is launched as a single process running the JVM.

Solr is an Application: Solr is deployed as a web application (a Servlet) inside the already running Tomcat application server.

Shared Memory: Both the Tomcat management threads and the Solr application threads draw memory from the same single Java heap defined by the Tomcat configuration.

There is no separate "Solr process" or "Solr heap" to configure.

Solr/Tomcat Heap Sizing ($\text{-Xms}$ and $\text{-Xmx}$)

Solr benefits greatly from having a large, stable heap size for caching and search operations.

1. General Recommended Starting Point

For a production Solr instance running on a server with dedicated memory:

* Initial Heap Size -Xms: (2 GB)
* Maximum Heap Size -Xmx: (4 GB)


Solr's memory limit is the JVM's heap memory limit. There's no separate configuration.

https://serverfault.com/questions/418342/limiting-solr-not-java-to-use-a-certain-amount-of-memory

02393364: You just need to modify the parameter in xxxxxONESolrWindowsService.exe.config file under Solr only.

## Memory settings

If Tomcat is installed as a service:

Open Tomcat Configuration: Run tomcat9w.exe as admin (or the corresponding version, e.g., tomcat8w.exe) located in the <CATALINA_HOME>/bin directory.

Navigate to Java Tab: In the Apache Tomcat Properties dialog, go to the "Java" tab.

Modify JVM Arguments: In the "Java Options" text area, add or modify the JVM arguments like -Xms (initial heap size) and -Xmx (maximum heap size). For example:

```code
    -Xms1024m
    -Xmx2048m
```

![heap memory](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/heap.png)

Apply and Restart: Click "Apply," then "OK," and restart the Tomcat service.

## Tomcat Logs: Locations, Types, Configuration, and Best Practices

1. catalina.out (Primary Log File)
2. catalina.log (Tomcat Startup & Shutdown Logs)
3. manager.log (Tomcat Manager Application Logs)
4. localhost_access_log.*.txt (HTTP Access Logs)

Additional Log Files

* host-manager.log – Logs actions related to managing virtual hosts.
* gc.log – Records Java Garbage Collection events for JVM performance analysis.
* stderr.log / stdout.log – Captures system errors and console outputs.



https://last9.io/blog/tomcat-logs/


## Logging

Some issues

* https://community.bmc.com/s/article/tomcat7-stdout-log-file-has-grown-to-over-70GB  

This issue—where the **`stdout.log`** or **`catalina.out`** file grows indefinitely—is common when running **Tomcat on Windows**. This happens because, unlike other rotating logs, this file captures the raw `stdout` and `stderr` streams without a built-in rotation mechanism.

Here are the three most effective solutions, ranging from disabling the file to addressing the root cause.

-----

## 1\. Disable Redirection (Turn it Off) 🚫

If you are using properly rotating logs (like `catalina.log` and your application's logs), you can safely disable the redirection of `stdout` and `stderr`, which is what creates the large, non-rotating file.

This is the fastest fix and applies if **Tomcat is running as a Windows Service** (the default/common setup).

1.  **Open the Tomcat Service Manager:**
      * Navigate to your Tomcat `bin` directory (e.g., `C:\Program Files\Apache Software Foundation\Tomcat X.Y\bin`).
      * Run the service configuration utility (e.g., **`tomcat9w.exe`** or **`tomcat8w.exe`**).
2.  **Navigate to the Logging Tab:**
      * In the Tomcat Service Manager window, click on the **"Logging"** tab.
3.  **Clear the Redirection Fields:**
      * Find the fields for **"Redirect Stdout"** and **"Redirect Stderr"**.
      * **Remove the value in these fields.** Leave them completely empty.
4.  **Apply and Restart:**
      * Click **`Apply`** and **`OK`**.
      * **Restart the Tomcat Windows Service** for the changes to take effect.

Tomcat will now stop logging to that large `stdout.log` file.

-----

## 2\. Reduce the Logging Level (Recommended Root Fix) 🛠️

The primary reason this file balloons is usually because your application or a library (like Hibernate, Spring, etc.) has its log level set to **`DEBUG`** or **`INFO`** *and* is configured to print to the console (`stdout`), which then gets captured by the service wrapper.

You need to check two places: Tomcat's JULI configuration and your application's configuration.

### A. Disable JULI's ConsoleHandler

The standard Tomcat logs use the Java Util Logging (JULI) framework, configured in `$CATALINA_HOME\conf\logging.properties`. Log messages handled by JULI often go to both the rotating `catalina.log` **AND** the non-rotating `stdout` (via the `ConsoleHandler`).

1.  **Edit `logging.properties`:** Open the file in a text editor.

2.  **Remove `ConsoleHandler`:** Look for the line defining the root handlers:

    ```properties
    # BEFORE
    .handlers = 1catalina.org.apache.juli.AsyncFileHandler, java.util.logging.ConsoleHandler
    ```

    Change it to remove the `java.util.logging.ConsoleHandler`:

    ```properties
    # AFTER (No ConsoleHandler)
    .handlers = 1catalina.org.apache.juli.AsyncFileHandler
    ```

### B. Adjust Application/Library Logging

If the remaining large logs are from your application, you need to find its logging configuration (e.g., **Log4j**, **Logback**, or application-specific XML/Properties files) and do one of the following:

  * **Increase the log level** (e.g., change the root logger from `DEBUG` to **`WARN`** or **`ERROR`**).
  * **Remove the `ConsoleAppender`** from your application's configuration entirely.

<!-- end list -->

3.  **Restart Tomcat.**

-----

## 3\. Implement Log Rotation (Advanced/External) ⚙️

Since the Windows service wrapper for Tomcat lacks a native rotation mechanism for `stdout`/`stderr`, implementing rotation requires an external tool or script. This is generally more complex than the other options.

  * **Scheduled Task Script:** Write a small script (e.g., PowerShell or batch) that runs via Windows Task Scheduler. This script would need to:
    1.  Stop the Tomcat service.
    2.  Delete, move, or compress the large log file.
    3.  Restart the Tomcat service.
  * **Third-party Utility:** Use a dedicated log management or rotation tool.
      * For example, you could configure **Log4j** to take over all logging and use its file size-based rotation features.
      * Less commonly, utilities like Apache's **`rotatelogs`** (often used with Apache HTTP Server) can be adapted, but this requires significant configuration and is usually considered overkill.


### Temporary files

# Solr

https://solr.apache.org/guide/solr/latest/deployment-guide/jvm-settings.html

## Memory settings

Any of the following may be occurring: Search may be slow, have long pauses, slow startup, or failures encountered when "java.lang.OutOfMemoryError: Java heap space".

This JVM-Memory percent level can be adjusted with the Maximum Heap Space setting (-Xmx) described below.

* Do not set the Maximum Heap Space too low since that will lead to a JVM-Memory percent level greater than 75% which can slow search responsiveness, or in extreme cases will cause OutOfMemoryException failures.

* Do not set the Maximum Heap Space too high even if plenty of physical memory is available, because that can result in noticeable random pauses, and can result in extended pauses when garbage collecting. Larger heap sizes will take longer for garbage collection.

* Do not set the Maximum Heap Space so high as to restrict physical memory available for the operating system resulting in excessive swapping of memory or limit OS cache or other memory resources which might impact performance.

xxx.exe.config

```code
<add key="JavaParams" value="-Xms512m -Xmx1G -Xss256k -XX:+UseG1GC -XX:+PerfDisableSharedMem -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=250 -XX:+UseLargePages -XX:+AlwaysPreTouch"/>

After update to 1.5 Gig:
<add key="JavaParams" value="-Xms512m -Xmx1536m -Xss256k -XX:+UseG1GC -XX:+PerfDisableSharedMem -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=250 -XX:+UseLargePages -XX:+AlwaysPreTouch"/>
```

The SolrWindowsService in the Windows Services should be restarted after modifying these settings.

Monitor the memory consumption.

* If it is ever up to 75%, then try increasing again as needed.

![solr memory](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/solr.png)

## Index

### Scan index once a week, use reconsile

### Delete index 