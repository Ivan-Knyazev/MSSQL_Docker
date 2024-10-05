# Instruction to up DB from backup in Docker container

### Full instruction on official site Microsoft:

[learn.microsoft.com -> SQL -> restore-backup-in-sql-server-container](https://learn.microsoft.com/ru-ru/sql/linux/tutorial-restore-backup-in-sql-server-container?view=sql-server-ver16&tabs=cli)


* To DB `AdventureWorksLT2017`

## PREPARATION:

1. Create directory `/var/opt/mssql/backup` in container:
```
docker exec -it ms-sql mkdir /var/opt/mssql/backup
```

2. Copy file `AdventureWorksLT2017.bak` from this repository:
```
docker cp AdventureWorksLT2017.bak ms-sql:/var/opt/mssql/backup
```

- Or run instructions from [copy-a-backup-file-into-the-container](https://learn.microsoft.com/ru-ru/sql/linux/tutorial-restore-backup-in-sql-server-container?view=sql-server-ver16&tabs=cli#copy-a-backup-file-into-the-container)


## RESTORE:

1. Run in `bash`:
```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C -S localhost \
   -U SA -P $MSSQL_PASSWORD \
   -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/AdventureWorksLT2017.bak"' \
   | tr -s ' ' | cut -d ' ' -f 1-2
```

   - Or in SQL Client:
```sql
RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/AdventureWorksLT2017.bak'
```

2. Run in `bash`:
```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C \
   -S localhost -U SA -P $MSSQL_PASSWORD \
   -Q 'RESTORE DATABASE AdventureWorksLT2017 FROM DISK = "/var/opt/mssql/backup/AdventureWorksLT2017.bak" WITH MOVE "AdventureWorksLT2012_Data" TO "/var/opt/mssql/data/AdventureWorksLT2017_data.ndf", MOVE "AdventureWorksLT2012_Log" TO "/var/opt/mssql/data/AdventureWorksLT2017.ldf"'
```

   - Or in SQL Client:
```sql
RESTORE DATABASE AdventureWorksLT2017 FROM DISK = '/var/opt/mssql/backup/AdventureWorksLT2017.bak' WITH MOVE 'AdventureWorksLT2012_Data' TO '/var/opt/mssql/data/AdventureWorksLT2012_Data.mdf', MOVE 'AdventureWorksLT2012_Log' TO '/var/opt/mssql/data/AdventureWorksLT2012_Log.ldf';
```


## CHECK:

Run in `bash`:
```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C \
   -S localhost -U SA -P $MSSQL_PASSWORD \
   -Q 'USE AdventureWorksLT2017;
      SELECT 
         P.ProductID, 
         P.Name 
      FROM SalesLT.Product AS P;'
```

   - Or in SQL Client:
```sql
USE AdventureWorksLT2017;
SELECT 
    P.ProductID, 
    P.Name 
FROM SalesLT.Product AS P;
```

<hr>

This guide was created to study SQL in the `Data Bases` course at NUST `MISIS` 22.09.24