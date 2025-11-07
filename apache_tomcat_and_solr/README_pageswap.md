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


![page_swap_w3wp](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/page_swap_w3wp.png)

### 2\. Adjust Windows Paging File Settings

You likely have the paging file set to be **System Managed** or have a large initial size. Given your 64 GB of RAM, the swap file doesn't need to be 30 GB.

  * **Recommendation:** Change the Windows paging file setting from *System Managed* to a **Custom Size** with a specific range, such as **16 GB minimum and 20 GB maximum**. This will free up 10 GB of disk space and reduce the OS's tendency to commit excessive virtual memory.
      * *(Note: The old rule was $1.5 \times \text{RAM}$, but with 64 GB RAM, this is unnecessary and counterproductive.)*

### 3\. Solr Tuning: Explicitly Disable MMap (If Necessary)

If the swap commitment is still excessive, you can tell Solr/Lucene *not* to use memory mapping, forcing the OS to handle the index as standard file I/O.

  * In `solrconfig.xml`, locate the `<directoryFactory>` and change the type:

<!-- end list -->

```xml
<directoryFactory name="DirectoryFactory" 
                  class="solr.StandardDirectoryFactory">
    <bool name="useCompoundFile">true</bool>
</directoryFactory>

<directoryFactory name="DirectoryFactory" 
                  class="solr.NRTCachingDirectoryFactory">
    <bool name="useCompoundFile">true</bool>
</directoryFactory>
```

  * **Warning:** Changing to a non-MMap factory like `NRTCachingDirectoryFactory` or `SimpleFSDirectory` can reduce the virtual memory commitment, but it may **slow down search performance** because Lucene loses its fastest method of accessing index files. **This should be a last resort.**

**Conclusion:** The 30 GB swap is most likely **reserved backing store** for committed memory, not active swapping. You can fix this by **reducing the Windows paging file size** to a more appropriate 16-20 GB and monitoring page faults.

Would you like steps on how to manually adjust the Windows paging file size?