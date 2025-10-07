# Oracle

Install Oracle Database Express Edition (XE) Downloads on dmzwindows07

https://www.oracle.com/database/technologies/xe-downloads.html

This password will be used for SYS, SYSTEM and PDBADMIN accounts (stored elsewhere)

Destination folder
c:\app\imsdal\product\21c\

Oracle home
c:\app\imsdal\product\21c\dbhomeXE\

Oracle base
c:\app\imsdal\product\21c\

Multitenant container database
localhost:1521

Pluggable database
localhost:1521:XEPDB1

EM Express URL
http://localhost:5500/em

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

## SQL developer


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

## 2\. Execute the `CREATE PLUGGABLE DATABASE` Command

Run the following SQL statement in the SQL Developer Worksheet to create a new PDB. Replace `MYPDB` with your desired new database name.

```sql
CREATE PLUGGABLE DATABASE MYPDB
  ADMIN USER mypdb_admin IDENTIFIED BY YourNewSecurePassword
  FILE_NAME_CONVERT = ('XEPDB1', 'MYPDB');
```

| Component | Description |
| :--- | :--- |
| `MYPDB` | The **name of your new database**. |
| `ADMIN USER mypdb_admin` | Creates a local administrator account for this new PDB. |
| `IDENTIFIED BY ...` | Sets the password for the new `mypdb_admin` user. |
| `FILE_NAME_CONVERT` | Ensures the necessary database files are created correctly for the new PDB. |

-----

## 3\. Open the New PDB

After creation, the new PDB is usually closed. You need to open it to start using it.

```sql
ALTER PLUGGABLE DATABASE MYPDB OPEN;
```

-----

## 4\. Create the New TNS Alias

Now that the new PDB is open, you need to update your **`tnsnames.ora`** file to create a connection alias for it.

1.  Open your `tnsnames.ora` file located at: `C:\app\imsdal\product\21c\dbhomeXE\network\admin`
2.  Copy the existing `XEPDB1_ALIAS` entry and modify it for your new PDB:

<!-- end list -->

```ora
# TNS entry for the new Pluggable Database
MYPDB_ALIAS = 
  (DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SERVER = DEDICATED)
      (SERVICE_NAME = MYPDB)  -- **Crucial: Change this to the PDB name**
    )
  )
```

3.  Save the `tnsnames.ora` file.

-----

## 5\. Connect to Your New Database (PDB)

In SQL Developer, you can now create a final connection to your new database:

  * **Connection Type:** TNS
  * **Username:** `MYPDB_ADMIN`
  * **Password:** `YourNewSecurePassword`
  * **Network Alias:** `MYPDB_ALIAS`

You are now connected to an entirely new, isolated database environment\!