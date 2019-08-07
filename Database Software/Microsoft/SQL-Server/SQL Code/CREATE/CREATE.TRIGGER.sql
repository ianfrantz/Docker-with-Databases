/****************************** Prologue *******************************************
***
***    Purpose:					Creates a database from a flatfile
***    Object type:				Database
***    Name:					CTRL+ALT+M - Replaces: <Database_Name, sysname, Database_ToRunIn>
***    Hardcoded:				sp_changedbowner 'sa'
***********************************************************************************/

USE [<Database_Name, sysname, DatabaseToRunIn>] ;
GO
IF EXISTS (SELECT
                1
            FROM
                sys.triggers t
            WHERE
                t.[object_id] = OBJECT_ID(N'[<Schema_Name, sysname, Schema_Name>].[<Trigger_Name, sysname, Trigger_Name>]'))
    DROP TRIGGER [<Schema_Name, sysname, Schema_Name>].[<Trigger_Name, sysname, Trigger_Name>] ;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [<Schema_Name, sysname, Schema_Name>].[<Trigger_Name, sysname, Trigger_Name>] 
   ON  [<Schema_Name, sysname, Schema_Name>].[<Table_Name, sysname, Table_Name>] 
   AFTER <Data_Modification_Statements, , INSERT,DELETE,UPDATE>
AS 

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here

END
GO
