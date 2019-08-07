CREATE FUNCTION dbo.GetDurHotDeck()
RETURNS decimal (18,4)
AS BEGIN
RETURN (SELECT TOP 1 Duration
FROM CapitalBikeShare
TABLESAMPLE (1000 rows)
WHERE Duration >0)
END
SELECT
StartDate,
"TripDuration" = CASE WHEN Duration > 0 THEN Duration
ELSE dbo.GetDurHotDeck() END
FROM CapitalBikeShare;