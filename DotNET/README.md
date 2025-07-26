# DotNet VSC


### **1. Install .NET SDK**
- Download and install the [.NET SDK](https://dotnet.microsoft.com/download) for your operating system (Windows, macOS, or Linux).

![install](https://github.com/spawnmarvel/quickguides/blob/main/DotNET/images/install.jpg)

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




