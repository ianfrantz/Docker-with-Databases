/****************************** Prologue *******************************************
***
***    Purpose:					
***    Object type:				
***    Name:					
***    Hardcoded:				
***********************************************************************************/

DECLARE @Frequency INT;
DECLARE @Label CHAR(10);
DECLARE @Counter INT;
DECLARE @RunCount INT;

SET @Counter = (SELECT COUNT(DISTINCT categorical) FROM sometable);
SET @RunCount = 0;

DECLARE FrequencyCountCursor CURSOR FOR 
	SELECT COUNT(*) 
	FROM [Pool1].dbo.[2767CD30-B43B-4DA8-8B11-69087857A59F];

OPEN FrequencyCountCursor;

WHILE @RunCount < @Counter
BEGIN
	FETCH NEXT FROM FrequencyCountCursor INTO @Frequency, @Label;
	PRINT 'Test1'
	SET @RunCount = @RunCount + 1
END;

CLOSE FrequencyCountCursor;
DEALLOCATE FrequencyCountCursor;