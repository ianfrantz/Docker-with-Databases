USE Admin;
GO

DECLARE
	@pProcGUID UNIQUEIDENTIFIER = null
	,@Proc VARCHAR(80)				--Stored procedure name
	,@Db VARCHAR(30)				--Database where log message originated from
	,@DebugFlag BIT 				--1=Debug Environment, 0=Production Environment
	,@LogStep INT					--Provide a step identifier for logging
	,@LogAction VARCHAR(100)		--Identify action which triggered logging
	,@LogMessage VARCHAR(8000)      --Descriptive log message
	,@InputValues VARCHAR(8000)     --Input parameters for debugging
	,@OutputValues VARCHAR(8000);	--Output parameters for debugging

SET @pProcGUID = ISNULL(@pProcGUID,newID());
SET @Proc = 'FooBarBaz'; 
SET @Db = 'Admin';
SELECT @DebugFlag = DebugFlag FROM [Admin].[dbo].[dba_AppDebug] WHERE [ProcedureName] = @Proc;
SET @DebugFlag = ISNULL(@DebugFlag,0);
SET @LogStep = 0;

DECLARE @QueryString VARCHAR(1000)
SET @QueryString = '
SELECT '''+ CAST(@pProcGUID AS VARCHAR(64)) +''', ''Anothertest'', *  
FROM Admin.dbo.dba_AppDebug AS p
CROSS JOIN Admin.dbo.dba_AppDebug AS cj1
CROSS JOIN Admin.dbo.dba_AppDebug AS cj2
CROSS JOIN Admin.dbo.dba_AppDebug AS cj3
'

EXEC(@QueryString)

DECLARE @RunDate DATETIME;
DECLARE @TotalElapsedTime BIGINT;

SET @RunDate = GETDATE()

IF OBJECT_ID('tempdb..#SQLtoSEQQueryPerformance') IS NOT NULL DROP TABLE #SQLtoSEQQueryPerformance;

CREATE TABLE #SQLtoSEQQueryPerformance (RowId INT IDENTITY(1,1), RunDate DATETIME, pProcGUID UNIQUEIDENTIFIER,  TotalElapsedTime BIGINT, plan_handle VARBINARY(64), StatementText VARCHAR(MAX));
INSERT INTO #SQLtoSEQQueryPerformance  (RunDate, pProcGUID, TotalElapsedTime, plan_handle,StatementText)

--SELECT @RunDate, @pProcGUID, querystats.total_elapsed_time/1000, querystats.plan_handle,
--SUBSTRING(sqltext.text, (querystats.statement_start_offset/2) + 1,
--                          ((CASE querystats.statement_end_offset
--                            WHEN -1 THEN DATALENGTH(sqltext.text)
--                            ELSE querystats.statement_end_offset 
--                            END - querystats.statement_start_offset)/2) + 1) AS "Statement Text"
--FROM sys.dm_exec_query_stats AS querystats
--JOIN sys.dm_exec_cached_plans AS cachedplans ON querystats.plan_handle = cachedplans.plan_handle
--LEFT JOIN sys.dm_exec_requests AS execrequests ON querystats.plan_handle = execrequests.plan_handle
--CROSS APPLY sys.dm_exec_sql_text (querystats.plan_handle) AS sqltext
--CROSS APPLY sys.dm_exec_query_plan(querystats.plan_handle) AS queryplan
--WHERE sqltext.text LIKE '%@pProcGUID%'


SELECT @RunDate, @pProcGUID, queryData.total_elapsed_time/1000, queryData.plan_handle, queryData.[Statement Text]
FROM
	(SELECT query_plan_hash, querystats.plan_handle,querystats.total_elapsed_time, sqltext.text queryText, 
	--SUBSTRING to clean up whitespace
	SUBSTRING(sqltext.text, (querystats.statement_start_offset/2) + 1,
    ((CASE querystats.statement_end_offset
    WHEN -1 THEN DATALENGTH(sqltext.text)
    ELSE querystats.statement_end_offset 
    END - querystats.statement_start_offset)/2) + 1) AS "Statement Text"
	
	FROM sys.dm_exec_query_stats AS querystats
	CROSS APPLY sys.dm_exec_sql_text (querystats.plan_handle) AS sqltext
	WHERE sqltext.text LIKE  '%' + CAST(@pProcGUID AS VARCHAR(64)) + '%'
	) queryData

WHERE queryData.[Statement Text] LIKE '%' + CAST(@pProcGUID AS VARCHAR(64)) + '%'

SELECT * 
FROM #SQLtoSEQQueryPerformance
