/****************************** Prologue *******************************************
*****
*****	Purpose: Job template to e-mail interested parties based on SQL results
*****	Object type: Job
*****	Hardcoded: Notify Levels, Job Schedule
***********************************************************************************/
USE [msdb]
GO

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0

IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
GOTO QuitWithRollback
END

-----Add the Job-----
DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'<Job_Name, NVARCHAR(50), Alerting - [jobname]>', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'<Job_Description, NVARCHAR(200), What_it_does>', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'<Job_Owner, NVARCHAR(25), GFS\sqlserver>', 
		@notify_email_operator_name=N'<Notify_Operator, NVARCHAR(50), Itsystemalerts>', 
		@job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
GOTO QuitWithRollback

-----Schedule the Job-----
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, 
		@name=N'<Job_Name, NVARCHAR(50), Alerting - [jobname]>', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@active_start_date=20201001, 
		@active_end_date=99991231, 
		@active_start_time=050000
IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
GOTO QuitWithRollback

-----Step 1 of the Job (Execute Code)-----
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, 
		@step_name=N'<SQL_Step1_Name, NVARCHAR(50), Execute SQL>', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, 
		@subsystem=N'TSQL', 
		-----Put your SQL in below-----
		@command=N'
IF EXISTS (
SELECT ZTSPIERROR
FROM OPENQUERY 
(Artiva,
''SELECT ZTSPIERROR
FROM ZTSPINSTANCE''
)
WHERE ZTSPIERROR IS NOT NULL
)

BEGIN
DECLARE
@ToAddress       VARCHAR(250)
,@CcAddress       VARCHAR(250)
,@FromAddress     VARCHAR(250)
,@EmailImportance VARCHAR(10)
,@Subject         VARCHAR(255)
,@MessageBody     VARCHAR(500)
,@ProfileName     VARCHAR(25)
,@Server          VARCHAR(10)

SET @ProfileName = ''DEV0SQL15'';
SET @ToAddress   = ''Ian.Frantz@genesis-fs.com'';
SET @FromAddress     = ''Ian.Frantz@genesis-fs.com'';
SET @EmailImportance = ''Normal'';
SET @Subject     = ''TSYS Statement Processor Errored'';
SET @MessageBody = ''The TSYS Statement Processor is now halted at: ''  +  CONVERT(VARCHAR, GETDATE(), 22) 

--------------------------------------------------------------------
-- Send Email Notification
--------------------------------------------------------------------
EXEC msdb.dbo.sp_send_dbmail
@profile_name = @ProfileName,
@from_address = @FromAddress,
@recipients = @ToAddress,
@subject = @Subject,
@importance = @EmailImportance,
@body = @MessageBody,
@body_format = ''HTML'';
END
', 
		@database_name=N'<Database_Name, NVARCHAR(50), msdb>', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, 
	@start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
GOTO QuitWithRollback

EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, 
		@server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) 
GOTO QuitWithRollback

COMMIT TRANSACTION
GOTO EndSave

-----Rollback or Save-----
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION

EndSave:
GO