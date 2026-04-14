-- Scrap and quality View
CREATE OR ALTER VIEW vw_QualityScrap AS 
	WITH base AS (
    SELECT 
        dd.YearNumber,
        dd.MonthNumber,
        dd.MonthName,
        df.FactoryName,
        df.PlantType,
        dp.ProductName,
        dp.CategoryName,
        dp.BusinessDivisionName,

        SUM(fp.UnitsProduced) AS UnitsProduced,
        SUM(fp.UnitsGood) AS UnitsGood,
        SUM(fp.UnitsScrap) AS UnitsScrap,
        SUM(fp.ActualCost) AS ActualCost
    FROM FactProduction fp 
    JOIN DimDate dd ON fp.DateKey = dd.DateKey
    JOIN DimFactory df ON fp.FactoryKey = df.FactoryKey
    JOIN DimProduct dp ON fp.ProductKey = dp.ProductKey
    GROUP BY  
        dd.YearNumber,
        dd.MonthNumber,
        dd.MonthName,
        df.FactoryName,
        df.PlantType,
        dp.ProductName,
        dp.CategoryName,
        dp.BusinessDivisionName
),

kpi AS (
    SELECT *,
        CAST(UnitsGood * 100.0 / NULLIF(UnitsProduced, 0) AS DECIMAL(10,2)) AS Yield_Rate,
        CAST(UnitsScrap * 100.0 / NULLIF(UnitsProduced, 0) AS DECIMAL(10,2)) AS Scrap_Rate,

        CAST(
            (ActualCost / NULLIF(UnitsProduced, 0)) * UnitsScrap
        AS DECIMAL(18,2)) AS ScrapCostImpact
    FROM base
)

SELECT *,
    CASE
        WHEN Scrap_Rate <= 3 THEN 'Excellent'
        WHEN Scrap_Rate <= 7 THEN 'Good'
        WHEN Scrap_Rate <= 12 THEN 'Average'
        ELSE 'Poor'
    END AS ScrapStatus
FROM kpi;


SELECT * FROM vw_QualityScrap