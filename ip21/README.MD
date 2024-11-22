# IP21

## Invoke Aspen Infoplus.21 quick start

```ps1
C:\Program Files\AspenTech\InfoPlus.21\db21\code

# press aspenip21quickstart.chm

```

## Definition editor

IP21 must be running and search for Definition editor (as admin?)

You must always copy a definiton and edit description to 256, name should be 256 for default records:
* Save the description for al records in a file
* You must also always check what is the IP_PLANT_AREA in the definition and the definition details

```sql
-- after upgrade this is set back to default for default records, not for custom, i.e ip_analogdef, but we check it anyway
 
SET APPEND 'F:\UPGRADE\check_7_definition_variables_log.txt';
 
write 'Info; Def;Value;Onum; Date for check;'||getdbtime;
 
for(select name nn ,"DETAIL_DISPLAY_REC" disp from "DefinitionDef" where name like '%ana%' or name like '%dis%')do
	write 'Definition; '||nn||';'||disp;
end
for(select "#_of_selections" sel, name nn from select64def where name like '%plant%area%')do
	write 'select64def;'||nn||';'||sel;
end

```
* ip_analogdef
* ip_discretedef
* ip_anadbldef
* ip_textdef if used.
* snap 1 
* cp definiton editor, duplicate and to 256, make usable
* snap2
* stop ip21

## Redefine and redefinewizard

```ps1
# as admin
C:\Program Files\AspenTech\InfoPlus.21\db21\code
redefinewizard.exe
```
* snap 2
* move from old to new
* new snap3
* start ip21 with snap3 edit db clock cmd
* rename old definition
* rename new to correct definition

Now update description and definition details



## How to move (or upgrade) an InfoPlus.21 database from one machine to another?

https://esupport.aspentech.com/S_Article?id=000062839


## How to change the location of a repository currently in use?

https://esupport.aspentech.com/S_Article?id=000017599

Executable that edits the file paths in the historian config.dat file - h21chgpaths.exe

https://esupport.aspentech.com/S_Article?id=000017720

## How to change in Aspen Calc the Aspen InfoPlus.21 server name when server has been moved or renamed?

How to change in Aspen Calc the Aspen InfoPlus.21 server name when server has been moved or renamed?


## How do I change the computer name or nodename of the Aspen InfoPlus.21 server?

https://esupport.aspentech.com/S_Article?id=000017668