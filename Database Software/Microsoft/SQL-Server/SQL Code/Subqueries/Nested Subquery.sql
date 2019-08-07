--This query sums the total number of ani matching calls per day and segments by LOB
SELECT CallDate, LOB, SUM(Ani_Match)
FROM 
	--Second nested subquery 'ANI_Query' measures ani matching with 1 = yes 0 = no
	(
	SELECT 
	CASE WHEN CustomerSystemId in ('1') THEN 1
	ELSE 0
	END AS Ani_Match
	, CallDate
	, LOB
	FROM 
		--First nested subquery 'LOB_Query' creates LOB segmentation based off GLSAccountType designations
		(
		SELECT 
		CASE WHEN GLSAccountType in ('SJ') THEN 'Signet'
		ELSE 'Unknown LOB'
		END AS LOB
		, CustomerSystemId
		, CallDate
		FROM dbo.NobleIvrLog
		) AS LOB_Query
) AS ANI_Query

WHERE CAST(CallDate AS DATE) BETWEEN  CAST(GETDATE()-14 AS DATE) AND  CAST(GETDATE() AS DATE) 
GROUP BY CallDate, LOB
ORDER BY CallDate ASC, LOB