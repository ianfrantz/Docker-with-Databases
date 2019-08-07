/****************************** Prologue *******************************************
***
***    Purpose:					Creates a SQL Job
***    Object type:				Job
***    Name:					
***********************************************************************************/
USE [msdb]
GO

/****** Object:  Job [<Job_Name, NVARCHAR(100), MyJob>] ******/
BEGIN TRANSACTION

DECLARE @ReturnCode INT
		,@OldJobName NVARCHAR(128)
		,@NewJobName NVARCHAR(128)
		,@NewJobDesc NVARCHAR(512)
		,@NewJobCategory SYSNAME
		,@ProductionServer NVARCHAR(16)
		,@OldScheduleId INT
		,@OldJobServerId INT
		,@OldJobServerName NVARCHAR(30)
		,@jobId BINARY(16);

SET @OldJobName = N'<Old_Job_Name, NVARCHAR(128), MyOldJob>';
SET @NewJobName = N'<Job_Name, NVARCHAR(128), @OldJobName>';
SET @NewJobDesc = N'<Job_Description, NVARCHAR(512), My Job Description>';
SET @NewJobCategory = N'<Job_Category, SYSNAME, Category.Subcategory>';
SET @ProductionServer = N'<ProdServer_Name, NVARCHAR(16), PDX0SQLXX>';
SET @ReturnCode = 0;

SELECT @jobId = job_id FROM msdb.dbo.sysjobs_view WHERE name = @OldJobName;
IF @jobID IS NULL
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_job @job_name=@NewJobName
		,@enabled = 0
		,@description = 'No description available'
		,@start_step_id = 1
		,@category_name = NULL
		,@category_id = NULL
		,@owner_login_name=N'sa'
		,@notify_level_eventlog=0
		,@notify_level_email=0
		,@notify_level_netsend=0
		,@notify_level_page=0
		,@notify_email_operator_name = NULL
		,@notify_netsend_operator_name = NULL
		,@notify_page_operator_name = NULL
		,@delete_level=0
		,@job_id = @jobID OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
END 

ELSE BEGIN
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID
		,@new_name = @NewJobName
		,@enabled = 0
		,@description = 'No description available'
		,@start_step_id = 1
		,@category_name = NULL
		,@owner_login_name = N'sa'
		,@notify_level_eventlog=0
		,@notify_level_email=0
		,@notify_level_netsend=0
		,@notify_level_page=0
		,@notify_email_operator_name = NULL
		,@notify_netsend_operator_name = NULL
		,@notify_page_operator_name = NULL
		,@delete_level=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback	
END

/*|******************************************************************|
  | Reset all job steps                                              |
  |******************************************************************|*/

EXEC @ReturnCode = msdb.dbo.sp_delete_jobstep @job_id = @JobID ,@step_id = 0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback	

/*|******************************************************************|
  | Reset all job schedules                                          |
  |******************************************************************|*/

SELECT @OldScheduleId = min(schedule_id) FROM msdb.dbo.sysjobschedules WHERE job_id = @JobID
WHILE @OldScheduleId IS NOT NULL
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_detach_schedule @job_id = @JobID 
		,@schedule_id = @OldScheduleId
		,@delete_unused_schedule = 1;
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback	
SELECT @OldScheduleId = min(schedule_id) FROM msdb.dbo.sysjobschedules WHERE job_id = @JobID AND schedule_id > @OldScheduleId
END 

/*|******************************************************************|
  | Reset all job servers                                            |
  |******************************************************************|*/

SELECT @OldJobServerId = min(server_id) FROM msdb.dbo.sysjobservers WHERE job_id = @JobID
WHILE @OldJobServerId IS NOT NULL
BEGIN
SELECT @OldJobServerName = name from sys.servers WHERE server_id = @OldJobServerId
EXEC @ReturnCode = msdb.dbo.sp_delete_jobserver @job_id = @JobID 
		,@server_name = @OldJobServerName
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback	
SELECT @OldJobServerId = min(server_id) FROM msdb.dbo.sysjobservers WHERE job_id = @JobID AND server_id > @OldJobServerId
END 


/****** Object:  JobCategory [<Job_Category, NVARCHAR(100), Category.Subcategory>] ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=@NewJobCategory AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=@NewJobCategory
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
END

DECLARE @EnabledJob BIT,
		@Command1 NVARCHAR(1000),
		@ConfigFile1 NVARCHAR(200)

IF @@ServerName = @ProductionServer BEGIN
	SET @EnabledJob = 1
	SET @ConfigFile1 = 'D:\SSIS\ConfigFiles\<ConfigFile1_Name, NVARCHAR(200), myConfig>.Prod.dtsConfig'
END ELSE IF @@ServerName = '<UATServer_Name, sysname, PDX0SQLXX>' BEGIN
	SET @EnabledJob = 0
	SET @ConfigFile1 = 'D:\SSIS\ConfigFiles\<ConfigFile1_Name, NVARCHAR(200), myConfig>.UAT.dtsConfig'
END ELSE IF @@ServerName = '<IntegrationServer_Name, sysname, PDX0SQLXX>' BEGIN
	SET @EnabledJob = 0
	SET @ConfigFile1 = 'D:\SSIS\ConfigFiles\<ConfigFile1_Name, NVARCHAR(200), myConfig>.Integration.dtsConfig'
END ELSE BEGIN
	SET @EnabledJob = 0
	SET @ConfigFile1 = ''
END	

SET @Command1 = N'/FILE "d:\SSIS\Packages\<SSISFile_Name, NVARCHAR(200), SSIS.dtsx>" /CONFIGFILE "' +@ConfigFile1 + '" /MAXCONCURRENT " -1 " /CHECKPOINTING OFF /REPORTING E' 

/****************************************************************/
/*          POPULATE EMPTY JOB                                  */
/****************************************************************/

EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID
		,@new_name = @NewJobName
		,@enabled = @EnabledJob
		,@description = @NewJobDesc
		,@start_step_id = 1
		,@category_name = @NewJobCategory
		,@owner_login_name = N'sa'
		,@notify_level_eventlog=0
		,@notify_level_email=0
		,@notify_level_netsend=0
		,@notify_level_page=0
		,@notify_email_operator_name = NULL
		,@notify_netsend_operator_name = NULL
		,@notify_page_operator_name = NULL
		,@delete_level=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/*|*********************************************************|
  | Add each Job Step below using the @Command variable(s)  |
  |*********************************************************|*/

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

/*|*********************************************************|
  | Add each Job Schedule below                             |
  |*********************************************************|*/

IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
