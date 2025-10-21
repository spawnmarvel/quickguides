# Oracle

Install Oracle Database Express Edition (XE) Downloads on dmzwindows07

https://www.oracle.com/database/technologies/xe-downloads.html

This password will be used for SYS, SYSTEM and PDBADMIN accounts (stored elsewhere)

Destination folder
* c:\app\imsdal\product\21c\

Oracle home
* c:\app\imsdal\product\21c\dbhomeXE\

Oracle base
* c:\app\imsdal\product\21c\

Multitenant container database
* localhost:1521

Pluggable database
* localhost:1521:XEPDB1

EM Express URL
* http://localhost:5500/em


![installed](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/installed.png)

## TNS stands for Transparent Network Substrate. tnsnames.ora


The tnsnames.ora file is a fundamental configuration file used by Oracle Net Services to connect to an Oracle Database.

Essentially, it acts as a phone book or a directory service that translates a simple, user-friendly name (the TNS Alias or Service Name) into all the detailed connection information needed to reach the database listener on the network.


```ora
# You can use any name here, this is your TNS Alias
XEPDB1_ALIAS = 
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XEPDB1)
    )
  )

# Another common entry name:
XE = 
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = XE)
    )
  )

```
Make sure the service OracleORADB21Home1TNSListner is running

## SQL developer

Install Oracle SQL Developer Downloads Windows 64-bit with JDK 17 included

https://www.oracle.com/database/sqldeveloper/technologies/download/

![sql con](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/sql_con.png)

Connect with the password created for the 3 users on install, use SYSTEM to XE

![connected](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/connected2.png)

## New Pluggable Database (PDB)

That's great news that you're connected\! Since you are using **Oracle Database Express Edition (XE) 21c**, the concepts of creating a "new database" are different due to its **Multitenant Architecture**.

You don't typically create a whole new database instance. Instead, you create a new **Pluggable Database (PDB)** inside your existing **Container Database (CDB)**, which is named `XE`.

The aliases you have show this architecture:

  * **`XE`**: Connects to the main **Container Database (CDB)**.
  * **`XEPDB1`**: Connects to the default **Pluggable Database (PDB)** inside the CDB.

Here is the step-by-step process to create your own isolated database (PDB) using SQL commands in SQL Developer.

-----

## 1\. Connect to the Root Container Database (CDB)

You must connect as an administrative user (`SYS` or `SYSTEM`) to the main container database (`XE`) to create a new PDB.

1.  In SQL Developer, open your `XE` connection (or create a new one using the `XE` alias).
2.  Change the **Username** to **`SYS`**.
3.  Change the **Role** to **`SYSDBA`**.
4.  Connect.

-----

![sys_con](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/sys_con.png)


This implies that you are connected to the root container instead of to a regular plug in database (pdb) where applications should be built.

## 2\. Execute the `CREATE PLUGGABLE DATABASE` Command

Run the following SQL statement in the SQL Developer Worksheet to create a new PDB. Replace `MYPDB` with your desired new database name.

```sql
CREATE PLUGGABLE DATABASE MYPDB1
  ADMIN USER mypdb_admin1 IDENTIFIED BY YourNewSecurePassword1
  FILE_NAME_CONVERT = ('PDBSEED', 'MYPDB1');
```

| Component | Description |
| :--- | :--- |
| `MYPDB1` | The **name of your new database**. |
| `ADMIN USER mypdb_admin1` | Creates a local administrator account for this new PDB. |
| `IDENTIFIED BY ...` | Sets the password for the new `mypdb_admin` user. |
| `FILE_NAME_CONVERT` | Ensures the necessary database files are created correctly for the new PDB. |

-----

![mypdb1](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/mypdb1.png)

## 3\. Open the New PDB

After creation, the new PDB is usually closed. You need to open it to start using it.

If you are in a Multitenant Container Database (CDB), you need to check the status of all PDBs. You must run this query while connected to the CDB Root (CDB$ROOT).


```sql
SELECT NAME, OPEN_MODE, RESTRICTED
FROM V$PDBS;

```
Check db


![check_db](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/check_db.png)


NAME	OPEN_MODE	Meaning

* MYPDB	READ WRITE	The PDB is fully open and ready for use.
* PDB$SEED	READ ONLY	The template PDB is always read-only.
* ANOTHERPDB	MOUNTED	The PDB is closed and not accessible by users.
* MYPDB	READ WRITE and RESTRICTED is YES	The PDB is open, but only users with the RESTRICTED SESSION privilege can connect (DBA maintenance mode).


As sysdba

```cmd
C:\Users\imsdal>sqlplus / as sysdba

```
```sql
# C:\Users\imsdal>sqlplus / as sysdba

SQL*Plus: Release 21.0.0.0.0 - Production on Tue Oct 21 21:32:48 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.


Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> ALTER PLUGGABLE DATABASE MYPDB1 OPEN;

Pluggable database altered.

SQL> exit
Disconnected from Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0
```

Check db again


```sql
SELECT NAME, OPEN_MODE, RESTRICTED
FROM V$PDBS;

```

![check_db2](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/check_db2.png)


-----

## 4\. Create the New TNS Alias

Now that the new PDB is open, you need to update your **`tnsnames.ora`** file to create a connection alias for it.

1.  Open your `tnsnames.ora` file located at: `C:\app\imsdal\product\21c\dbhomeXE\network\admin`
2.  Copy the existing `XEPDB1_ALIAS` entry and modify it for your new PDB:

<!-- end list -->

```ora
# TNS entry for the new Pluggable Database
MYPDB1_ALIAS = 
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = MYPDB1)  -- **Crucial: Change this to the PDB name**
    )
  )
```

3.  Save the `tnsnames.ora` file.

-----

## 5\. Connect to Your New Database (PDB)

In SQL Developer, you can now create a final connection to your new database:

  * **Connection Type:** TNS
  * **Username:** `mypdb_admin1`
  * **Password:** `YourNewSecurePassword1`
  * **Network Alias:** `MYPDB1_ALIAS`

You are now connected to an entirely new, isolated database environment\!

![connectd plugdb](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/connected_plugdb.png)

# Get to know SQL developer and Oracle

## Create table


It's a common confusion when creating a new Pluggable Database (PDB) in Oracle. The user you created, mypdb_admin1, is the PDB's administrator, but by default, this user is only granted the necessary privileges to manage the PDB (like stopping/starting it) and basic session rights. It is not automatically granted the CREATE TABLE system privilege.


```cmd
C:\Users\imsdal>sqlplus / as sysdba
```
Do security

```sql
SQL> ALTER SESSION SET CONTAINER = MYPDB1;

Session altered.

SQL> GRANT CREATE TABLE TO mypdb_admin1;

Grant succeeded.

```

For schema owners and application users, the standard practice is to grant the RESOURCE role, which includes CREATE TABLE and other privileges needed to create objects like sequences and procedures.


```sql
SQL> GRANT RESOURCE TO mypdb_admin1;

Grant succeeded.

```

And more security

```sql
INSERT INTO "MYPDB_ADMIN1"."EMPLOYEE_DATA" (EMPLOYEE_ID, EMPLOYEE_FNAME, EMPLOYEE_LNAME) VALUES ('1', 'John', 'Doe')
ORA-01950: no privileges on tablespace 'SYSTEM'
ORA-06512: at line 1

```

```cmd
C:\Users\imsdal>sqlplus / as sysdba
```

```sql
SELECT file_name FROM dba_data_files WHERE tablespace_name = 'SYSTEM';

FILE_NAME
--------------------------------------------------------------------------------
-- C:\APP\IMSDAL\PRODUCT\21C\ORADATA\XE\MYPDB1\SYSTEM01.DBF

CREATE TABLESPACE USERS DATAFILE 'C:\APP\IMSDAL\PRODUCT\21C\ORADATA\XE\MYPDB1\users01.dbf' SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;

-- Tablespace created.


ALTER USER MYPDB_ADMIN1 QUOTA UNLIMITED ON USERS;

-- User altered.

COMMIT;

-- Commit complete.

ALTER USER MYPDB_ADMIN1 DEFAULT TABLESPACE USERS;

-- User altered.

COMMIT;

-- Commit complete.

-- The existing table, "MYPDB_ADMIN1"."EMPLOYEE_DATA", was created when your user's default tablespace was still set to SYSTEM. 
-- Therefore, the table itself resides in the SYSTEM tablespace.

ALTER TABLE MYPDB_ADMIN1.EMPLOYEE_DATA MOVE TABLESPACE USERS;

--Table altered.

COMMIT;

-- Commit complete.

```

Now we can create the table as mypdb_admin1


List tables

```sql
SELECT table_name
FROM USER_TABLES
ORDER BY table_name;

```
![list table](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/list_table.png)

Success create table

![create table](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/create_table.png)


## Insert table SQL Developer

![insert](https://github.com/spawnmarvel/quickguides/blob/main/oracle/images/insert.png)

## Insert table SQL

```sql
INSERT INTO "MYPDB_ADMIN1"."EMPLOYEE_DATA" (EMPLOYEE_ID, EMPLOYEE_FNAME, EMPLOYEE_LNAME) VALUES ('2', 'Steven', 'Doe')

```



## Update table

## Change password for user

## Create job and execute it