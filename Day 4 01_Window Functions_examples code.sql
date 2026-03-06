USE Northwind

-- rank within a category, by unit price
SELECT CategoryID, ProductID, UnitPrice, 
	RANK() OVER(PARTITION BY CategoryID ORDER BY CategoryID, UnitPrice) AS NumRank 
FROM Products

-- dense rank within a category, by unit price
SELECT CategoryID, ProductID, UnitPrice, 
	DENSE_RANK() OVER(PARTITION BY CategoryID ORDER BY CategoryID, UnitPrice) AS NumRank 
FROM Products

-- row number across the whole table
SELECT ROW_NUMBER() OVER(ORDER BY CategoryID, ProductID) AS NumRow, CategoryID, ProductID, UnitPrice
FROM Products

-- row number within the partitions
SELECT ROW_NUMBER() OVER(PARTITION BY CategoryID ORDER BY CategoryID, ProductID) AS NumRow, 
	CategoryID, ProductID, UnitPrice
FROM Products

-- dividing the products within each category in groups
SELECT CategoryID, ProductID, UnitPrice, 
	NTILE(3) OVER(PARTITION BY CategoryID ORDER BY CategoryID, UnitPrice) AS Bucket 
FROM Products

-- positional

-- LAG - value in row before
SELECT CategoryID, ProductID, ProductName, UnitPrice,
	LAG(ProductID) OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS PrevProd FROM Products

-- LAG - value 3 rows before
SELECT CategoryID, ProductID, ProductName, UnitPrice,
	LAG(ProductID,3) OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS PrevProd FROM Products

-- LEAD - value in row after
SELECT CategoryID, ProductID, ProductName, UnitPrice,
	LEAD(ProductID) OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS NextProd FROM Products

-- LEAD - value 3 rows after
SELECT CategoryID, ProductID, ProductName, UnitPrice,
	LEAD(ProductID,3) OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS NextProd FROM Products

-- first value
SELECT CategoryID, ProductID, ProductName, UnitPrice,
	FIRST_VALUE(ProductID) OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS FirstProd FROM Products

-- last value
SELECT CategoryID, ProductID, ProductName, UnitPrice,
	LAST_VALUE(ProductID) OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) AS FirstProd FROM Products

-- percentiles
SELECT DISTINCT
	AVG(UnitPrice) OVER() AS Mean,
	PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY UnitPrice ASC) OVER() AS Percentile_25,
	PERCENTILE_CONT(0.5)  WITHIN GROUP(ORDER BY UnitPrice ASC) OVER() AS Median,
	PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY UnitPrice ASC) OVER() AS Percentile_75,
	PERCENTILE_DISC(0.5)  WITHIN GROUP(ORDER BY UnitPrice ASC) OVER() AS NextLowestToMedian
FROM Products


