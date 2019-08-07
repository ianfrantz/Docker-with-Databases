USE [master]
GO

/****** Object:  WorkloadGroup [Foo]    Script Date: 4/27/2019 3:43:01 PM ******/
CREATE WORKLOAD GROUP [Foo] WITH(group_max_requests=0, 
		importance=Medium, 
		request_max_cpu_time_sec=0, 
		request_max_memory_grant_percent=25, 
		request_memory_grant_timeout_sec=0, 
		max_dop=0) USING [default], EXTERNAL [default]
GO

ALTER RESOURCE GOVERNOR RECONFIGURE;

SELECT * FROM sys.dm_resource_governor_configuration;
SELECT * FROM sys.dm_resource_governor_workload_groups;

CREATE OR ALTER FUNCTION foo (@bar int)
RETURNS numeric 
AS 
	BEGIN
	RETURN
	(SELECT @bar + 1)
	END