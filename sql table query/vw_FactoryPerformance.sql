USE Manufacturing_Operational_Data;
GO

CREATE OR ALTER VIEW dbo.vw_FactoryPerformance
AS

WITH base AS (
    SELECT 
        df.FactoryName,
        df.PlantType,
        df.Country,
        df.City,
        df.Region,

        COUNT(fp.FactProductionKey) AS TotalRuns,
        SUM(fp.UnitsProduced) AS UnitsProduced,
        SUM(fp.UnitsGood) AS UnitsGood,
        SUM(fp.UnitsScrap) AS UnitsScrap,
        SUM(fp.ProductionHours) AS ProductionHours,
        SUM(fp.DowntimeHours) AS DowntimeHours,
        SUM(fp.StandardCost) AS StandardCost,
        SUM(fp.ActualCost) AS ActualCost
    FROM FactProduction fp
    JOIN DimFactory df 
        ON fp.FactoryKey = df.FactoryKey
    GROUP BY 
        df.FactoryName,
        df.PlantType,
        df.Country,
        df.City,
        df.Region
),

kpi AS (
    SELECT *,
        -- Rates
        CAST(UnitsGood * 100.0 / NULLIF(UnitsProduced, 0) AS DECIMAL(10,2)) AS YieldRate_pct,
        CAST(UnitsScrap * 100.0 / NULLIF(UnitsProduced, 0) AS DECIMAL(10,2)) AS ScrapRate_pct,
        CAST(DowntimeHours * 100.0 / NULLIF(ProductionHours, 0) AS DECIMAL(10,2)) AS DowntimeRate_pct,

        -- Efficiency
        CAST((ProductionHours - DowntimeHours) * 100.0 / NULLIF(ProductionHours, 0) AS DECIMAL(10,2)) AS ProductionEfficiencyRate,

        -- Cost Metrics
        (ActualCost - StandardCost) AS CostVariance,
        CAST((ActualCost - StandardCost) * 100.0 / NULLIF(StandardCost, 0) AS DECIMAL(10,2)) AS CostVariancePct,
        CAST(ActualCost * 100.0 / NULLIF(UnitsGood, 0) AS DECIMAL(10,2)) AS CostPerGoodUnit,

        -- OEE (Availability × Quality)
        CAST(
            ((ProductionHours - DowntimeHours) * 100.0 / NULLIF(ProductionHours, 0)) *
            (UnitsGood * 100.0 / NULLIF(UnitsProduced, 0)) / 100
        AS DECIMAL(10,2)) AS OEE_Score

    FROM base
)

SELECT 
    *,

    -- Rankings
    RANK() OVER(ORDER BY YieldRate_pct DESC) AS Yield_Rank,
    RANK() OVER(ORDER BY DowntimeRate_pct ASC) AS Downtime_Rank,
    RANK() OVER(ORDER BY CostPerGoodUnit ASC) AS CostEfficiencyRank,

    -- Downtime Status
    CASE 
        WHEN DowntimeRate_pct <= 5 THEN 'Excellent'
        WHEN DowntimeRate_pct <= 10 THEN 'Good'
        WHEN DowntimeRate_pct <= 15 THEN 'Average'
        ELSE 'Critical'
    END AS DowntimeStatus,

    -- Budget Status
    CASE
        WHEN ActualCost <= StandardCost THEN 'Under Budget'
        WHEN CostVariancePct <= 5 THEN 'Within Tolerance'
        WHEN CostVariancePct <= 10 THEN 'Over Budget'
        ELSE 'Critical Overrun'
    END AS BudgetStatus

FROM kpi;
GO