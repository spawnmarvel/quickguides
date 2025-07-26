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




