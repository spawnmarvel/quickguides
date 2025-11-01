# Apache Tomcat and Solr

https://tomcat.apache.org/


## Documentation Index Apache Tomcat 

https://tomcat.apache.org/tomcat-10.1-doc/index.html


## Apache tomcat and solr one JVM or two JVM?

#### Scenario A:

When you deploy Solr as a .war file (e.g., solr.war) into a Tomcat server:Single JVM: Tomcat starts a single Java process (JVM).Solr as a Servlet: Solr is loaded as a web application (a Servlet) within that single Tomcat process.Shared Heap: Both the Tomcat management components and the Solr application share the exact same memory heap. You configure the JVM memory settings ($\text{-Xms}$, $\text{-Xmx}$) only on the Tomcat process itself. There is no separate "Solr heap" to configure.

Solr benefits greatly from having a large, stable heap size for caching and search operations.

1. General Recommended Starting Point

For a production Solr instance running on a server with dedicated memory:

* Initial Heap Size -Xms: (2 GB)
* Maximum Heap Size -Xmx: (4 GB)


Solr's memory limit is the JVM's heap memory limit. There's no separate configuration.

https://serverfault.com/questions/418342/limiting-solr-not-java-to-use-a-certain-amount-of-memory

***Thats what she said***
02393364: You just need to modify the parameter in xxxxxONESolrWindowsService.exe.config file under Solr only. 

#### Scenario B:

Since you have two separate Java services running on the same machine—Tomcat and a Standalone Solr service—you must consider and tune the memory allocation for both processes.

This statement would be true if you were running:

Process 1: A Tomcat server in one JVM.

Process 2: A Standalone Solr instance (e.g., started with bin/solr start) in a second, separate JVM.

#### How to Know You Have Two Separate JVMs

Powershell List processes

```ps1

Get-CimInstance Win32_Process -Filter "Name like '%java.exe' OR Name like '%tomcat10.exe' OR Name LIKE '%solr%.exe'" | 
    Select-Object ProcessId, Name, CommandLine | 
    Format-List

```
Powershell Find the parent

```ps1
Get-CimInstance Win32_Process -Filter "Name like '%java.exe' OR Name like '%tomcat10.exe' OR Name LIKE '%solr%.exe'" | 
    Select-Object ProcessId, ParentProcessId, Name, CommandLine | 
    Format-List
```


```log
ProcessId       : 5276
ParentProcessId : 704
Name            : tomcat10.exe
CommandLine     : "C:\Program Files\Common Files\DataTech Shared\Tomcat10.1.16\bin\Tomcat10.exe" //RS//Tomcat10

ProcessId       : 8560
ParentProcessId : 704
Name            : datatechONESolrWindowsService.exe
CommandLine     : "C:\Program Files\DataTech\datatechONE\SolrService\datatechONESolrWindowsService.exe"

ProcessId       : 11824
ParentProcessId : 8560
Name            : java.exe
CommandLine     : "C:\Program Files\Eclipse Adoptium\jdk-17.0.13.11-hotspot\bin\java.exe" -server -Duser.timezone=UTC -Xms4G -Xmx8G -Xss256k -XX:+UseG1GC -XX:+PerfDisableSharedMem -XX:+P
                  arallelRefProcEnabled -XX:MaxGCPauseMillis=250 -XX:+UseLargePages -XX:+AlwaysPreTouch "-Xlog:gc*:file=\"C:\Program Files\Common Files\DataTech shared\solr-9.6.1\server
                  \logs\solr_gc.log\":time,uptime:filecount=9,filesize=20M" -Dsolr.log.dir="C:\Program Files\Common Files\DataTech shared\solr-9.6.1\server\logs" -Dlog4j.configurationFi
                  le="file:///C:\Program Files\Common Files\DataTech shared\solr-9.6.1\server\resources\log4j2.xml" -Dsolr.solr.home="C:\Program Files\Common Files\DataTech shared\solr
                  -9.6.1\server\solr" -Dsolr.install.dir="C:\Program Files\Common Files\DataTech shared\solr-9.6.1" -Dsolr.enableRemoteStreaming="true" -Dsolr.enableStreamBody="true" -D
                  solr.default.confdir="C:\Program Files\Common Files\DataTech shared\solr-9.6.1\server\solr\configsets\_default\conf" -Djetty.home="C:\Program Files\Common Files\AspenT
                  ech shared\solr-9.6.1\server" -Djava.io.tmpdir="C:\Program Files\Common Files\DataTech shared\solr-9.6.1\server\tmp" -DSTOP.PORT=7983 -DSTOP.KEY=solrrocks -Djetty.host
                  =0.0.0.0 -Djetty.port=8983 -jar "C:\Program Files\Common Files\DataTech shared\solr-9.6.1\server\start.jar" --module=http ""

```
Here's a breakdown of the process hierarchy and the key information revealed:

The ParentProcessId column clearly shows the "family tree" of your services:

* ParentProcessId 704 is almost certainly the PID for services.exe (or in some cases, svchost.exe), which is the main Service Control Manager on Windows. This process is responsible for launching all other services.
* Both tomcat10.exe and datatechONESolrWindowsService.exe are children of PID 704, confirming they are both running as independent Windows Services.
* ProcessId 8560 (datatechONESolrWindowsService.exe) is the dedicated service wrapper for Solr.
* Conclusion: The datatechONESolrWindowsService.exe wrapper is the process that launched the Java Virtual Machine (JVM) running your Solr application.
* If Tomcat is in IIS, it means Tomcat is running behind IIS, which acts as a reverse proxy or front-end web server.
* This setup explains why you didn't see a second java.exe process in your previous results.

Key Configuration Details from the Solr JVM

* Configuration Area,Command Line Parameter,Value/Setting
* Java Version,(Path),JDK 17 (jdk-17.0.13.11-hotspot)
* Initial Memory,-Xms4G,4 GB
* Maximum Memory,-Xmx8G,8 GB
* Garbage Collector,-XX:+UseG1GC,G1 Garbage Collector
* Solr Data Path,"-Dsolr.solr.home=""...""",Solr's index and configuration directory: C:\Program Files\Common Files\Datatech shared\solr-9.6.1\server\solr
* Server Port,-Djetty.port=8983,Solr is listening on TCP port 8983.
* Startup File,"-jar ""...""",Solr is started using the main JAR file: C:\Program Files\Common Files\Datatech shared\solr-9.6.1\server\start.jar


Or Using Windows Task Manager (User-Friendly)

* Open Task Manager (Ctrl + Shift + Esc, or right-click the taskbar and select Task Manager).
* Go to the Details tab.
* Look for processes named java.exe or javaw.exe (or sometimes just Java(TM) Platform SE binary in the Processes tab).
* If you see multiple instances of java.exe (or similar), each one represents a separate JVM process.

* To verify which application each JVM is running, you'll need the Command Line column:
* Right-click on any column header (like "Name" or "PID").
* Select Select columns (or similar option).
* Check the box for Command line.
* The "Command line" column will show the full command used to start each JVM, which often includes the name of the main class or the .jar file. This lets you distinguish between your applications.

## Example memory settings

Solr has one major memory requirement that often catches people out:

 * OS Disk Cache (MMap): Solr heavily uses the OS Disk Cache (memory-mapped files, or MMap) for its main index files. This memory is outside of the JVM's maximum heap (-Xmx).
 * The 50% Rule of Thumb: On a dedicated server running only Solr, the general rule is: never set the Solr Max Heap (-Xmx) higher than 50% of the physical RAM. This ensures the other 50% is free for the OS to use as disk cache for the index, which is critical for search performance.
Combined Tuning Strategy

When running both Tomcat and Solr on the same server:

 * Calculate Total JVM Requirement: Decide on the maximum required heap for your Tomcat application and for Solr.
 * Solr's Priority: Solr is usually the more memory-hungry component. Start by allocating a reasonable, but conservative, amount of heap to Solr (e.g., 1/3 to 1/2 of total RAM, max).
 * Tomcat's Share: Allocate the remaining memory to Tomcat, based on its specific application needs. Tomcat generally needs less than Solr unless you are hosting a huge application.
 * The OS Buffer: Ensure that the sum of (\text{Tomcat -Xmx} + \text{Solr -Xmx}) is significantly less than the total physical RAM (ideally leaving 2-4 GB or at least 25% free) to allow the OS and Solr's disk caching to operate effectively.

| Example: 16 GB Server | Allocation | Tuning Files |
|---|---|---|
| Total Physical RAM | 16 GB | N/A |
| Solr Max Heap | 6 GB (-Xmx6g) | solr.exe.conf or solr.in.cmd |
| Tomcat Max Heap | 4 GB (-Xmx4g) | tomcatXw.exe GUI / setenv.bat |
| Reserved for OS/Cache | 6 GB (16 GB - 10 GB) | Critical for Solr's performance |

You must monitor the server's overall CPU and memory usage after tuning to find the optimal balance for your specific workload.

***That configuration seems reasonable as a starting point for those two applications on a server with 64 GB of RAM***

Total Max Allocation Percentage of 64 GB

* Tomcat/Apache 1 GB 2 GB 2 GB \sim 3.1\%
* Solr 4 GB 8 GB 8 GB 12.5\%

Total Max JVM Heap 5 GB 10 GB 10 GB \sim 15.6\%


## Memory settings Tomcat Apache

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

After update to 4 and 8gb Gig:

<add key="JavaParams" value="-Xms4G -Xmx8G -Xss256k -XX:+UseG1GC -XX:+PerfDisableSharedMem -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=250 -XX:+UseLargePages -XX:+AlwaysPreTouch"/>
```

The SolrWindowsService in the Windows Services should be restarted after modifying these settings.

Monitor the memory consumption.

* If it is ever up to 75%, then try increasing again as needed.

![solr memory](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/solr.png)

## Index and Optimization

Whether you need to optimize your Solr index, and how often, depends heavily on your specific use case, indexing frequency, and performance requirements.
Here's a breakdown:
Do We Really Need To Optimize?
Generally, less often than you might think, and sometimes not at all.

 * Solr (Lucene) already merges segments automatically. Lucene's merge policy is designed to automatically merge small index segments into larger, more efficient ones in the background. This process is less disruptive than a full optimization.
 * Manual optimization is a heavy operation. A full Solr "optimize" (also called a "force merge") operation merges all segments into a single, large segment (by default). This is very CPU and I/O intensive and can severely impact query performance while it's running, as well as temporarily evicting data from the OS file cache.

### Scan index once a week best practice

Running the optimization 2 hours before the weekly scan is generally inefficient and potentially wasteful, depending on how your scan is executed.
The optimal time for a full index optimization is after a large batch of indexing, not before.

1. Weekly Scan / Indexing | Starts at T=0 | Run the full scan and index all new/updated documents
2. Final Commit | Ends at T=X | Issue a final hardCommit to ensure all data is persisted and searchable.
3. Optimization | T=X + 5 mins (immediately after commit) | Run the full index optimization
- Consolidates all the small segments created during the indexing process into one or a few large, efficient segments. This is when it provides the greatest benefit.

### Optimization timeout

This behavior is a very common and expected symptom of a long-running, resource-intensive operation like a full Solr index optimization.
It strongly suggests that the optimization is running for longer than your client's configured request timeout.

* First Try (Timeout) | 1. Your client (the tool/script sending the command) sends the optimize=true request to Solr.,  it takes a long time
- - The optimization process continues to run in the background on the Solr server, unaware the client disconnected. |
* Second Try (Success) | 1. You, or your automation, immediately retry the optimize=true request
- -The first attempt started the work; the second attempt merely benefited from the first attempt finishing the work in the background.

Recommended Solutions
You have two primary ways to fix this, depending on your environment:

1. The Immediate Fix (Increase Client Timeout)

The simplest solution is to change the configuration of the client that is making the optimization call.
* Action: Increase the request timeout of your client (Java application, Python script, or whatever is running the cURL/API call) to a value you know is safely longer than the optimization time (e.g., 1 \text{ hour} = 3,600,000 \text{ ms}).

2. The Best Practice Fix (Change Schedule & Index Swapping)

To solve the underlying issue of running a high-impact task and to follow the best practices discussed earlier:
 * Move Optimization: Schedule the optimization to run after the weekly scan, not before.


20 GB index takes around 15-20 min.

### Delete index 

* Uploading Data with Index Handlers

https://solr.apache.org/guide/7_5/uploading-data-with-index-handlers.html

* Solr 9.6.1

https://follow-e-lo.com/2018/11/03/apache-solr-7-5-index-handlers-with-http/


If you get a IndexWriter is Closed
* stop tomcat, solr
* remove file write.lock
* start tomcat, solr

And run the document delete all again.

![rmindex](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/rmindex.png)


## Resources

on http://localhost:8983/solr/#/ it says 

* system physical memory 45.4%, used 29.08gb, max 64 gb. 
* Then swap space 41.%, used 30.16gb, max 73 gb. 
* Then JVM memory 37%, used 2.98 gb, max 8gb.

![resources](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/resources.png)

System Physical Memory
* Healthy. There's plenty of physical RAM available.
* Swap Space, High. Using 30 GB of swap is the most notable metric. High swap usage, even with available physical RAM, can sometimes indicate memory pressure or a process (like Solr or another application) demanding memory that the kernel has moved to swap. This can slow down performance significantly.
* JVM Memory (Solr Heap), Healthy. The Solr process itself is only using a moderate portion of its allocated 8 GB heap.

Must investiagte more.

## Install Apache Tomcat on Windows (Windows Server 2022 Datacenter Azure Edition)

* Home

https://tomcat.apache.org/

* Download core
* 32-bit/64-bit Windows Service Installer (pgp, sha512)

https://tomcat.apache.org/download-10.cgi

* Temurin 17.0.17+10, Windows 64 bit (.MSI)
* OpenJDK17U-jdk_x64_windows_hotspot_17.0.17_10.msi

https://adoptium.net/temurin/releases?version=17&os=any&arch=any

![java](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/java.png)


* Tomcat Setup windows

Installing Tomcat on Windows can be done easily using the Windows installer. Its interface and functionality is similar to other wizard based installers, with only a few items of interest.

So now we have:

![tomcat apache](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/tomcat_apache.png)

Configuration:

You'll be prompted to set the HTTP Connector Port (the default is 8080; change it if another application is using this port).

You can also set a username and password for the Tomcat Administrator Login here, which is necessary for accessing the Manager App.

* admin, admin

Destination folder

* C:\Program Files\Apache Software Foundation\Tomcat 10.1

![apache installed](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/apache_installed.png)

Verification

* To confirm Tomcat is running:
* Open a web browser.
* Navigate to http://localhost:8080 (or the port you configured).
* If successful, you'll see the Apache Tomcat welcome page with the cat logo.

![success http](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/success.png)

Login to Manager App

![success manager](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/managerapp.png)

Services and control panel.

![service and remove](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/service_and_remove.png)

https://tomcat.apache.org/tomcat-10.1-doc/setup.html

# Tomcat get to know it


## Tomcat Logs: Locations, Types, Configuration, and Best Practices

1. catalina.out (Primary Log File)
2. catalina.log (Tomcat Startup & Shutdown Logs)
3. manager.log (Tomcat Manager Application Logs)
4. localhost_access_log.*.txt (HTTP Access Logs)

catalina.out (Primary Log File)

```log
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version name:   Apache Tomcat/10.1.48
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server built:          Oct 10 2025 14:33:56 UTC
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Server version number: 10.1.48.0
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Name:               Windows Server 2022
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log OS Version:            10.0
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Architecture:          amd64
01-Nov-2025 14:23:45.985 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Java Home:             C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot
01-Nov-2025 14:23:46.000 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Version:           17.0.17+10
01-Nov-2025 14:23:46.000 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log JVM Vendor:            Eclipse Adoptium
01-Nov-2025 14:23:46.000 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_BASE:         C:\Program Files\Apache Software Foundation\Tomcat 10.1
01-Nov-2025 14:23:46.000 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log CATALINA_HOME:         C:\Program Files\Apache Software Foundation\Tomcat 10.1
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.home=C:\Program Files\Apache Software Foundation\Tomcat 10.1
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Dcatalina.base=C:\Program Files\Apache Software Foundation\Tomcat 10.1
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.io.tmpdir=C:\Program Files\Apache Software Foundation\Tomcat 10.1\temp
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Djava.util.logging.config.file=C:\Program Files\Apache Software Foundation\Tomcat 10.1\conf\logging.properties
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.lang=ALL-UNNAMED
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.base/java.io=ALL-UNNAMED
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: --add-opens=java.rmi/sun.rmi.transport=ALL-UNNAMED
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: exit
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: abort
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xms128m
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.startup.VersionLoggerListener.log Command line argument: -Xmx256m
01-Nov-2025 14:23:46.098 INFO [main] org.apache.catalina.core.AprLifecycleListener.lifecycleEvent The Apache Tomcat Native library which allows using OpenSSL was not found on the java.library.path: [C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin;C:\Windows\Sun\Java\bin;C:\Windows\system32;C:\Windows;C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot\\bin;C:\Program Files\Eclipse Adoptium\jdk-17.0.17.10-hotspot\bin;C:\app\imsdal\product\21c\dbhomeXE\bin;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C:\Program Files\dotnet\;C:\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\WindowsApps;.]



```

localhost_access_log.*.txt (HTTP Access Logs)

```log
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:56 +0100] "GET / HTTP/1.1" 200 11437
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /tomcat.svg HTTP/1.1" 200 68761
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /tomcat.css HTTP/1.1" 200 5981
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /bg-upper.png HTTP/1.1" 200 3103
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /bg-nav.png HTTP/1.1" 200 1401
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /bg-button.png HTTP/1.1" 200 713
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /bg-middle.png HTTP/1.1" 200 1918
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /asf-logo-wide.svg HTTP/1.1" 200 7147
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:25:58 +0100] "GET /favicon.ico HTTP/1.1" 200 21630
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:29:43 +0100] "GET /host-manager/html HTTP/1.1" 404 773
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:29:47 +0100] "GET /manager/html HTTP/1.1" 401 2640
0:0:0:0:0:0:0:1 - admin [01/Nov/2025:14:29:55 +0100] "GET /manager/html HTTP/1.1" 200 13659
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:29:55 +0100] "GET /manager/images/tomcat.svg HTTP/1.1" 200 68761
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:29:55 +0100] "GET /manager/images/asf-logo.svg HTTP/1.1" 200 7147
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:29:55 +0100] "GET /manager/css/manager.css HTTP/1.1" 200 2946
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:29:55 +0100] "GET /manager/images/favicon.ico HTTP/1.1" 200 21630
0:0:0:0:0:0:0:1 - - [01/Nov/2025:14:30:03 +0100] "GET / HTTP/1.1" 200 11437


```
![access_log](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/access_log.png)

Additional Log Files

* host-manager.log – Logs actions related to managing virtual hosts.
* gc.log – Records Java Garbage Collection events for JVM performance analysis.
* stderr.log / stdout.log – Captures system errors and console outputs.


## stderr.log / stdout.log – Captures system errors and console outputs.

These files capture anything written to System.out and System.err (like System.out.println statements from your Java code), which is the primary role of the catalina.out file on Linux systems.

![stdout](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/stdout.png)



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


### Powershell temporary files moved to F:\LogsTomcatTemp delete


ps_delete_uploaded_files.ps1

### Simple Log remover after self roll over

ps_delete_tomcat10-stdout.ps1
