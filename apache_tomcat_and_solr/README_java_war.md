# Create a Log Generating java

That's a useful adjustment for a continuous, but regulated, logging load. Instead of stopping at a fixed limit like 1 million, the code will now run indefinitely until you manually stop the process (e.g., by pressing Ctrl+C in the Command Prompt).

Here is the updated Java code that implements a continuous 50-log burst followed by a 1-second pause pattern.

♾️ Continuous Burst-and-Pause Log Generator


The while loop will now run forever (while (true)) until the program is terminated.

```java
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;

public class LogFileGenerator {
    // *** CHANGE THIS PATH *** to match your actual target log file
    private static final String LOG_PATH = "C:\\Program Files\\Apache Software Foundation\\Tomcat 10.1\\logs\\tomcat10-stdout.YYYY-MM-DD.log";
    
    // Number of logs to write in one burst before pausing
    private static final int BURST_SIZE = 50;
    
    // Pause time in milliseconds after each burst (1 second = 1000 ms)
    private static final long PAUSE_TIME_MS = 1000; 

    public static void main(String[] args) {
        long totalLogsGenerated = 0;
        long startTime = System.currentTimeMillis();

        try (FileWriter fileWriter = new FileWriter(LOG_PATH, true); // 'true' appends to the file
             PrintWriter printWriter = new PrintWriter(fileWriter)) {

            System.out.println("Starting continuous log generation to: " + LOG_PATH);
            System.out.printf("Pattern: %d lines burst, then %dms pause. Run until manually stopped (Ctrl+C).%n", 
                              BURST_SIZE, PAUSE_TIME_MS);
            
            // Outer loop runs indefinitely
            while (true) {
                
                // Inner loop generates the burst of 50 logs
                for (int i = 1; i <= BURST_SIZE; i++) {
                    totalLogsGenerated++;

                    String logEntry = String.format("DUMMY_LOG_ENTRY: COUNT=%d, TIMESTAMP=%d, LEVEL=INFO, MESSAGE=Continuous Burst I/O Test Line.", 
                                                     totalLogsGenerated, System.currentTimeMillis());
                    
                    printWriter.println(logEntry);
                }
                
                // Immediately flush the output buffer to ensure the logs are written to disk
                printWriter.flush();
                
                // Log a progress update
                if (totalLogsGenerated % 5000 == 0) { // Update every 5,000 logs
                    System.out.println("Generated " + totalLogsGenerated + " logs. Pausing...");
                }
                
                // --- 1 SECOND PAUSE ---
                try {
                    Thread.sleep(PAUSE_TIME_MS);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                    System.err.println("Log generation was interrupted. Exiting loop.");
                    break; 
                }
            }

        } catch (IOException e) {
            System.err.println("Error writing to log file. Check the path and file permissions!");
            e.printStackTrace();
        } finally {
             // Report final status
            long endTime = System.currentTimeMillis();
            System.out.printf("Log generation finished. Total logs: %d. Total running time: %.2f minutes.%n", 
                               totalLogsGenerated, (endTime - startTime) / 60000.0);
        }
    }
}
```

How to Use and Stop the Generator
Update and Compile: Update the LOG_PATH, save the file, and compile it as before:

```cmd

javac LogFileGenerator.java

```
Run: Execute the program:

```java

java LogFileGenerator

```
Monitor: The program will start logging 50 lines every second. Use your performance monitoring tools to observe the disk activity.

Stop: To end the test, go back to the Command Prompt window where the Java program is running and press Ctrl + C. The finally block will execute, providing the final log count and runtime.

Running:

![log genrator java](https://github.com/spawnmarvel/quickguides/blob/main/apache_tomcat_and_solr/images/log_generator_java.png)


# The Simplest Way: Log4j2 Command Line

If your primary goal is to generate dummy Log4j2 logs that are captured by Tomcat's service redirection without writing any Java code, you can use Log4j2's built-in command-line tool to run your desired logging pattern.

This approach is much simpler as it requires no compilation, no Servlets, and no WAR file deployment.

This method uses the Log4j2 JARs directly to run a dummy logging process that continuously writes to System.out.

You need the two core Log4j2 JAR files. You must download these two files:

* log4j-api-2.x.x.jar

* log4j-core-2.x.x.jar

Place them in a simple directory, like C:\LogTest\.
