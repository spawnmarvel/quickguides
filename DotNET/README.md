# DotNet VSC


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
dotnet new worker -n HelloWorldService
cd HelloWorldService
```


**Step 2: Add the Windows Service NuGet Package**

```bash
dotnet add package Microsoft.Extensions.Hosting.WindowsServices
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
    private readonly string _filePath = @"C:\HelloWorldService\log.txt"; // Make sure this directory exists or create it in code

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
**Step 5: Build and Publish the Service**


```bash
dotnet publish -c Release -r win-x64 --self-contained true
```

Find the output in:  
bin\Release\netX.Y\win-x64\publish\  (e.g. bin\Release\net8.0\win-x64\publish\)


**Step 6: Install the Service**

Open an Admin Command Prompt

```cmd
sc create HelloWorldService binPath= "C:\Path\To\Your\Publish\HelloWorldService.exe"

sc start HelloWorldService

```
The service will now write “Hello World” to C:\HelloWorldService\log.txt every 1.5 seconds

Stop and delete the service

```cmd
sc stop HelloWorldService
sc delete HelloWorldService
```







