-- Declaration of the variables needed in this script
DECLARE @LoadType nvarchar(1) = 'I'
DECLARE @TableName nvarchar(100) = 'Dim_Product';
DECLARE @Prev_LastLoadedDate datetime;
DECLARE @LastLoadedDate datetime;
DECLARE @LineageKey int;

DECLARE @lineage TABLE (lineage int)
DECLARE @lastload TABLE (load_date datetime)

--STEP 1: Set into the @LastLoadedDate the date which will be used to retrieve elements from the source tables
SELECT @LastLoadedDate = GETDATE()

--STEP 2: Insert a new row into the lineage table, to keep track of the new Dim_Product load that just started
--STEP 3: Store the key of the new row in the @LineageKey variable, for future usage
INSERT INTO @lineage EXEC [int].[Get_LineageKey] @LoadType, @TableName, @LastLoadedDate
SELECT TOP 1 @LineageKey = lineage FROM @lineage

--STEP 4: Make sure that the Staging_Product table is empty before loading new information in it
TRUNCATE TABLE Staging_Product

--STEP 5: Retrieve the date when Dim_Product was last loaded
--STEP 6: Store this date into the @Prev_LastLoadedDate variable
INSERT INTO @lastload EXEC [int].[Get_LastLoadedDate] @TableName
SELECT TOP 1 @Prev_LastLoadedDate = load_date FROM @lastload
SELECT @Prev_LastLoadedDate AS [Date of the previous load]

SELECT * 
FROM [HappyScoopers_Demo].[dbo]. Products prod
LEFT JOIN [HappyScoopers_Demo].[dbo].[ProductSubcategories] subcat ON prod.SubcategoryID = subcat.ProductSubcategoryID
LEFT JOIN [HappyScoopers_Demo].[dbo].[ProductCategories] cat ON subcat.ProductCategoryID = cat.CategoryID
LEFT JOIN [HappyScoopers_Demo].[dbo].[ProductDepartments] dep ON cat.DepartmentID = dep.DepartmentID
LEFT JOIN [HappyScoopers_Demo].[dbo].[UnitsOfMeasure] um ON prod.UnitOfMeasureID = um.UnitOfMeasureID
WHERE prod.ModifiedDate > @Prev_LastLoadedDate AND prod.ModifiedDate <= @LastLoadedDate


--STEP 7: Insert into the staging table new products or products that were modified after the last Dim_Product load finished 
INSERT INTO [dbo].[Staging_Product]
	EXEC [HappyScoopers_Demo].[dbo].[Load_StagingProduct] @Prev_LastLoadedDate, @LastLoadedDate

-- Take a look what the staging table contains 
SELECT * FROM Staging_Product

--STEP 8: Transfer information from the staging table to the actual dimension table: Dim_Product
EXEC [dbo].[Load_DimProduct]

-- Take a look what Dim_Product contains
SELECT * FROM Dim_Product