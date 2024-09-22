# Instruction to up DB from backup in Docker container

### Full instruction:

* To DB `AdventureWorksLT2017`

## PREPARATION:

```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C -S localhost \
   -U SA -P '%N4!aJ4E8&4O' \
   -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/AdventureWorksLT2017.bak"' \
   | tr -s ' ' | cut -d ' ' -f 1-2
```

```sql
RESTORE FILELISTONLY FROM DISK = '/var/opt/mssql/backup/AdventureWorksLT2017.bak'
```

## RESTORE:

```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C \
   -S localhost -U SA -P '%N4!aJ4E8&4O' \
   -Q 'RESTORE DATABASE AdventureWorksLT2017 FROM DISK = "/var/opt/mssql/backup/AdventureWorksLT2017.bak" WITH MOVE "AdventureWorksLT2012_Data" TO "/var/opt/mssql/data/AdventureWorksLT2017_data.ndf", MOVE "AdventureWorksLT2012_Log" TO "/var/opt/mssql/data/AdventureWorksLT2017.ldf"'
```

```sql
RESTORE DATABASE AdventureWorksLT2017 FROM DISK = '/var/opt/mssql/backup/AdventureWorksLT2017.bak' WITH MOVE 'AdventureWorksLT2012_Data' TO '/var/opt/mssql/data/AdventureWorksLT2012_Data.mdf', MOVE 'AdventureWorksLT2012_Log' TO '/var/opt/mssql/data/AdventureWorksLT2012_Log.ldf';
```


## CHECK:

```bash
docker exec -it ms-sql /opt/mssql-tools18/bin/sqlcmd -C \
   -S localhost -U SA -P '%N4!aJ4E8&4O' \
   -Q 'SELECT Name FROM sys.Databases'
```

```sql
USE AdventureWorksLT2017;
SELECT 
    P.ProductID, 
    P.Name 
FROM SalesLT.Product AS P;
```

<br/>
This guide was created to study SQL in the `Data Bases` course at NUST `MISIS` 22.09.24