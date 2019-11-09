USE [HappyScoopers_DW]
GO

-- Delete the table if it's already present in the database
DROP TABLE IF EXISTS [int].[IncrementalLoads]

-- Create the table, without populating it with anything
CREATE TABLE [int].[IncrementalLoads](
	[LoadDateKey] [int] IDENTITY(1,1) NOT NULL,
	[TableName] [nvarchar](100) NOT NULL,
	[LoadDate] [datetime] NOT NULL,
 CONSTRAINT [PK_LoadDates] PRIMARY KEY CLUSTERED  ([LoadDateKey] ASC)
) ON [PRIMARY]


GO


