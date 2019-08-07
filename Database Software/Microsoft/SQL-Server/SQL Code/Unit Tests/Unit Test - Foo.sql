--Stample Unit Testing of foo function

DECLARE @bar AS INT = 1
SELECT dbo.foo(@bar)

SELECT
	-- Select the first 100 records of PickupDate
	TOP 100 PickupDate,
    -- Determine the shift value of PickupDate
	dbo.GetShiftNumber(DATEPART(hour, PickupDate)) AS 'Shift',
    -- Select FareAmount
	FareAmount,
    -- Convert FareAmount to Euro
	dbo.ConvertDollar(FareAmount, 0.87) AS 'FareinEuro',
    -- Select TripDistance
	TripDistance,
    -- Convert TripDistance to kilometers
	dbo.ConvertMileToKm(TripDistance) AS 'TripDistanceinKM'
FROM YellowTripData
-- Only include records for the 2nd shift
WHERE dbo.GetShiftNumber(DATEPART(hour, PickupDate)) = 2;