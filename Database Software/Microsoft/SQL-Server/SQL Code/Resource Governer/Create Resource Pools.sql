/* Current Resource Governor Configuration */
SELECT * FROM sys.dm_resource_governor_configuration;

/* Create two resource pools */
CREATE RESOURCE POOL Pool1
WITH (CAP_CPU_PERCENT = 100, MAX_CPU_PERCENT = 90);
CREATE RESOURCE POOL Pool2
WITH (CAP_CPU_PERCENT = 100, MAX_CPU_PERCENT = 10);

/*
ALTER RESOURCE POOL Pool1
WITH (CAP_CPU_PERCENT = 60, MAX_CPU_PERCENT = 100);
ALTER RESOURCE POOL Pool2
WITH (CAP_CPU_PERCENT = 10, MAX_CPU_PERCENT = 100);
*/

/* Look at configuration */
SELECT * FROM sys.dm_resource_governor_resource_pools;

/* This is how you enable or reconfigure */
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO
SELECT * FROM sys.dm_resource_governor_resource_pools;

/* Add two workload groups that use the created pools */
CREATE WORKLOAD GROUP WG1 USING Pool1;

CREATE WORKLOAD GROUP WG2 USING Pool2;

/* Checkout the configuration */
SELECT * FROM sys.dm_resource_governor_workload_groups;

/* Need to reconfigure */
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO
SELECT * FROM sys.dm_resource_governor_workload_groups;

/* Create some databases */
DROP DATABASE IF EXISTS Pool1;
CREATE DATABASE Pool1;

DROP DATABASE IF EXISTS Pool2;
CREATE DATABASE Pool2;

/* Remove classifier function */
ALTER RESOURCE GOVERNOR
	WITH (CLASSIFIER_FUNCTION = NULL);
GO
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO

USE master;
GO
CREATE OR ALTER FUNCTION dbo.MyClassifier()
RETURNS SYSNAME WITH SCHEMABINDING
AS
BEGIN
	DECLARE @GroupName SYSNAME;

	IF ORIGINAL_DB_NAME() = N'Pool1'
		SET @GroupName = N'WG1';

	IF ORIGINAL_DB_NAME() = N'Pool2'
		SET @GroupName = N'WG2';

	RETURN @GroupName;
END;
GO
/* Register the classifier function to enable the governing */
ALTER RESOURCE GOVERNOR
	WITH (CLASSIFIER_FUNCTION = dbo.MyClassifier);
GO
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO

/* Check configuration */
SELECT * FROM sys.dm_resource_governor_configuration;