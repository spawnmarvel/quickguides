# Page memory

With 64 GB of RAM and an 18 GB index, your system has plenty of physical memory to cache the entire index. Your current configuration is:
* Total RAM: 64 GB
* Solr JVM Heap (-Xmx): 8 GB* 
* Available for OS Cache & OS: $64 \text{ GB} - 8 \text{ GB} = \mathbf{56 \text{ GB}}$


That's an important clarification. If the indexing process is **finished** and the index is now **static** (no ongoing updates or merges), the continued large swap file (30 GB) points to a different, but related, issue: **The Windows OS is still reserving backing store for the memory-mapped index segments.**

Here's why the swap file remains large even after the index updates are complete:

-----

## 🧐 Why Windows Holds Onto Swap Space

The issue now shifts from **transient memory spikes** during indexing to **committed virtual memory** for the static index.

### 1\. The Solr/Lucene Memory Map

When the index was built, Lucene/Solr used **Memory-Mapping** (MMap) to load large portions of the 18 GB index into the **OS file cache**.

  * This process tells the OS: "I need this data from disk, but map it directly into memory so I can access it instantly."
  * Since your index is 18 GB, Solr has told the OS to commit roughly **18 GB of virtual memory** to back those mapped files, plus the 8 GB for the JVM heap, plus OS overhead.

### 2\. Committed Memory vs. Physical RAM

Windows distinguishes between memory that is *physically* used and memory that is *committed* (promised).

  * **Committed Memory:** This is the total memory space that the operating system has *promised* to running processes (including the 8 GB JVM heap and the $\approx 18 \text{ GB}$ index map).
  * **Paging File/Swap:** The paging file serves as the **backing store** for the Committed Memory. The OS ensures that if all the committed memory had to be written to disk simultaneously, there is enough swap space to hold it.

Even if you have 64 GB of RAM, and the 18 GB index is sitting comfortably in the OS file cache, Windows memory management often keeps the paging file large because the **Total Commit Size** (Solr Commit Size + OS Commit Size) is high, and the OS wants to ensure it has enough swap to back that commitment, especially on a Windows server.

-----

## 🔍 How to Diagnose and Resolve This

Since the index is static, your focus is on releasing the committed memory if it's unnecessary, or accepting the swap size as a reflection of the system's memory guarantees.

### 1\. Monitor the Actual Usage

The crucial step is to see if Windows is **actively swapping** or just **reserving space**.

  * Use **Resource Monitor** or **Process Explorer**.
  * Check the **"Hard Faults/sec"** (page faults) for the Solr process. If this number is consistently high, the OS is actively reading data from the slow 30 GB swap file into RAM, and performance *will* be poor.
  * Look at the **"Commit Size"** vs. the **"Working Set"** for the Solr Java process.
      * **Commit Size:** Should be $\approx 8 \text{ GB}$ (the heap) + MMap overhead.
      * **Working Set:** Should be less than the Commit Size. This is the memory actually resident in physical RAM.


![page_swap_w3wp2](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/page_swap_w3wp2.png)


Supplier say Should be done for both pools. Supplier link, due to scan that can be interrupted.

* Ide Time-out (minutes) = 0 to off
* Recycling/Regular Time Interval (minutes) = 0 to off
* The rest are for logging.

But keep on saying that IIS processes can become fragmented or grow in memory after long periods without recycling, hm....


Adding a Time Interval Recycle to IIS

Keeping the Idle Time-out at $10,080$ minutes (7 days) is acceptable for keeping the application available, but you must add a scheduled or condition-based recycle to prevent the w3wp.exe memory from growing indefinitely and consuming the swap space.

## 1. Configuring Specific Time Recycling (hm, what time to use, 07:00)

If you need the recycle to happen at a guaranteed low-traffic time (e.g., 3:00 AM on Sunday), use the "Specific Times" option instead of the regular time interval.


1. Open IIS Manager on the Windows server.
2. In the Connections pane (left), click on Application Pools.
3. Right-click on the Application Pool and select Recycling....
4. In the Recycling settings window, focus on the "Specific Times" section.
5. Check the box next to "Specific Times".
6. Add the time(s):
7. Click the Add... button.
* * Enter the desired recycle time, for example, 03:00:00 (3:00 AM).
* * Note: This recycle will occur every day at 3:00 AM. If you only want it on Sunday, you must rely on an external task scheduler (like Windows Task Scheduler) to stop and start the pool, but for memory management, a daily early-morning recycle is usually recommended. If you are comfortable with a daily reset at 3:00 AM, proceed with this setting.
* * Click Next, select any necessary events to log, and click Finish.

This action ensures that even with the $10,080$ minute idle timeout, the w3wp.exe process gets a clean memory reset daily at a guaranteed low-traffic time.


![recycle time](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/recycle_time.png)


## Test this and set it 1 day after the scan, Fridays, but does it go up when optimization?

We must free w2wp.exe after the scan.


If your application pool is named "SolrAppPool", the command would be:

```ps1
Import-Module WebAdministration
Get-IISAppPool -Name "SolrAppPool"
Restart-WebAppPool -Name "SolrAppPool"


```

## 🛡️ 2. Setting the Private Memory Limit (The Safety Net)

If your application's memory usage (w3wp.exe) spikes to 48 GB for 10 minutes when the Solr index is optimized, setting a Private Memory Limit below that (e.g., 15 GB or 20 GB) will cause premature recycling and interrupt the optimization or warming process.

In this scenario, setting a low Private Memory Limit is bad because it would treat the necessary, temporary memory spike as an error, causing instability.
