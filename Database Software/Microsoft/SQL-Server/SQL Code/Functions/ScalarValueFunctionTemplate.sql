-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
USE <Database_Name, sysname, Database_Name> ;
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Drop function if it already exists
IF EXISTS (SELECT 
                1 
           FROM 
                sys.objects
            WHERE
                object_id = OBJECT_ID(N'[<Schema_Name, sysname, dbo>].[<Scalar_Function_Name, sysname, FunctionName>]')
                AND type in (N'FN', N'IF', N'TF', N'FS', N'FT') ) 
    DROP FUNCTION [<Schema_Name, sysname, dbo>].[<Scalar_Function_Name, sysname, FunctionName>]
GO

CREATE FUNCTION <Schema_Name, sysname, dbo>.<Scalar_Function_Name, sysname, FunctionName> 
(
	-- Add the parameters for the function here
	<@Param1, sysname, @p1> <Data_Type_For_Param1, , int>
)
RETURNS <Function_Data_Type, ,int>
WITH SCHEMABINDING
AS
/*
***************************** Prolog ******************************
***
***    Database:        <Database_Name, sysname, Database_Name>
***    Schema:          <Schema_Name, sysname, dbo>
***    Object type:     FUNCTION
***    Object name:     <Scalar_Function_Name, sysname, FunctionName>
***    Version:         <Version, VARCHAR(16), 1>
***    Source Location: <Source_Location, VARCHAR(256), Not yet in Subversion>
***     
***    Purpose:        Enter a description to for the function.
***
***        INPUT Parameters: 
***             <@Param1, sysname, @p1> <Data_Type_For_Param1, , int>
***
***        Return Value: <Function_Data_Type, ,int>
***
*** =============================================
*** Example to execute the stored procedure
*** =============================================
    SELECT <Schema_Name, sysname, dbo>.<Scalar_Function_Name, sysname, FunctionName> (<@Param1, sysname, @p1>) ;
***
************************* Change History **************************
***    Copyright@2007  Genesis Financial Solutions
***
*** Date            Name        Description
*** <Creation_Date, DATETIME, mm/dd/yyyy>    <Author_Name, sysname, First Initial & Last Name>     Created
***
*******************************************************************
*/
BEGIN
	-- Declare the return variable here
	DECLARE <@ResultVar, sysname, @Result> <Function_Data_Type, ,int>

	-- Add the T-SQL statements to compute the return value here
	SELECT <@ResultVar, sysname, @Result> = <@Param1, sysname, @p1>

	-- Return the result of the function
	RETURN <@ResultVar, sysname, @Result>

END
GO

