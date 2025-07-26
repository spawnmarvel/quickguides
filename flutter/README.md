# Flutter


## Beginner
https://flutter.dev/learn

## Intermediate
https://flutter.dev/learn


## Advanced
https://flutter.dev/learn


## Install

Web

https://docs.flutter.dev/get-started/install/windows

1. Download the following installation bundle to get the latest stable release of the Flutter SDK.
2. Consider creating a directory at %USERPROFILE% (C:\Users\{username}) or %LOCALAPPDATA% (C:\Users\{username}\AppData\Local).
3. C:\Users\users\dev\flutter
4. Move the content from the extracted zip from C:\Users\jekl\dev\flutter_windows_3.32.8-stable to C:\Users\jekl\dev\flutter
5. Set ENV
6. In the User variables for (username) section, look for the Path entry, Double-click in an empty row, Type %USERPROFILE%\dev\flutter\bin
7. Test flutter in powershell

```ps1
flutter doctor
Building flutter tool...
Running pub upgrade...
Resolving dependencies... (1.4s)
Downloading packages... (10.9s)
Got dependencies.
Doctor summary (to see all details, run flutter doctor -v):


```

## Flutter 101

Enable Flutter Web

```ps1

# Fix any issues it lists.
flutter doctor

flutter channel stable
flutter upgrade
flutter config --enable-web
```

```ps1
# Create the folder flutterTest
# cd to it
C:\Users\user\flutterTest>

flutter create web_app

Creating project web_app...
Resolving dependencies in `web_app`... (1.0s)
Downloading packages...
Got dependencies in `web_app`.
Wrote 130 files.

All done!
You can find general documentation for Flutter at: https://docs.flutter.dev/
Detailed API documentation is available at: https://api.flutter.dev/
If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

In order to run your application, type:

  $ cd web_app
  $ flutter run

Your application code is in web_app\lib\main.dart.

```

Go to app

```ps1
cd web_app

flutter run
Connected devices:
Windows (desktop) • windows • windows-x64    • Microsoft Windows [Version 10.0.19045.6093]
Chrome (web)      • chrome  • web-javascript • Google Chrome 114.0.5735.199
Edge (web)        • edge    • web-javascript • Microsoft Edge 138.0.3351.95
[1]: Windows (windows)
[2]: Chrome (chrome)
[3]: Edge (edge)
Please choose one (or "q" to quit):

# q for quit

flutter run -d edge
```

Done, it open automatically

![101](https://github.com/spawnmarvel/quickguides/blob/main/flutter/images/101.jpg)


## Start developing Web on Windows apps with Flutter

### Write your first Flutter app

https://docs.flutter.dev/get-started/codelab

### Learn the fundamentals

https://docs.flutter.dev/get-started/fundamentals

## AI

flutter, make a simple web app that takes the device locations and shows where you are with google maps



