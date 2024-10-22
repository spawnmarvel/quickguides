# Create the amount of folders based in the int -le99 or -le25 -le
# And stores them on the format arc0 + -lenXX
# Example arc01, arc02.......

$fso = New-Object -ComObject scripting.filesystemobject

 for($i = 1;$i -le25;$i++) { $fso.CreateFolder("E:\His_1\arcFolder\\arc0" + $i)}


$fso = New-Object -ComObject scripting.filesystemobject

 for($i = 1;$i -le99;$i++) { $fso.CreateFolder("C:\temp\folder\amx\arc0" + $i)}


$fso = New-Object -ComObject scripting.filesystemobject

 for($i = 1;$i -le11;$i++) { $fso.CreateFolder("E:\His_1\TSK_DATA_STORAGE_" + $i)}
