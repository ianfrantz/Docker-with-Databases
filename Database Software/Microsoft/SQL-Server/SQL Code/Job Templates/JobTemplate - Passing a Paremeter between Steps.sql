/****************************** Prologue *******************************************
***
***    Purpose:					Passes a @runGUID between jobs.
***    Object type:				Database
***    Name:					CTRL+ALT+M 
***********************************************************************************/


--Declare and append @runGUID to description.
DECLARE @runGUID UNIQUEIDENTIFIER;
SET @runGUID = NEWID();

DECLARE @desc NVARCHAR(1000);
DECLARE @crlf CHAR(2) = CHAR(0x0d) + CHAR(0x0a);

SELECT @desc = description
FROM msdb.dbo.sysjobs
--Note: Job_Name must already exist.
WHERE NAME = [<Job_Name, NVARCHAR(100), MyJob>];

print @desc;

SET @desc = @desc + @crlf + '@runGUID = ' + cast(@runGUID AS VARCHAR(36)) + ';' + @crlf; 

EXEC msdb.dbo.sp_update_job @job_name = 'LogToSeq', @description = @desc;

--Select @runGUID from description.
DECLARE @desc NVARCHAR(1000);
DECLARE @runGUID UNIQUEIDENTIFIER;

SELECT @desc = description
FROM msdb.dbo.sysjobs
WHERE NAME = 'LogToSeq';

SELECT @runGUID=cast(substring(@desc, charindex('@runGUID', @desc)+len('@runGUID = ')+1, charindex(';', @desc, charindex('@runGUID', @desc))-charindex('@runGUID', @desc) - len('@runGUID = ')-1 ) AS UNIQUEIDENTIFIER)

print @runGUID

---Reset description.
DECLARE @desc NVARCHAR(1000);

SELECT @desc = description
FROM msdb.dbo.sysjobs
WHERE NAME = 'LogToSeq';

SELECT @desc = REPLACE (@desc, @desc, 'Transfer local log messages to SEQ
This process can be run in intervals of minutes. 
An increase in minutes correlates to an increase in efficiency and a corresponding decrease in responsiveness.')

EXEC msdb.dbo.sp_update_job @job_name = 'LogToSeq', @description = @desc;

print @desc;

