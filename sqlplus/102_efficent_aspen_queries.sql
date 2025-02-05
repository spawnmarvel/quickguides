-- ·         Minimize the number of Aspen InfoPlus.21 database accesses
-- Each database transaction, whether read or write, locks the entire Aspen InfoPlus.21 database for the duration of the transaction.  This means that while a query accesses the database, other queries (and indeed all other Aspen InfoPlus.21 applications) have to wait.

-- Consider the following query:

write atcai.name||' '||

       atcai.ip_description||' '||

       atcai.ip_input_value||' '||

       atcai.ip_eng_units;

 

-- Since each direct field reference (i.e. atcai.name, atcai.ip_description, atcai.ip_input_value, and atcai.ip_eng_units) is a database read, therefore the query has four separate database accesses.

 

-- Compare that query with

 

set column_headers = 0;

select name, ip_description, ip_input_value, ip_eng_units

       from atcai;

 

-- The second query replaces four direct field references with one select statement that fetches the fields name, ip_description, ip_input_value, and ip_eng_units from atcai.  The select statement is able to read all four fields with one database transaction.

 

-- The same principle is true with indirect field references.

 

-- The query

 

local recname record;

recname = 'ATCAI';

 

write recname->name||' '||

       recname->ip_description||' '||

       recname->ip_input_value||' '||

       recname->ip_eng_units;

 

-- has four database transactions while the query

 

local recname record;

recname = 'ATCAI';

set column_headers = 0;

select name, ip_description, ip_input_value, ip_eng_units

       from ip_analogdef where name = recname;

 

-- has only one database read.

 

-- ·         Reduce the use of Write Statements

-- A simple way to reduce the number of database transactions and the number of statements processed is to eliminate write statements.  Many programmers leave diagnostic write statements in queries forgetting to remove the writes when they are no longer needed.

 

-- ·         Disable logging statements

-- Related to reducing the number of write statements is disabling logging statements but using the command

 

set log_rows = 0;

 

-- at the beginning of the query.

 

-- ·         Avoid like comparisons when accessing a specific record

-- When accessing specific records, use = instead of like in where clauses.

 

-- For example, the query

 

select name, ip_input_time, ip_input_value from ip_analogdef

where name like 'ATCAI';

 

-- causes the query to look at each record defined by IP_AnalogDef to determine if its name equals 'ATCAI'.

 

-- whereas the query

 

select name, ip_input_time, ip_input_value from ATCAI;

 

-- causes the query to call an Aspen InfoPlus.21 API routine to translate 'ATCAI' into a record ID followed by another API routine to directly read the appropriate fields using the record ID.  In this case, the query accesses only one record instead of looping through all tags defined by IP _AnalogDef looking for names that match the string specified in the like statement.

-- ·         Use Temporary Tables

-- Use temporary tables in queries to minimize repeated file or Aspen InfoPlus.21 database accesses.  The IQ task executing a query stores temporary tables in memory. So access to information in a temporary table is faster than querying from the database, or reading from a file.

-- For queries driven by data in text files, read all of the lines (parsing out the individual values) into temporary tables and then process the data from the temporary table instead of reading values one at a time from one line at a time.

-- For example, consider replacing

iFC = (Select Count(*) From '&nFile');

FOR I = 2 To iFC DO

  mFName = (Select trim('"' from substring(2 of LINE between ','))

       FROM '&nFile' Where linenum = i);

  oTName = (Select trim('"' from substring(3 of LINE between ','))

       FROM '&nFile' Where linenum = i);

  pName = (Select trim('"' from substring(4 of LINE between ','))

       FROM '&nFile' Where linenum = i);

  fgSGName = (Select trim('"' from substring(5 of LINE between ','))

       FROM '&nFile' Where linenum = i);

--  < ... Processing ... >

END

 

-- with

 

Declare Local Temporary Table module.tcrf

 (mFName record, oTName record,

  pName  record, fgSGName record);

 

Insert Into module.tcrf

  Select trim('"' from substring(2 of LINE between ','),  -- mFName

         trim('"' from substring(3 of LINE between ','),  -- oTName

         trim('"' from substring(4 of LINE between ','),  -- pName

         trim('"' from substring(5 of LINE between ',')   -- mFName

    From '&nFile'

   Where linenum > 1;

 

For (Select * From module.tcrf) Do

  -- < ... Processing ... >

End

 

-- When a query selects the same information from Aspen InfoPlus.21 multiple times (this happens frequently, for example, when using sub-queries to filter information for a main query), select data from Aspen InfoPlus.21 into a temporary table and then do subsequent selects from the temporary table.


--- For example, consider replacing

FOR SELECT COUNT(name) AS CNT FROM IP_ANALOGDEF WHERE NAME = TKNAME DO

       IF CNT = 1 THEN

--         < ... Processing ... >

       END

END

 

-- with

Declare Local Temporary Table module.TankNames (TankName Char(24));

 

Insert Into module.TankNames

  Select Name From IP_AnalogDef Where Name Like '1TK%';

 

 -- < ... Processing ... >

 

If Exists (Select TankName

             From module.TankNames

            Where TankName = tkname)

Then

 -- < ... Processing ... >

End

 

-- ·         Combine Select Statements with For Loops to Initialize Local Variables with Fields from Records

 

-- Combining select statements with for loops to initialize local variables with fields from records can significantly speed a query.

 

-- For example, the following query takes four database accesses to initialize the local variables HiHi, Hi, Lo, and LoLo since each direct field reference is a database transaction:

 

Local HiHi Real, Hi real, Lo real, LoLo real;

 

HiHi = ATCAI.IP_High_High_Limit;

Hi = ATCAI.IP_High_Limit;

Lo = ATCAI.IP_Low_Limit;

LoLo = ATCAI.IP_Low_Low_Limit;

 

-- By combining a select statement with a for loop, you can initialize the same four variables with only one read to the database as the following example shows:

 

Local HiHi Real, Hi real, Lo real, LoLo real;

 

For (Select ip_high_high_limit, ip_high_limit,

            ip_low_limit, ip_low_low_limit

From atcai)

Do

  HiHi = ip_high_high_limit;

  Hi = ip_high_limit;

  Lo = ip_low_limit;

  LoLo = ip_low_low_limit;

End