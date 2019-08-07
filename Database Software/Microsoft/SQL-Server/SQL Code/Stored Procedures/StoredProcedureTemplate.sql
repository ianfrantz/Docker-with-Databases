/****************************** Prologue *******************************************
***
***    Purpose:					Creates a Stored Procedure
***    Object type:				Stored Procedure
***********************************************************************************/

USE <Database_Name, sysname, Database_Name>;
GO

	IF (OBJECT_ID (N'<Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>', 'P') IS NOT NULL) 
	DROP PROCEDURE <Schema_Name, sysname, Schema_Name>.<Procedure_Name, sysname, Procedure_Name>;
GO

	IF NOT EXISTS (SELECT * FROM [Admin].[dbo].[dba_AppDebug] WHERE [ProcedureName] = '<Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>')
		INSERT INTO [Admin].[dbo].[dba_AppDebug] ([ProcedureName], [LogFlag], [DebugFlag]) 
		VALUES ('<Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>', 1, 1);
GO

	BEGIN TRY
		DECLARE @ServerEnvironmentVariable NVARCHAR(50) = [Support].[Utility].[GetServerEnvironment]();
		IF (@ServerEnvironmentVariable = 'PROD')
		UPDATE [Admin].[dbo].[dba_AppDebug] SET DebugFlag = 0 WHERE [ProcedureName] = '<Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>';
	END TRY
	BEGIN CATCH 
		UPDATE [Admin].[dbo].[dba_AppDebug] SET DebugFlag = 0 WHERE [ProcedureName] = '<Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>';
	END CATCH;
GO --never leave any space between the last GO and CREATE PROCEDURE to ensure error line number matching
CREATE PROCEDURE <Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>
    (
	@pProcGUID UNIQUEIDENTIFIER = null
    -- Put additional parameters here
	-- All parameters should be named with the @p prefix ie @pProcessID
    )
AS

BEGIN

	/*
	*******************************************************************************************************************
	*** Session Settings
	*******************************************************************************************************************
	*/

    SET NOCOUNT ON;
    SET QUOTED_IDENTIFIER OFF;
    SET ARITHABORT ON;
    SET NUMERIC_ROUNDABORT OFF;
    SET CONCAT_NULL_YIELDS_NULL ON;
    SET ANSI_NULLS ON;

    /*
    *******************************************************************************************************************
     Common Error Handling Declaratives
    *******************************************************************************************************************
    */

    DECLARE
        @RetStat INT					--Return status
       ,@RowCnt INT						--Row count from the transaction
       ,@Severity INT					--Severity code
       ,@ErrState TINYINT               --Error state - defined in application
       ,@ErrOut VARCHAR(2046)			--Error message - full message to display
       ,@CrLf CHAR(02);					--Carrage Return Line Feed

    /*
    *******************************************************************************************************************
     Common Logging Declaratives
    *******************************************************************************************************************
    */

	DECLARE @LogResult TABLE (returnValue INT); --Suppression of exec result in stand-along execution
	DECLARE
		 @Proc VARCHAR(80)				--Stored procedure name
		,@Db VARCHAR(30)				--Database where log message originated from
		,@DebugFlag BIT 				--1=Debug Environment, 0=Production Environment
		,@LogStep INT					--Provide a step identifier for logging
		,@LogAction VARCHAR(100)		--Identify action which triggered logging
		,@LogMessage VARCHAR(8000)      --Descriptive log message
		,@InputValues VARCHAR(8000)     --Input parameters for debugging
		,@OutputValues VARCHAR(8000);	--Output parameters for debugging

    /*
    *******************************************************************************************************************
     Process Declaratives
    *******************************************************************************************************************
    */

    DECLARE
    --  <place your declaratives here>

    /*
    *******************************************************************************************************************
     Variable Initialization
    *******************************************************************************************************************
    */

    SET @RetStat = 0;
    SET @RowCnt = 0;
    SET @Severity = 12;					--Default severity
	SET @ErrState = 0;
	SET @LogStep = 0;
    SET @CrLf = CHAR(13) + CHAR(10);
	SET @pProcGUID = ISNULL(@pProcGUID,newID());
	-- Do not use system functions to retrieve schema and procedure name. 
	-- The system function OBJECT_NAME() requires permissions that may not be granted to the caller.
	-- Under this condition, the system function will return a NULL value, which is undesirable.
	SET @Proc = '<Schema_Name, sysname, dbo>.<Procedure_Name, sysname, Procedure_Name>'; 
	SET @Db = '<Database_Name, sysname, Database_Name>';
	SELECT @DebugFlag = DebugFlag FROM [Admin].[dbo].[dba_AppDebug] WHERE [ProcedureName] = @Proc;
	SET @DebugFlag = ISNULL(@DebugFlag,0);

    /*
    *******************************************************************************************************************
     Process Variable Initialization
    *******************************************************************************************************************
    */

    --      <place your variable initialization here>

    BEGIN TRY

		/*
		***************************************************************************************************************
		Log Procedure Start & Input Parameters
		***************************************************************************************************************
	    */
		SELECT @LogStep = @LogStep + 1, @LogAction = 'Start' ,@LogMessage = CONCAT(@Db,'.',@Proc);
		INSERT INTO @LogResult
		EXEC [Admin].[Log].[Verbose] @pProcGUID, @Db, @Proc, @LogAction, @LogMessage, @LogStep;
		-- Replace pParam2, pParam3, etc... with your parameters
		-- Use Admin.dbo.EncryptString before logging any sensitive data
		SET @InputValues = 
				   CONCAT('pProcGUID = ',@pProcGUID 
						 ,' pParam2 = ' ,@pParam2
						 ,' pParam3 = ' ,@pParam3
						 );
		SELECT @LogStep = @LogStep + 1, @LogAction = 'Log Input Parameters';
		INSERT INTO @LogResult
		EXEC [Admin].[Log].[Debug] @pProcGUID, @Db, @Proc, @LogAction, @InputValues, @LogStep;
				
		/*
		***************************************************************************************************************
		Validation Routine
		***************************************************************************************************************
	    */

		SELECT @LogStep = @LogStep + 1, @LogAction = 'Success', @LogMessage = CONCAT(@Db,'.',@Proc);
		INSERT INTO @LogResult
		EXEC [Admin].[Log].[Verbose] @pProcGUID, @Db, @Proc, @LogAction, @LogMessage, @LogStep;
		-- Never insert any code between the log procedure successful completion and end try
    END TRY

	/*
	*******************************************************************************************************************
	Error Handler
	*******************************************************************************************************************
	*/

    BEGIN CATCH
		SELECT @LogStep = 98, @LogAction = 'Failure', @LogMessage = ERROR_MESSAGE();
		INSERT INTO @LogResult
		EXEC [ADMIN].[Log].[Warning] @pProcGUID, @Db, @Proc, @LogAction, @LogMessage, @LogStep;
        SET @Severity = ERROR_SEVERITY() ;
        IF NOT (XACT_STATE() = 0 AND @@TRANCOUNT = 0) AND @Severity > 10 ROLLBACK TRANSACTION;
        -- If you use a Cursor, uncomment the following
		-- IF CURSOR_STATUS ('local' , '<cursor name>' ) >= 0 CLOSE <cursor name>;
		-- IF CURSOR_STATUS ('local' , '<cursor name>' ) = -1 DEALLOCATE <cursor name>;
		INSERT INTO @LogResult
        EXEC [Admin].[Log].[Error] @pProcGuid, @Db;
    END CATCH;

	/*
	***************************************************************************************************************
	Debug Log Output Parameters Procedure Start
	***************************************************************************************************************
    */
	-- Replace pParam1, pParam2, etc... with your output parameters
	-- Use Admin.dbo.EncryptString before logging any sensitive data
		SET @OutputValues = 
	           CONCAT('ReturnStatus = ', @RetStat
					 ,' pParam1 = '    , @pParam1
					 ,' pParam2 = '    , @pParam2
					 );
	SELECT @LogStep = 99, @LogAction = 'Log Output Parameters'; --output parameter logging should always be the last step
	INSERT INTO @LogResult
	EXEC [Admin].[Log].[Debug] @pProcGUID, @Db, @Proc, @LogAction, @OutputValues, @LogStep; 

	RETURN (@RetStat);
END;
GO
