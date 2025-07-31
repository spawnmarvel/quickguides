# DotNet VSC


## VSC quick commands

```bash
cd yourfolder

# new consoler app
dotnet new console -n myapp

# enter it
cd myapp

# (optional) Just build/compile the code
dotnet build

# # Build (if needed) and run the app
dotnet run

# if done,  then publish it
# Build for deployment, output in publish folder
dotnet publish -c Release -r win-x64

# Add the Official NuGet Source
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

# Confirm the Source was added
dotnet nuget list source

# add packet example

dotnet add package Microsoft.Extensions.Hosting.WindowsServices --version 8.0.1

```

## **Summary Table**

| Command         | Purpose                                        | Output Folder                             |
|-----------------|------------------------------------------------|-------------------------------------------|
| dotnet build    | Compile code for testing/debugging              | bin/Debug/net8.0/ (or bin/Release/net8.0/)|
| dotnet run      | Build (if needed) and run for dev/testing       | Same as build                             |
| dotnet publish  | Build and prep for deployment, all dependencies | bin/Release/net8.0/win-x64/publish/       |

---


## Top-level statements - programs without Main methods

You don't have to explicitly include a Main method in a console application project. Instead, you can use the top-level statements feature to minimize the code you have to write.

Top-level statements allow you to write executable code directly at the root of a file, eliminating the need for wrapping your code in a class or method. This means you can create programs without the ceremony of a Program class and a Main method. In this case, the compiler generates a Program class with an entry point method for the application. The name of the generated method isn't Main, it's an implementation detail that your code can't reference directly.

Here's a Program.cs file that is a complete C# program:

```csharp
Console.WriteLine("Hello World!");
```

Top-level statements let you write simple programs for small utilities such as Azure Functions and GitHub Actions. They also make it simpler for new C# programmers to get started learning and writing code.

For the single file containing top-level statements using directives must come first in that file, as in this example:

Using:

```csharp
using System.Text;

StringBuilder builder = new();
builder.AppendLine("The following arguments are passed:");

foreach (var arg in args)
{
    builder.AppendLine($"Argument={arg}");
}

Console.WriteLine(builder.ToString());

return 0;


```
Only one top-level file. 

An application must have only one entry point. A project can have only one file with top-level statements.

https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/program-structure/top-level-statements

## VSC tips intellisens

Do not open the full folder with all projects, but go open sub folder for a particular project so you get intellisens.

![Intellisens](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/intelli.jpg)

## Install 


### **1. Install .NET SDK**
- Download and install the [.NET SDK](https://dotnet.microsoft.com/download) for your operating system (Windows, macOS, or Linux).

Use a lts, less issues with features and more. Example .NET 8.0

![lts](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/lts.png)

### **2. Install Visual Studio Code**
- Download and install [Visual Studio Code](https://code.visualstudio.com/).

![vsc_csharp](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/vsc_csharp.jpg)


### **3. Install the C# Extension**
- Open Visual Studio Code.
- Go to the Extensions view (Ctrl+Shift+X).
- Search for and install the **“C#”** extension (published by Microsoft).

### **4. Create and Run a C# Project**
- Open a terminal in VS Code.
- Create a new project:  

```bash
cd yourfolder

dotnet new console -n myapp

```

![myapp](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/myapp.jpg)


Start the app

```bash
dotnet run

```

![myapp run](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/run.jpg)

### **5. To create an **executable** from your C# project in Visual Studio Code, you need to **publish** your application using the .NET CLI. Here’s how you can do it**

1. Navigate to your project’s root directory (where your .csproj file is located).


For a **self-contained executable** (runs on machines without .NET installed):

```bash
dotnet publish -c Release -r win-x64 --self-contained true

```

-c Release builds in Release mode (optimized).- -r win-x64 targets Windows 64-bit. For Linux, use linux-x64; for macOS, use osx-x64.- --self-contained true creates an executable with all dependencies included.
For a **framework-dependent executable** (requires .NET installed on the target machine):

```bash
dotnet publish -c Release -r win-x64

```

After publishing, go to:

```bash

./bin/Release/netX.Y/your-runtime/

# For example, if you targeted win-x64, check:
./bin/Release/net6.0/win-x64/publish/

# You’ll find:
# - MyApp.exe (on Windows)- MyApp (on Linux/macOS)
```


![myapp run release](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/release.jpg)

Run it

![myapp run release exe](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/app_exe.jpg)

## For app changes

Just do the same steps again.

```csharp
// See https://aka.ms/new-console-template for more information

using System;

class Program
{
    static void Main(string[] args)
    {
        // ... your code ...

        Console.WriteLine("Hello OOP, nice to see you again");
        // ... your code ...

        Console.WriteLine("Press Enter to exit...");
        Console.ReadLine();
    }
}

```

Test it, Start the app

```bash
dotnet run

```
Create a new release

```bash
dotnet publish -c Release -r win-x64

```

Navigate to folder and run it myapp.exe

![myapp run release new](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/new_release.jpg)


## Debug and release

Debug Configuration

- Purpose: Used during development and testing.
- Optimization: Minimal or no code optimization, making debugging easier.
- Debug Information: Includes full debugging information (symbols, variable names, line numbers).
- Assertions: Debug assertions and extra diagnostic code are included.
- Performance: Runs slower, but allows you to step through code and inspect variables.
- File Size: Typically larger because of debug symbols and less optimization.

Release Configuration

- Purpose: Used for deploying the final product to users.
- Optimization: Compiler applies optimizations to improve performance and reduce file size.
- Debug Information: Minimal or no debug information; harder to debug.
- Assertions: Debug assertions are removed.
- Performance: Runs faster and is more efficient.
- File Size: Smaller and optimized for distribution.

## Different apps

```bash

cd yourfolder

dotnet new console -n myapp

# see all aviliable apps
dotnet new --list
These templates matched your input: 

Template Name                                 Short Name                  Language    Tags
--------------------------------------------  --------------------------  ----------  ----------------------------------
API Controller                                apicontroller               [C#]        Web/ASP.NET
ASP.NET Core Empty                            web                         [C#],F#     Web/Empty
ASP.NET Core gRPC Service                     grpc                        [C#]        Web/gRPC/API/Service
ASP.NET Core Web API                          webapi                      [C#],F#     Web/Web API/API/Service
ASP.NET Core Web API (native AOT)             webapiaot                   [C#]        Web/Web API/API/Service
ASP.NET Core Web App (Model-View-Controller)  mvc                         [C#],F#     Web/MVC
ASP.NET Core Web App (Razor Pages)            webapp,razor                [C#]        Web/MVC/Razor Pages
Blazor Web App                                blazor                      [C#]        Web/Blazor/WebAssembly
Blazor WebAssembly Standalone App             blazorwasm                  [C#]        Web/Blazor/WebAssembly/PWA
Class                                         class                       [C#],VB     Common
Class Library                                 classlib                    [C#],F#,VB  Common/Library
Console App                                   console                     [C#],F#,VB  Common/Console
dotnet gitignore file                         gitignore,.gitignore                    Config
Dotnet local tool manifest file               tool-manifest                           Config
EditorConfig file                             editorconfig,.editorconfig              Config
Enum                                          enum                        [C#],VB     Common
global.json file                              globaljson,global.json                  Config
Interface                                     interface                   [C#],VB     Common
MSBuild Directory.Build.props file            buildprops                              MSBuild/props
MSBuild Directory.Build.targets file          buildtargets                            MSBuild/props
MSBuild Directory.Packages.props file         packagesprops                           MSBuild/packages/props/CPM
MSTest Playwright Test Project                mstest-playwright           [C#]        Test/MSTest/Playwright/Desktop/Web
MSTest Test Class                             mstest-class                [C#],F#,VB  Test/MSTest
MSTest Test Project                           mstest                      [C#],F#,VB  Test/MSTest/Desktop/Web
MVC Controller                                mvccontroller               [C#]        Web/ASP.NET
MVC ViewImports                               viewimports                 [C#]        Web/ASP.NET
MVC ViewStart                                 viewstart                   [C#]        Web/ASP.NET
NuGet Config                                  nugetconfig,nuget.config                Config
NUnit 3 Test Item                             nunit-test                  [C#],F#,VB  Test/NUnit
NUnit 3 Test Project                          nunit                       [C#],F#,VB  Test/NUnit/Desktop/Web
NUnit Playwright Test Project                 nunit-playwright            [C#]        Test/NUnit/Playwright/Desktop/Web
Protocol Buffer File                          proto                                   Web/gRPC
Razor Class Library                           razorclasslib               [C#]        Web/Razor/Library
Razor Component                               razorcomponent              [C#]        Web/ASP.NET
Razor Page                                    page                        [C#]        Web/ASP.NET
Razor View                                    view                        [C#]        Web/ASP.NET
Record                                        record                      [C#]        Common
Solution File                                 sln,solution                            Solution
Struct                                        struct,structure            [C#],VB     Common
Web Config                                    webconfig                               Config
Windows Forms App                             winforms                    [C#],VB     Common/WinForms
Windows Forms Class Library                   winformslib                 [C#],VB     Common/WinForms
Windows Forms Control Library                 winformscontrollib          [C#],VB     Common/WinForms
Worker Service                                worker                      [C#],F#     Common/Worker/Web
WPF Application                               wpf                         [C#],VB     Common/WPF
WPF Class Library                             wpflib                      [C#],VB     Common/WPF
WPF Custom Control Library                    wpfcustomcontrollib         [C#],VB     Common/WPF
WPF User Control Library                      wpfusercontrollib           [C#],VB     Common/WPF
xUnit Test Project                            xunit                       [C#],F#,VB  Test/xUnit/Desktop/Web

```

## To create a Windows Service in .NET (Core or 5+), you typically use the **Worker Service** template.

To create a Windows Service in .NET (Core or 5+), you typically use the **Worker Service** template. There is no template called "windowsservice" directly; instead, you use the worker template and then configure it to run as a Windows Service.

### Windows service template

**Step 1: Create the Worker Service Project**

```bash
dotnet new worker -n MyService
cd MyService
```
NOTE! If you get an error on this cmd:

```bash
dotnet new worker -n MyService gives: The template "Worker Service" was created successfully.

Determining projects to restore...
C:\giti2025\quickguides\DotNET\MyService\MyService.csproj : error NU1100: Unable to resolve 'Microsoft.Extensions.Hosting (>= 8.0.1)' for 'net8.0'.

# Add the Official NuGet Source
dotnet nuget add source https://api.nuget.org/v3/index.json -n nuget.org

# Confirm the Source Was Added
dotnet nuget list source

# Navigate to your project directory (where your .csproj file is), then run:
dotnet restore

# If restore succeeds, proceed with:
dotnet build
dotnet run
```
And it is running.

![service 101](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/service_101.jpg)

**Step 2: Add the Windows Service NuGet Package**

```bash
# You might have already done this
dotnet add package Microsoft.Extensions.Hosting.WindowsServices

# Still error
# In your .csproj, set:
# <TargetFramework>net8.0</TargetFramework>
# Remove any explicit reference to Microsoft.Extensions.Hosting version 9.x or higher.3. Install the **8.x** version of WindowsServices:
# then run
dotnet add package Microsoft.Extensions.Hosting.WindowsServices --version 8.0.1
```


**Step 3: Update Program.cs for Windows Service**

Open Program.cs and update it to include .UseWindowsService():

```csharp
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

IHost host = Host.CreateDefaultBuilder(args)
    .UseWindowsService()
    .ConfigureServices(services =>
    {
        services.AddHostedService<Worker>();
    })
    .Build();

host.Run();

```
**Step 4: Update Worker.cs to Log to a File**

Replace the contents of Worker.cs with the following code:

```csharp
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.IO;
using System.Threading;
using System.Threading.Tasks;

public class Worker : BackgroundService
{
    private readonly string _filePath = @"C:\MyService\log.txt"; // Make sure this directory exists or create it in code

    protected override async Task ExecuteAsync(CancellationToken stoppingToken)
    {
        Directory.CreateDirectory(Path.GetDirectoryName(_filePath));
        while (!stoppingToken.IsCancellationRequested)
        {
            string message = $"Hello World at {DateTime.Now}";
            await File.AppendAllTextAsync(_filePath, message + Environment.NewLine);
            await Task.Delay(TimeSpan.FromSeconds(1.5), stoppingToken);
        }
    }
}
```

**Step 4.1: Run it**
```bash
dotnet run
Building...
C:\giti2025\quickguides\DotNET\MyService\Worker.cs(16,35): warning CS8604: Possible null reference argument for parameter 'path' in 'DirectoryInfo Directory.CreateDirectory(string path)'. [C:\giti2025\quickguides\Dot
NET\MyService\MyService.csproj]
info: Microsoft.Hosting.Lifetime[0]
      Application started. Press Ctrl+C to shut down.
info: Microsoft.Hosting.Lifetime[0]
      Hosting environment: Development
info: Microsoft.Hosting.Lifetime[0]
      Content root path: C:\giti2025\quickguides\DotNET\MyServic
```
And we have the file

![service log](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/service_log.jpg)

**Step 5: Build and Publish the Service**


```bash
dotnet publish -c Release -r win-x64 --self-contained true
```

Find the output in:  
bin\Release\netX.Y\win-x64\publish\  (e.g. bin\Release\net8.0\win-x64\publish\)


**Step 6: Install the Service**

Open an Admin Command Prompt

```cmd
sc create MyService binPath= "C:\Path\To\Your\Publish\MyService.exe"

sc start MyService

```
The service will now write “Hello World” to C:\MyService\log.txt every 20 seconds

![service running](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/service_running.jpg)

Stop and delete the service

```cmd
sc stop MyService
sc delete MyService
```

***Make a packet of the service***

1. Copy the folder in C:\giti2025\quickguides\DotNET\MyService\bin\Release\net8.0\win-x64\publish
2. Rename the folder to MyService2 and paste it where you want to have it


Open an Admin Command Prompt

```cmd
sc create MyService2 binPath= "C:\temp\MyService2\MyService.exe"

sc start MyService2

```
The service will now write “Hello World” to C:\MyService\log.txt every 20 seconds

![service running2](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/service_running_2.jpg)

Stop and delete the service

```cmd
sc stop MyService2
sc delete MyService2
```

## Logging in C# and .NET with NLog

1. Install NLog: Add the NLog NuGet package to your project.

```bash
mkdir AmqpPub
cd .\AmqpPub\

# You can add the NLog.Extensions.Logging package to your .NET project in **two main ways**:
dotnet add package NLog.Extensions.Logging
# This will:
# - Download the latest version of the package.
# - Add the appropriate <PackageReference> to your .csproj file automatically.

```
2. Configure NLog: Create an NLog.config file or configure it programmatically to define targets (e.g., file) and rules.


```ini
   <?xml version="1.0" encoding="utf-8" ?>
<!-- XSD manual extracted from package NLog.Schema: https://www.nuget.org/packages/NLog.Schema-->
<nlog xmlns="http://www.nlog-project.org/schemas/NLog.xsd" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="http://www.nlog-project.org/schemas/NLog.xsd NLog.xsd"
      autoReload="true"
      internalLogFile="console-example-internal.log"
      internalLogLevel="Info" >

  <!-- the targets to write to -->
  <targets>
    <target xsi:type="File" name="logfile"
            fileName="${basedir}/log/console-example.log"
            layout="${longdate} ; ${level} ; ${message} ${all-event-properties} ${exception:format=tostring}" />

    <target xsi:type="Console" name="logconsole"
            layout="${longdate} ; ${level} ; ${message} ${all-event-properties} ${exception:format=tostring}" />
  </targets>

  <!-- rules to map from logger name to target -->
  <rules>
    <logger name="*" minlevel="Trace" writeTo="logfile,logconsole" />
  </rules>
</nlog>
```

3. Edit the .csproj add a new

```ini
 <ItemGroup>
     <None Update="nlog.config" CopyToOutputDirectory="Always" />
 </ItemGroup>
```
4. Log in your code using classes

```csharp
    using NLog;

    public class Application
    {
        private static readonly Logger Logger = LogManager.GetCurrentClassLogger();

        public void Run()
        {
            Logger.Info("Application started.");
            // ...
            Logger.Error("An error occurred!");
            Logger.Debug("Debug message.");
        }
    }
```

4. Log in your code using Top-level statements - programs without Main methods

```csharp
using NLog;

// Create a logger for this file (the top-level program)
var logger = LogManager.GetCurrentClassLogger();

logger.Info("Application started.");

// ...
logger.Error("An error occurred!");
logger.Debug("Debug message.");
```

https://github.com/NLog/NLog/wiki/Getting-started-with-.NET-Core-2---Console-application

https://nlog-project.org/



## Tutorials for getting started with .NET

Write your first code using C# (Get started with C#, Part 1) = Perform basic operations on numbers in C#

https://learn.microsoft.com/en-us/training/paths/get-started-c-sharp-part-1/?source=learn

Create and run simple C# console applications (Get started with C#, Part 2) = 

Add logic to C# console applications (Get started with C#, Part 3) = 

Work with variable data in C# console applications (Get started with C#, Part 4) = 

Create methods in C# console applications (Get started with C#, Part 5) = 

Debug C# console applications (Get started with C#, Part 6) = 

https://learn.microsoft.com/en-us/training/paths/get-started-c-sharp-part-2/?source=recommendations

## RabbitMQ tutorial's

https://www.rabbitmq.com/tutorials/tutorial-one-dotnet