/****************************** Prologue *******************************************
*****
*****	Purpose:				Creates a database from a file
*****	Object type:			Database
*****	dbname:					
*****	logname:				
*****	Hardcoded:				sp_changedbowner 'sa'
***********************************************************************************/
USE [master];
DROP DATABASE IF EXISTS AdventureWorks2017;

CREATE DATABASE AdventureWorks2017

--Code stops working here.
RESTORE DATABASE AdventureWorks2017
FROM DISK = '/src/adventureworks/AdventureWorks2017.bak'

USE AdventureWorks2017;
EXEC sp_changedbowner 'sa'


--Attempts to get more elaborate with the CREATE and RESTORE
CREATE DATABASE AdventureWorks2017
ON   
	(NAME = AdventureWorks2017,  
		FILENAME = '/var/AdventureWorks2017.mdf',  
		SIZE = 10,  
		MAXSIZE = 50,  
		FILEGROWTH = 5 )  
LOG ON  
	(NAME = AdventureWorks2017,  
		FILENAME = '/var/AdventureWorks2017.log',  
		SIZE = 5MB,  
		MAXSIZE = 25MB,  
		FILEGROWTH = 5MB )