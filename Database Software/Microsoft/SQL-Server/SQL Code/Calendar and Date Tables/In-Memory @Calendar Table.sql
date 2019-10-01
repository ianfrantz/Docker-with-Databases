--This code is an example of how an in-memory @Calendar table can be created to outer join other tables on later.
DECLARE @Today DATE = GETDATE()
DECLARE @Daysback INT = 500 --Here to refresh data that is N days old.
DECLARE @StartDate AS DATE = DATEADD(dd, -@Daysback, @Today) --Set a start date based on @Daysback variable.

--Create an in-memory @Calendar table.
--This is useful to outer join on later when not all other tables have the same number of days.
DECLARE @Calendar TABLE
(
	DateValue DATE NOT NULL
)

WHILE (@StartDate <= @Today) 
BEGIN
	INSERT INTO @Calendar 
	VALUES (@StartDate)
	SET @StartDate = DATEADD(DAY, 1, @StartDate)
END

--Select and parse dates from @Calendar
SELECT 
*,
DATEPART(m, DateValue) AS Month,
DATENAME(m, DateValue) AS MonthName,
DATEPART(d, DateValue) AS Day,
DATENAME(dw, DateValue) AS DayName,
DATEPART(yy, DateValue) AS Year, 
DATEADD(dd, - DATEPART(dw, DateValue)-1, DateValue) AS Week_Start,
DATEADD(dd, 7- DATEPART(dw, DateValue), DateValue) AS Week_End

FROM @Calendar AS CalendarLUT
--Example of how you can later join various dates from a table to the in-memory @Calendar table.
--LEFT JOIN [dbo].[table] ON sporadic_date = CalendarLUT.DateValue