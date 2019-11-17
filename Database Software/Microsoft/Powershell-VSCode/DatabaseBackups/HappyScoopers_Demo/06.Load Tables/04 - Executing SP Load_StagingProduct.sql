USE [HappyScoopers_Demo]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[Load_StagingProduct]
		@LastLoadDate = N'2019-05-18',
		@NewLoadDate = N'2019-06-01'

SELECT	'Return Value' = @return_value

GO
