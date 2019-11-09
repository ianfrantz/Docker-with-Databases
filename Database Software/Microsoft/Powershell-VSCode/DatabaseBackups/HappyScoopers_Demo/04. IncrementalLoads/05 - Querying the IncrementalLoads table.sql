USE [HappyScoopers_DW]
GO

SELECT 
	TableName,
	CAST(LoadDate AS date) AS LastLoadDate
FROM [int].[IncrementalLoads]
ORDER BY TableName