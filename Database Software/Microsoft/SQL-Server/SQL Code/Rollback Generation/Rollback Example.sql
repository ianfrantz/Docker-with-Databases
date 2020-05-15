USE AdventureWorks2017;
GO

--Enable Ole Automation Procedures
sp_configure 'Show Advanced Options', 1; 
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 1;
GO
RECONFIGURE;
GO


-----Set-up Target table: Person.PersonPhone Variables-----
DECLARE --Create @TargetTable
	@TargetTable TABLE
	(BusinessEntityID INT, PhoneNumber VARCHAR(25), PhoneNumberTypeID INT, ModifiedDate DATETIME);

DECLARE -- Declare the columns matching Person.PersonPhone
    @BusinessEntityID INT,
	@PhoneNumber NVARCHAR(25),
    @PhoneNumberTypeID INT,
    @ModifiedDate DATETIME;

--▼▼▼MODIFY BELOW THIS LINE▼▼▼
SET @BusinessEntityID = 30052;
SET @PhoneNumber = '666-666-6666';
SET @PhoneNumberTypeID = '1';
SET @ModifiedDate = GETDATE();

INSERT INTO @TargetTable Values (@BusinessEntityID, @PhoneNumber, @PhoneNumberTypeID, @ModifiedDate);
--▲▲▲MODIFY ABOVE THIS LINE▲▲▲


-----Set-up Rollback Variables for Procedure-----
DECLARE --Create @RollbackTable
	@RollbackTable TABLE
	(BusinessEntityID INT, PhoneNumber VARCHAR(25), PhoneNumberTypeID INT, ModifiedDate DATETIME, Outcome VARCHAR(20));

DECLARE --
	@TranName VARCHAR(25),
	@RollbackPrimaryKey INT,
	@RollbackScript VARCHAR(255),
	@AddLine VARCHAR(1000);

SET @TranName = 'PhoneNumberUpdate';

--Set RollbackScript Location
SET @RollbackScript = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\Rollback' + FORMAT(GETDATE(), N'_MM_dd_yyyy_HH_mm_ss') + '.sql';

PRINT '';
PRINT 'STARTING MERGE OF TABLE [Adventureworks2017].[Person].[PersonPhone] ON ' + @@SERVERNAME

-----Start Transcation---
BEGIN TRANSACTION @TranName

	BEGIN TRY 
		MERGE [Adventureworks2017].[Person].[PersonPhone] AS PhoneNumberUpdate
			USING @TargetTable TargetTable
			ON PhoneNumberUpdate.BusinessEntityID = TargetTable.BusinessEntityID
		WHEN MATCHED
			THEN UPDATE SET 
				PhoneNumberUpdate.PhoneNumber = TargetTable.PhoneNumber,
				PhoneNumberUpdate.ModifiedDate = TargetTable.ModifiedDate
		WHEN NOT MATCHED BY TARGET
		THEN INSERT (BusinessEntityID, PhoneNumber, PhoneNumberTypeID)
			VALUES (TargetTable.BusinessEntityID, TargetTable.PhoneNumber, TargetTable.PhoneNumberTypeID)
			OUTPUT COALESCE(DELETED.BusinessEntityID, INSERTED.BusinessEntityID),
			DELETED.PhoneNumber,
			DELETED.PhoneNumberTypeID,
			COALESCE (DELETED.ModifiedDate, INSERTED.ModifiedDate),
			$action 
		--Outcome is the resulting $action type. INSERT, UPDATE, ect.
		INTO @RollbackTable (BusinessEntityID, PhoneNumber, PhoneNumberTypeID, ModifiedDate, outcome);

		--See if the @RollbackTable was populated with any changes
		IF (SELECT COUNT(*) FROM @RollbackTable) = 0 
		BEGIN 
			PRINT 'PRODUCTION IS ALREADY CURRENT - NO ACTION NECESSARY'
			PRINT 'STOPPING MERGE OF TABLE [Adventureworks2017].[Person].[PersonPhone] ON ' + @@SERVERNAME
			ROLLBACK TRAN @TranName;
		END	
		
		ELSE BEGIN TRY
		--If the the @RollbackTable had values, use them in the creation of the rollback script.
			PRINT 'GENERATING ROLLBACK SCRIPT ' + @RollbackScript
			DECLARE @OLE INT
			DECLARE @FileID INT
			EXECUTE sp_OACreate 'Scripting.FileSystemObject', @OLE OUTPUT
			--OpenTextFile set to Mode 2 = writing, Create = 1 (True)
			EXECUTE sp_OAMethod @OLE, 'OpenTextFile', @FileID OUT, @RollbackScript, 2, 1
			
			WHILE (SELECT COUNT(*) FROM @RollbackTable) > 0 --Start looping through all edits in @RollbackTable
			BEGIN 
				SELECT @RollbackPrimaryKey = Min(BusinessEntityID) FROM @RollbackTable;
				--Rollback INSERT actions
				IF (SELECT Outcome FROM @RollbackTable WHERE BusinessEntityID = @RollbackPrimaryKey) = 'INSERT' 
				BEGIN 
					SET @AddLine = 'DELETE FROM [Adventureworks2017].[Person].[PersonPhone] WHERE BusinessEntityID = ' + CONVERT(VARCHAR(10),@RollbackPrimaryKey) + ' AND PhoneNumber = ' + '''' + CONVERT(CHAR(25), @PhoneNumber) + '''' 
				END 
				ELSE BEGIN --Rollback UPDATE actions
					SELECT @BusinessEntityID = Min(BusinessEntityID) FROM @RollbackTable WHERE BusinessEntityID = @RollbackPrimaryKey;
					SELECT @ModifiedDate = Min(ModifiedDate) FROM @RollbackTable WHERE BusinessEntityID = @RollbackPrimaryKey;
					SELECT @PhoneNumber = PhoneNumber FROM @RollbackTable WHERE BusinessEntityID = @RollbackPrimaryKey;
					SET @AddLine = 'UPDATE [Adventureworks2017].[Person].[PersonPhone] SET' 
						+ '
						BusinessEntityID = ' + CONVERT(CHAR(10), @BusinessEntityID) 
						+ '
						, ModifiedDate = ' + '''' + CONVERT(VARCHAR(30), @ModifiedDate) +''''
						+ '
						WHERE BusinessEntityID = ' + CONVERT(VARCHAR(15), @RollbackPrimaryKey)
						+ ' AND PhoneNumber = ' + '''' + CONVERT(CHAR(25), @PhoneNumber) + '''' 
				END
				EXECUTE sp_OAMethod @FileID, 'WriteLine', Null, @AddLine
				DELETE FROM @RollbackTable WHERE BusinessEntityID = @RollbackPrimaryKey;
			END

			EXECUTE sp_OADestroy @FileID
			EXECUTE sp_OADestroy @OLE
			PRINT 'SUCCESSFUL GENERATION OF ROLLBACK SCRIPT'
			COMMIT TRANSACTION @TranName;
			PRINT 'SUCCESSFUL MERGE OF TABLE [Adventureworks2017].[Person].[PersonPhone] on ' + @@SERVERNAME
			SELECT --Display results
				PersonPhone.BusinessEntityID
				FROM [Adventureworks2017].[Person].[PersonPhone] PersonPhone
				INNER JOIN @TargetTable TargetTable on PersonPhone.BusinessEntityID = TargetTable.BusinessEntityID
		END TRY

		BEGIN CATCH
			PRINT 'FAILURE GENERATING ROLLBACK SCRIPT ' + ERROR_MESSAGE();
			ROLLBACK TRAN @TranName;
			PRINT 'MERGE OF TABLE [Adventureworks2017].[Person].[PersonPhone] HAS BEEN ROLLED BACK';
		END CATCH

	END TRY

	BEGIN CATCH
		ROLLBACK TRAN @TranName;
		PRINT 'FAILURE TO MERGE TABLE [Adventureworks2017].[Person].[PersonPhone] ' + ERROR_MESSAGE();
	END CATCH
GO

--Disable Ole Automation Procedures
sp_configure 'show advanced options', 1; 
GO
RECONFIGURE;
GO
sp_configure 'Ole Automation Procedures', 0;
GO
RECONFIGURE;
GO