--Declare and append @runGUID to description.
DECLARE @runGUID UNIQUEIDENTIFIER;
SET @runGUID = NEWID();

DECLARE @desc NVARCHAR(1000);
DECLARE @crlf CHAR(2) = CHAR(0x0d) + CHAR(0x0a);

SELECT @desc = description
FROM msdb.dbo.sysjobs
WHERE NAME = 'LogToSeq';

PRINT @desc;

SET @desc = @desc + @crlf + '@runGUID = ' + cast(@runGUID AS VARCHAR(36)) + ';' + @crlf; 

EXEC msdb.dbo.sp_update_job @job_name = 'LogToSeq', @description = @desc;

--Select @runGUID from description.
DECLARE @desc NVARCHAR(1000);
DECLARE @runGUID UNIQUEIDENTIFIER;

SELECT @desc = description
FROM msdb.dbo.sysjobs
WHERE NAME = 'LogToSeq';

SELECT @RUNGUID=CAST(SUBSTRING(@DESC, CHARINDEX('@RUNGUID', @DESC)+LEN('@RUNGUID = ')+1, CHARINDEX(';', @DESC, CHARINDEX('@RUNGUID', @DESC))-CHARINDEX('@RUNGUID', @DESC) - LEN('@RUNGUID = ')-1 ) AS UNIQUEIDENTIFIER)

PRINT @runGUID

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

