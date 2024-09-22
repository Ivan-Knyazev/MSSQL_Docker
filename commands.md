# Instruction to up DB from backup in Docker container

### Full instruction:

[learn.microsoft.com -> SQL -> restore-backup-in-sql-server-container](https://learn.microsoft.com/ru-ru/sql/linux/tutorial-restore-backup-in-sql-server-container?view=sql-server-ver16&tabs=cli)


* To DB `AdventureWorksLT2017`

## PREPARATION:

1. Run instructions from [copy-a-backup-file-into-the-container](https://learn.microsoft.com/ru-ru/sql/linux/tutorial-restore-backup-in-sql-server-container?view=sql-server-ver16&tabs=cli#copy-a-backup-file-into-the-container)

2. Run in `bash`:
```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C -S localhost \
   -U SA -P '%N4!aJ4E8&4O' \
   -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/AdventureWorksLT2017.bak"' \
   | tr -s ' ' | cut -d ' ' -f 1-2
```

   - Or in SQL Client:
```sql
RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/AdventureWorksLT2017.bak'
```

## RESTORE:

3. Run in `bash`:
```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C \
   -S localhost -U SA -P '%N4!aJ4E8&4O' \
   -Q 'RESTORE DATABASE AdventureWorksLT2017 FROM DISK = "/var/opt/mssql/backup/AdventureWorksLT2017.bak" WITH MOVE "AdventureWorksLT2012_Data" TO "/var/opt/mssql/data/AdventureWorksLT2017_data.ndf", MOVE "AdventureWorksLT2012_Log" TO "/var/opt/mssql/data/AdventureWorksLT2017.ldf"'
```

   - Or in SQL Client:
```sql
RESTORE DATABASE AdventureWorksLT2017 FROM DISK = '/var/opt/mssql/backup/AdventureWorksLT2017.bak' WITH MOVE 'AdventureWorksLT2012_Data' TO '/var/opt/mssql/data/AdventureWorksLT2012_Data.mdf', MOVE 'AdventureWorksLT2012_Log' TO '/var/opt/mssql/data/AdventureWorksLT2012_Log.ldf';
```


## CHECK:

4. Run in `bash`:
```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C \
   -S localhost -U SA -P '%N4!aJ4E8&4O' \
   -Q 'SELECT Name FROM sys.Databases'
```

   - Or in SQL Client:
```sql
USE AdventureWorksLT2017;
SELECT 
    P.ProductID, 
    P.Name 
FROM SalesLT.Product AS P;
```

<br/>
This guide was created to study SQL in the `Data Bases` course at NUST `MISIS` 22.09.24