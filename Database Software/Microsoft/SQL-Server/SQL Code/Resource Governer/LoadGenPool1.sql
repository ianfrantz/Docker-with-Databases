DECLARE 
	@Tbl UNIQUEIDENTIFIER = NEWID(),
	@SQL NVARCHAR(MAX);

SET @SQL = REPLACE(REPLACE(REPLACE(
N'
SET NOCOUNT ON;
CREATE TABLE {{@Table}} (id INT IDENTITY (1,1), BigFiller CHAR (8000) DEFAULT "x"); 
CREATE CLUSTERED INDEX {{@CIX}} ON {{@Table}} (id); 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
INSERT INTO {{@Table}} DEFAULT VALUES;  
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES; 
INSERT INTO {{@Table}} DEFAULT VALUES;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
ALTER INDEX ALL ON {{@Table}} REORGANIZE;
DELETE FROM {{@Table}};
DROP TABLE IF EXISTS {{@Table}};
'
, N'{{@Table}}', QUOTENAME(@Tbl))
, N'{{@CIX}}', CONCAT(N'[CIX_',@Tbl,N']'))
,N'"', '''');

EXEC(@SQL);