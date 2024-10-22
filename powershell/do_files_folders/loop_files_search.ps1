#PS loop over files get string (mystring)

dir C:\temp\wells -Include *.xml -Recurse |Select-String -Pattern mystring
