CREATE OR ALTER VIEW dbo.vw_ExecutiveSummary AS
SELECT
    dd.YearNumber,
    dd.QuarterNumber,
    CONCAT('Q', dd.QuarterNumber)               AS QuarterName,

    -- Volume KPIs
    SUM(fp.UnitsProduced)                        AS TotalUnitsProduced,
    SUM(fp.UnitsGood)                            AS TotalGoodUnits,
    SUM(fp.UnitsScrap)                           AS TotalScrapUnits,

    -- Quality KPIs
    CAST(SUM(fp.UnitsGood) * 100.0
         / NULLIF(SUM(fp.UnitsProduced),0)
         AS DECIMAL(10,2))                       AS YieldPct,

    CAST(SUM(fp.UnitsScrap) * 100.0
         / NULLIF(SUM(fp.UnitsProduced),0)
         AS DECIMAL(10,2))                       AS ScrapPct,

    -- Time KPIs
    SUM(fp.ProductionHours)                      AS TotalProductionHours,
    SUM(fp.DowntimeHours)                        AS TotalDowntimeHours,
    SUM(fp.ProductionHours)
        - SUM(fp.DowntimeHours)                  AS TotalEffectiveHours,

    CAST((SUM(fp.ProductionHours)
         - SUM(fp.DowntimeHours)) * 100.0
         / NULLIF(SUM(fp.ProductionHours),0)
         AS DECIMAL(10,2))                       AS EfficiencyPct,

    CAST(SUM(fp.DowntimeHours) * 100.0
         / NULLIF(SUM(fp.ProductionHours),0)
         AS DECIMAL(10,2))                       AS DowntimePct,

    -- Cost KPIs
    SUM(fp.ActualCost)                           AS TotalActualCost,
    SUM(fp.StandardCost)                         AS TotalStandardCost,
    SUM(fp.ActualCost)
        - SUM(fp.StandardCost)                   AS TotalCostVariance,

    CAST((SUM(fp.ActualCost)
         - SUM(fp.StandardCost)) * 100.0
         / NULLIF(SUM(fp.StandardCost),0)
         AS DECIMAL(10,2))                       AS CostVariancePct,

    -- Throughput KPIs
    CAST(SUM(fp.UnitsProduced) * 100.0
         / NULLIF(SUM(fp.ProductionHours),0)
         AS DECIMAL(10,2))                       AS TotalUnitsPerHour,

    CAST(SUM(fp.UnitsGood) * 100.0
         / NULLIF(SUM(fp.ProductionHours),0)
         AS DECIMAL(10,2))                       AS GoodUnitsPerHour,

    -- Good Unit Yield Rate (corrected)
    CAST(SUM(fp.UnitsGood) * 100.0
         / NULLIF(SUM(fp.UnitsProduced),0)
         AS DECIMAL(10,2))                       AS PctGoodUnitPerHour

FROM dbo.FactProduction fp
JOIN dbo.DimDate dd ON fp.DateKey = dd.DateKey
GROUP BY
    dd.YearNumber,
    dd.QuarterNumber;
GO

SELECT *
FROM dbo.vw_ExecutiveSummary
ORDER BY YearNumber, QuarterNumber;