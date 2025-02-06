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


## How to use aspenONE Update Agent to Download and Install Patches

* Run aspenONE Update Agent.exe as Administrator. Select Local Updates Only to install the patches you copied to the user machine.
* Only applicable updates will be detected by the Update Agent. If no updates were found, either the machine already has the version or a newer version of the update installed, or the product to be updated is not installed on the machine.


https://esupport.aspentech.com/S_Article?id=000064601

## How to move (or upgrade) an InfoPlus.21 database from one machine to another?

https://esupport.aspentech.com/S_Article?id=000062839

## IP21 typical upgrade error with snapshot

example:

Detailed Message File: C:\ProgramData\AspenTech\InfoPlus.21\db21\group200\UPGRADE.OUT


UPGRADE.OUT

```log

[...]

Unable to write '??????????????'
	to the filed 'TAG-NAME-1 2 IP_TREND_VALUE'
** Invalid key time stamp**

Unable to write '??????????????'
	to the filed 'TAG-NAME-2 2 IP_TREND_VALUE'
** Invalid key time stamp**


```

Backup file and edit the DoNotModify.inp

Add all the problem tags on format:

```log

*OEEDef
*OEE_EquipDef
*OEE_ReasonsDef
*TAG-NAME-1
*TAG-NAME-2

```
to the file

c:\Program Files\AspenTech\InfoPlus.21\db21\etc\DoNotModify.INP

Run the normal typical upgrade snap

The tags will be gone, so you would have to add them again, this time the tags was not in use for 10 years.



UPGRADE.OUT_SUMMARY

```log
Message Summary File: C:\ProgramData\AspenTech\InfoPlus.21\db21\group200\UPGRADE.OUT_SUMMARY

184 record(s) from the  file exist in the target database

TOTAL WORDS will remain 40000000
TOTAL RECORDS will increase to 58260
 108 warning(s) issued
Changed a total of 0 record id(s).

Finished moving records and data.


Target database saved to C:\ProgramData\AspenTech\InfoPlus.21\db21\group200\new.SNP, blocks=156250, word count=40000000

```

UPGRADE.OUT

```LOG

Detailed Message File: C:\ProgramData\AspenTech\InfoPlus.21\db21\group200\UPGRADE.OUT

184 record(s) from the  file exist in the target database

Examining c:\Program Files\AspenTech\InfoPlus.21\db21\etc\DoNotModify.INP
208 record(s) from the c:\Program Files\AspenTech\InfoPlus.21\db21\etc\DoNotModify.INP file exist in the source database


Record(s) which should NOT be CREATED:
  'TAG-NAME-1' 
  'TAG-NAME-2' 

[...]

Moving records and data from source database to target database...

Moving record ACLs from source database to target database...

Finished moving records and data.


Target database saved to C:\ProgramData\AspenTech\InfoPlus.21\db21\group200\new.SNP, blocks=156250, word count=40000000

```

## How to change the location of a repository currently in use?

https://esupport.aspentech.com/S_Article?id=000017599

Executable that edits the file paths in the historian config.dat file - h21chgpaths.exe

https://esupport.aspentech.com/S_Article?id=000017720

## How to change in Aspen Calc the Aspen InfoPlus.21 server name when server has been moved or renamed?

How to change in Aspen Calc the Aspen InfoPlus.21 server name when server has been moved or renamed?

## How to collect logging information for Aspen SQLplus applications and TSK_SQL_SERVER

https://esupport.aspentech.com/S_Article?id=000065645

## How to Use the Infoplus-21 Lock Metrics

Infoplus.21 (IP.21) users may encounter database performance issues due to excessive locking. To identify and address these issues, IP.21 provides a utility called Lock Metrics that can be used to monitor database locks.

https://esupport.aspentech.com/S_Article?id=000102341


## Can the Aspen InfoPlus.21 Task Service be stopped and restarted while Aspen InfoPlus.21 is running?

Yes, 

https://esupport.aspentech.com/S_Article?id=000077921

