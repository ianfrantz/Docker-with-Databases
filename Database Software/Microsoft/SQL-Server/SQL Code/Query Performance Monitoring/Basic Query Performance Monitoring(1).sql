--Quick and dirty statistics
SET STATISTICS TIME ON; 
SET STATISTICS IO ON;

SELECT * 
FROM Admin.dbo.dba_AppDebug AS p
CROSS JOIN Admin.dbo.dba_AppDebug AS cj1
CROSS JOIN Admin.dbo.dba_AppDebug AS cj2
CROSS JOIN Admin.dbo.dba_AppDebug AS cj3
PRINT '1234567890';

SELECT @@ROWCOUNT

SET STATISTICS TIME OFF; 
SET STATISTICS IO OFF; 
GO

--Statistics based on SQL execution plans
SELECT SUBSTRING(sqltext.text, (querystats.statement_start_offset/2) + 1,
                          ((CASE querystats.statement_end_offset
                            WHEN -1 THEN DATALENGTH(sqltext.text)
                            ELSE querystats.statement_end_offset 
                            END - querystats.statement_start_offset)/2) + 1) AS "Statement Text",
querystats.last_elapsed_time/1000 AS "Last Run Time (ms)", 
querystats.total_logical_reads/execution_count AS "Average Logical Reads",
querystats.total_elapsed_time/1000 AS "Total Elapsed Time (ms)", 
querystats.plan_handle,
queryplan.query_plan,
*

FROM sys.dm_exec_query_stats AS querystats
JOIN sys.dm_exec_cached_plans AS cachedplans ON querystats.plan_handle = cachedplans.plan_handle
LEFT JOIN sys.dm_exec_requests AS execrequests ON querystats.plan_handle = execrequests.plan_handle
CROSS APPLY sys.dm_exec_sql_text (querystats.plan_handle) AS sqltext
CROSS APPLY sys.dm_exec_query_plan(querystats.plan_handle) AS queryplan
WHERE sqltext.text LIKE '%1234567890%'
GO


--Statistics based on execution plans for objects
SELECT *
FROM sys.dm_exec_query_stats AS querystats
JOIN sys.dm_exec_cached_plans AS cachedplans ON querystats.plan_handle = cachedplans.plan_handle
LEFT JOIN sys.dm_exec_requests AS execrequests ON querystats.plan_handle = execrequests.plan_handle
CROSS APPLY sys.dm_exec_sql_text (querystats.plan_handle) AS sqltext
CROSS APPLY sys.dm_exec_query_plan(querystats.plan_handle) AS queryplan
WHERE OBJECT_NAME(sqltext.objectid,sqltext.dbid) = 'Information'
GO

