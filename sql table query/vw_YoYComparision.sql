CREATE OR ALTER VIEW dbo.vw_YoYComparison AS

WITH YearlyKPIs AS (
    SELECT
        d.YearNumber,
        fa.FactoryName,

        SUM(f.UnitsProduced) AS TotalUnitsProduced,
        SUM(f.UnitsGood)     AS TotalUnitsGood,
        SUM(f.UnitsScrap)    AS TotalUnitsScrap,

        CAST(SUM(f.UnitsGood) * 100.0
             / NULLIF(SUM(f.UnitsProduced), 0) AS DECIMAL(10,2)) AS YieldRate_Pct,

        CAST(SUM(f.UnitsScrap) * 100.0
             / NULLIF(SUM(f.UnitsProduced), 0) AS DECIMAL(10,2)) AS ScrapRate_Pct,

        CAST(SUM(f.DowntimeHours) * 100.0
             / NULLIF(SUM(f.ProductionHours), 0) AS DECIMAL(10,2)) AS DowntimeRate_Pct,

        SUM(f.ActualCost)   AS TotalActualCost,
        SUM(f.StandardCost) AS TotalStandardCost,

        SUM(f.ActualCost) - SUM(f.StandardCost) AS CostVariance

    FROM dbo.FactProduction f
    JOIN dbo.DimDate d 
        ON f.DateKey = d.DateKey
    JOIN dbo.DimFactory fa 
        ON f.FactoryKey = fa.FactoryKey

    GROUP BY 
        d.YearNumber, 
        fa.FactoryName
),

YoY AS (
    SELECT *,
        -- Previous Year Values using LAG()
        LAG(TotalUnitsGood) OVER(PARTITION BY FactoryName ORDER BY YearNumber) AS Prev_UnitsGood,
        LAG(YieldRate_Pct) OVER(PARTITION BY FactoryName ORDER BY YearNumber) AS Prev_YieldRate,
        LAG(ScrapRate_Pct) OVER(PARTITION BY FactoryName ORDER BY YearNumber) AS Prev_ScrapRate,
        LAG(DowntimeRate_Pct) OVER(PARTITION BY FactoryName ORDER BY YearNumber) AS Prev_DowntimeRate,
        LAG(TotalActualCost) OVER(PARTITION BY FactoryName ORDER BY YearNumber) AS Prev_ActualCost
    FROM YearlyKPIs
)

SELECT
    YearNumber,
    FactoryName,
    TotalUnitsProduced,
    TotalUnitsGood,
    YieldRate_Pct,
    ScrapRate_Pct,
    DowntimeRate_Pct,
    TotalActualCost,
    CostVariance,

    -- YoY Calculations
    CAST((TotalUnitsGood - Prev_UnitsGood) * 100.0
         / NULLIF(Prev_UnitsGood, 0) AS DECIMAL(10,2)) AS YoY_UnitsGood_Pct,

    CAST(YieldRate_Pct - Prev_YieldRate AS DECIMAL(10,2)) AS YoY_YieldRate_Change,
    CAST(ScrapRate_Pct - Prev_ScrapRate AS DECIMAL(10,2)) AS YoY_ScrapRate_Change,
    CAST(DowntimeRate_Pct - Prev_DowntimeRate AS DECIMAL(10,2)) AS YoY_Downtime_Change,

    CAST((TotalActualCost - Prev_ActualCost) * 100.0
         / NULLIF(Prev_ActualCost, 0) AS DECIMAL(10,2)) AS YoY_Cost_Pct,

    -- Trend Indicators (Improved)
    CASE 
        WHEN Prev_YieldRate IS NULL THEN 'No Data'
        WHEN YieldRate_Pct > Prev_YieldRate THEN 'Improving'
        WHEN YieldRate_Pct = Prev_YieldRate THEN 'Stable'
        ELSE 'Declining'
    END AS YieldTrend,

    CASE 
        WHEN Prev_ScrapRate IS NULL THEN 'No Data'
        WHEN ScrapRate_Pct < Prev_ScrapRate THEN 'Improving'
        WHEN ScrapRate_Pct = Prev_ScrapRate THEN 'Stable'
        ELSE 'Declining'
    END AS ScrapTrend,

    CASE 
        WHEN Prev_DowntimeRate IS NULL THEN 'No Data'
        WHEN DowntimeRate_Pct < Prev_DowntimeRate THEN 'Improving'
        WHEN DowntimeRate_Pct = Prev_DowntimeRate THEN 'Stable'
        ELSE 'Declining'
    END AS DowntimeTrend

FROM YoY

SELECT * FROM vw_YoYComparison