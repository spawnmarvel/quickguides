# Create a Log Generating Servlet

The best way to generate logs within Tomcat is by creating a simple Java Servlet or a Spring Boot endpoint that writes log messages in a continuous loop when a request is made.

Simple Servlet Example (using System.out.println)
This approach writes directly to the standard output stream, which is redirected to your file by the tomcat10w.exe configuration.

```java

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/log-generator")
public class LogGeneratorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private volatile boolean isRunning = false;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/plain");

        if (isRunning) {
            out.println("Log generation is already running.");
            return;
        }

        try {
            isRunning = true;
            out.println("Starting high-volume log generation...");
            
            // Loop for generating logs. Run this in a separate thread to not block the request.
            new Thread(() -> {
                long logCount = 0;
                while (isRunning) {
                    // **This is the critical line that generates the log line**
                    // The output is directed to your file because of 'Redirect Stdout' = auto
                    System.out.println("DUMMY_LOG_ENTRY_NUMBER_" + logCount + 
                        ": This is a dummy log message for tuning purposes. Timestamp=" + System.currentTimeMillis());
                    
                    logCount++;
                    
                    // Add a small sleep to control the volume if necessary (e.g., 1ms)
                    try {
                        Thread.sleep(1);
                    } catch (InterruptedException e) {
                        Thread.currentThread().interrupt();
                    }
                    
                    // Stop after a very large number of logs if needed
                    if (logCount > 100_000_000) {
                        isRunning = false;
                    }
                }
                System.out.println("Log generation stopped after " + logCount + " entries.");
            }).start();
            
        } catch (Exception e) {
            e.printStackTrace(System.out); // Log exceptions to the output stream as well
            isRunning = false;
        }
    }
    
    // You can implement a doPost or a separate endpoint to stop it.
    @Override
    public void destroy() {
        isRunning = false;
    }
}
```
Steps to Use the Servlet:
Package: Compile this Java code and package it as a standard WAR file (e.g., loggen.war).

Deploy: Place the WAR file into your Tomcat's webapps directory.

Trigger: Access the servlet in your browser (e.g., http://localhost:8080/loggen/log-generator).

Monitor: The logs will immediately start flowing into the file defined by the Redirect Stdout setting (e.g., tomcat10-stdout.YEAR-MONTH-DAY.log).