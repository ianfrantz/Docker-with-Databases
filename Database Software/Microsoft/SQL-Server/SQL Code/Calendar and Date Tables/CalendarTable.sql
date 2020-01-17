--Creates a CalendarTable with some containts defined in the table load.
CREATE TABLE [dbo].[CalendarTable]
(
	[Date Key] INT NOT NULL,
	[Date] [date] NOT NULL,
	[Day] [tinyint] NOT NULL,
	[Day Suffix] [char](2) NOT NULL,
	[Day Of Year] [smallint] NOT NULL,

	[Weekday] [tinyint] NOT NULL,
	[First Date Of Week] [date] NULL,
	[Last Date Of Week] [date] NULL,
	[Weekday Name] [varchar](10) NOT NULL,
	[Weekday Name Short] [char](3) NOT NULL,
	[Weekday Name FirstLetter] [char](1) NOT NULL,
	[Is Weekend] [bit] NOT NULL
	CONSTRAINT DF_IsWeekend DEFAULT ((0)),
	[Is Holiday] [bit] NOT NULL
	CONSTRAINT DF_IsHoliday DEFAULT ((0)),
	[Holiday Name] [varchar](20) NOT NULL
	CONSTRAINT DF_HolidayName DEFAULT (''),
	[Special Day] [varchar](20) NOT NULL,
	[Week Of Month] [tinyint] NOT NULL,
	[Week Of Year] [tinyint] NOT NULL,

	[Month] [tinyint] NOT NULL,
	[Month Name] [varchar](10) NOT NULL,
	[Month Name Short] [char](3) NOT NULL,
	[Month Name FirstLetter] [char](1) NOT NULL,
	[First Date Of Month] [date] NOT NULL,
	[Last Date Of Month] [date] NOT NULL,

	[Year] [int] NOT NULL,
	[MMYYYY] [char](6) NOT NULL,
	[Month Year] [char](7) NOT NULL,
	[First Date Of Year] [date] NULL,
	[Last Date Of Year] [date] NULL,

	[Quarter] [tinyint] NOT NULL,
	[Quarter Name] [varchar](6) NOT NULL,
	[First Date Of Quater] [date] NULL,
	[Last Date Of Quater] [date] NULL,
	[Day of Quarter] [tinyint] NOT NULL,
	[Day of Week in Quarter] [tinyint] NOT NULL,

PRIMARY KEY CLUSTERED ([Date Key] ASC)
) 
GO

-----Table Load-----
DECLARE @StartDate DATE = '2016-01-01'
DECLARE @EndDate DATE = '2030-12-31'
DECLARE @EndOfTime datetime =  '9999-12-31'

WHILE @StartDate <= @EndDate
BEGIN
INSERT INTO [dbo].[CalendarTable] 
(	
[Date Key]
,[Date]
,[Day]
,[Day Suffix]
,[Weekday]
,[Weekday Name]
,[Weekday Name Short]
,[Weekday Name FirstLetter]
,[Day Of Year]
,[Week Of Month]
,[Week Of Year]
,[Month]
,[Month Name]
,[Month Name Short]
,[Month Name FirstLetter]
,[Quarter]
,[Quarter Name]
,[Year]
,[MMYYYY]
,[Month Year]
,[Is Weekend]
,[Is Holiday]
,[Holiday Name]
,[Special Day]
,[First Date Of Year]
,[Last Date Of Year]
,[First Date Of Quater]
,[Last Date Of Quater]
,[First Date Of Month]
,[Last Date Of Month]
,[First Date Of Week]
,[Last Date Of Week]
,[Day of Quarter]
,[Day of Week in Quarter]
)

SELECT 
[Date Key] = YEAR(@StartDate) * 10000 + MONTH(@StartDate) * 100 + DAY(@StartDate),
DATE = @StartDate,
Day = DAY(@StartDate),
[DaySuffix] = CASE 
   WHEN DAY(@StartDate) = 1
      OR DAY(@StartDate) = 21
      OR DAY(@StartDate) = 31
      THEN 'st'
   WHEN DAY(@StartDate) = 2
      OR DAY(@StartDate) = 22
      THEN 'nd'
   WHEN DAY(@StartDate) = 3
      OR DAY(@StartDate) = 23
      THEN 'rd'
   ELSE 'th'
   END,
WEEKDAY = DATEPART(dw, @StartDate),
WeekDayName = DATENAME(dw, @StartDate),
WeekDayName_Short = UPPER(LEFT(DATENAME(dw, @StartDate), 3)),
WeekDayName_FirstLetter = LEFT(DATENAME(dw, @StartDate), 1),
[DayOfYear] = DATENAME(dy, @StartDate),
[WeekOfMonth] = DATEPART(WEEK, @StartDate) - DATEPART(WEEK, DATEADD(MM, DATEDIFF(MM, 0, @StartDate), 0)) + 1,
[WeekOfYear] = DATEPART(wk, @StartDate),
[Month] = MONTH(@StartDate),
[MonthName] = DATENAME(mm, @StartDate),
[MonthName_Short] = UPPER(LEFT(DATENAME(mm, @StartDate), 3)),
[MonthName_FirstLetter] = LEFT(DATENAME(mm, @StartDate), 1),
[Quarter] = DATEPART(q, @StartDate),
[QuarterName] = CASE 
   WHEN DATENAME(qq, @StartDate) = 1
      THEN 'First'
   WHEN DATENAME(qq, @StartDate) = 2
      THEN 'second'
   WHEN DATENAME(qq, @StartDate) = 3
      THEN 'third'
   WHEN DATENAME(qq, @StartDate) = 4
      THEN 'fourth'
   END,
[Year] = YEAR(@StartDate),
[MMYYYY] = RIGHT('0' + CAST(MONTH(@StartDate) AS VARCHAR(2)), 2) + CAST(YEAR(@StartDate) AS VARCHAR(4)),
[MonthYear] = CAST(YEAR(@StartDate) AS VARCHAR(4)) + UPPER(LEFT(DATENAME(mm, @StartDate), 3)),
[IsWeekend] = CASE 
   WHEN DATENAME(dw, @StartDate) = 'Sunday'
      OR DATENAME(dw, @StartDate) = 'Saturday'
      THEN 1
   ELSE 0
   END,
[IsHoliday] = 0,
[HolidayName] =	CONVERT(varchar(20), ''),
[SpecialDays] =	CONVERT(varchar(20), ''),
[FirstDateofYear]   = CAST(CAST(YEAR(@StartDate) AS VARCHAR(4)) + '-01-01' AS DATE),
[LastDateofYear]    = CAST(CAST(YEAR(@StartDate) AS VARCHAR(4)) + '-12-31' AS DATE),
[FirstDateofQuater] = DATEADD(qq, DATEDIFF(qq, 0, @StartDate), 0),
[LastDateofQuater]  = DATEADD(dd, - 1, DATEADD(qq, DATEDIFF(qq, 0, @StartDate) + 1, 0)),
[FirstDateofMonth]  = CAST(CAST(YEAR(@StartDate) AS VARCHAR(4)) + '-' + CAST(MONTH(@StartDate) AS VARCHAR(2)) + '-01' AS DATE),
[LastDateofMonth]   = EOMONTH(@StartDate),
[FirstDateofWeek]   = DATEADD(dd, - (DATEPART(dw, @StartDate) - 1), @StartDate),
[LastDateofWeek] = DATEADD(dd, 7 - (DATEPART(dw, @StartDate)), @StartDate),
[Dayo	fQuater] =  DATEDIFF(DAY, DATEADD(QUARTER, DATEDIFF(QUARTER, 0 , @StartDate), 0), @StartDate) + 1,
[DayofWeekinQuater] = DATEDIFF(DAY, DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @StartDate), 0), @StartDate)/7 + 1

SET @StartDate = DATEADD(DD, 1, @StartDate)
END
GO

--Set Special Days
UPDATE CalendarTable
SET [Special Day] = 'Valentines Day'
WHERE [Month] = 2
   AND [Day] = 14

--Set Holidays
UPDATE CalendarTable
SET [Is Holiday] = 1,
   [Holiday Name] = 'Christmas'
WHERE [Month] = 12
   AND [Day] = 25