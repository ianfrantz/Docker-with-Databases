USE [HappyScoopers_DW]
GO

-- Drop the table if it is already present in the database
DROP TABLE IF EXISTS [int].[Lineage]

-- Create the Lineage table
CREATE TABLE [int].[Lineage]
(
	[LineageKey]		[int] IDENTITY(1,1) NOT NULL,
	[TableName]			[nvarchar](200) NOT NULL,
	[StartLoad]			[datetime]	NOT NULL,
	[FinishLoad]		[datetime]	NULL,
	[LastLoadedDate]	[datetime] NOT NULL,
	[Type]				[nvarchar](1) NOT NULL,
	[Status]			[nvarchar](1) NOT NULL,
 CONSTRAINT [PK_Integration_Lineage] PRIMARY KEY CLUSTERED ([LineageKey] ASC)
) ON [PRIMARY]
GO

-- Add default values for the Type and Status columns
ALTER TABLE [int].[Lineage] ADD  CONSTRAINT [DF_Lineage_Type]  DEFAULT (N'F') FOR [Type]
ALTER TABLE [int].[Lineage] ADD  CONSTRAINT [DF_Lineage_Status]  DEFAULT (N'P') FOR [Status]

GO


