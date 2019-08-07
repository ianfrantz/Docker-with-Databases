/****************************** Prologue *******************************************
***
***    Purpose:					Creates a database from a flatfile
***    Object type:				Database
***    Name:					CTRL+ALT+M 
***********************************************************************************/
GO

IF object_id(N'<schema_name, sysname, dbo>.<view_name, sysname, View_Name>', 'V') IS NOT NULL
	DROP VIEW <schema_name, sysname, dbo>.<view_name, sysname, View_Name>
GO

CREATE VIEW <schema_name, sysname, dbo>.<view_name, sysname, View_Name>
WITH SCHEMABINDING
    ,VIEW_METADATA
AS

-- Create your SQL Query here

GO

