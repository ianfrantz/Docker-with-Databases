CREATE VIEW [vCalendarTable]
	WITH SCHEMABINDING
	AS
	SELECT 
	[Date], 
	[Day], 
	[Day Suffix], 
	[Day Of Year],
	[Weekday], 
	[Weekday Name],
	[Weekday Name Short], 
	[Weekday Name FirstLetter],  
	[Is Weekend],
	[Is Holiday],
	[Holiday Name],
	[Special Day],
	[Week Of Month],
	[Week Of Year],
	[First Date Of Week],
	[Last Date Of Week],
	[Month],
	[Month Name],
	[Month Name Short],
	[Month Name FirstLetter],
	[First Date Of Month],
	[Last Date Of Month],
	[Year],
	[MMYYYY],
	[Month Year],
	[First Date Of Year],
	[Last Date Of Year],
	[Quarter],
	[Quarter Name],
	[First Date Of Quater],
	[Last Date Of Quater],
	[Day of Quarter],
	[Day of Week in Quarter]

	FROM [dbo].[CalendarTable]
GO

CREATE UNIQUE CLUSTERED INDEX IDX_Date
	ON [vCalendarTable] ([Date]);
GO