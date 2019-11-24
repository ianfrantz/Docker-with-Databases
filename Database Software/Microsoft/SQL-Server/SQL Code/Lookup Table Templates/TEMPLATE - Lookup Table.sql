/****************************** Prologue *******************************************
*****
*****    Purpose:	Template for creating a look up table(LUT).
*****    Activation:	CTRL+SHIFT+M		
***********************************************************************************/

/**Createa a LUT**/
USE [<DatabaseName, VARCHAR, NULL>]

---Code chunk that will remove all constraints except the PK---
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>_IsActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] DROP CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_IsActive]
END

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>_CreateDateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] DROP CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_CreateDateTime]
END

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>_ModifiedDateTime]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] DROP CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_ModifiedDateTime]
END

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>_User]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] DROP CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_User]
END

--SQL to create unique columns for '<LUTName, VARCHAR, NULL>'
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].<LUTName, VARCHAR, NULL>') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[<LUTName, VARCHAR, NULL>](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateDateTime] [datetime] NOT NULL,
	[ModifiedDateTime] [datetime] NOT NULL,
	[User] VARCHAR(50) NOT NULL,
--Start adding your unique lookup columns here.
	ZoneId TINYINT NOT NULL,
	Territory VARCHAR(255) NULL,
	Rep VARCHAR(255) NULL


 CONSTRAINT [PK_ID] PRIMARY KEY CLUSTERED 
(
	[ID],
	[ZoneId]
)) ON [PRIMARY]
END
---Code block that creates default constraints---
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] ADD  CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_IsActive]  DEFAULT ((1)) FOR [IsActive]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] ADD  CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_CreateDateTime]  DEFAULT (getdate()) FOR [CreateDateTime]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] ADD  CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_ModifiedDateTime]  DEFAULT (getdate()) FOR [ModifiedDateTime]
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_<LUTName, VARCHAR, NULL>]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[<LUTName, VARCHAR, NULL>] ADD  CONSTRAINT [DF_<LUTName, VARCHAR, NULL>_User]  DEFAULT (CURRENT_USER) FOR [User]
END

---Create @YourBusinessZones table with basic info---
DECLARE @SalesZones TABLE
(
	ZoneId INT NOT NULL
)
INSERT INTO @SalesZones(ZoneId)
VALUES(1), (2), (3), (4)


--SQL to Populate LUT: '<LUTName, VARCHAR, NULL>'
INSERT INTO <LUTName, VARCHAR, NULL>(ZoneId, Territory, Rep)
	SELECT 
	ZoneId,
CASE 
	WHEN ZoneId = 1 THEN 'North'
	WHEN ZoneId = 2 THEN 'South'
    WHEN ZoneId = 3 THEN 'East'
    WHEN ZoneId = 4 THEN 'West'
	ELSE 'Other'
    END AS 'Territory',
CASE
    WHEN ZoneId IN ('1','2') THEN 'Plato'
	WHEN ZoneId IN ('3','4') THEN 'Aristotle'
	ELSE 'Other'
    END AS 'Rep'

FROM @SalesZones


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[<LUTName, VARCHAR, NULL>]') AND type = 'U')
		BEGIN
		PRINT 'Created dbo.<LUTName, VARCHAR, NULL> on ' + @@SERVERNAME
		END
	ELSE 
		BEGIN
		PRINT 'Failed to create dbo.<LUTName, VARCHAR, NULL> on ' + @@SERVERNAME
		END