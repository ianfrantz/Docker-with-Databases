DECLARE 
	@Val1 INT,
	@Val2 INT,
	@Val3 INT

SET @Val1 = 1
SET @Val3 = 0


WHILE @Val3 <= 3
BEGIN
PRINT 'First Loop Execution'
	WHILE @Val1 <= 4
	BEGIN
	SET @Val2 = 1
	PRINT 'Loop2 OPEN'
			WHILE @Val2 <= 10
			BEGIN
			PRINT CONVERT(VARCHAR, @Val1) + ' * ' + CONVERT(VARCHAR, @Val2) + ' = ' + CONVERT(VARCHAR, @Val1 * @Val2)
			SET @Val2 = @Val2 + 1
			END
	PRINT 'Loop2 CLOSE'
	SET @Val1 = @Val1 + 1
	SET @Val3 = @Val3 + 1
	END
IF @Val3 = 0
BREAK
ELSE
PRINT 'FINAL EXECUTION'
END