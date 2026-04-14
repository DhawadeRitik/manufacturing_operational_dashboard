CREATE OR ALTER VIEW dbo.vw_RegionalChannel AS
SELECT
    r.Region,
    r.Country,
    ch.ChannelName,
    d.YearNumber,
    d.MonthNumber,
    d.MonthName,

    COUNT(f.FactProductionKey)                                  AS TotalRuns,
    SUM(f.UnitsProduced)                                        AS TotalUnitsProduced,
    SUM(f.UnitsGood)                                            AS TotalUnitsGood,
    SUM(f.UnitsScrap)                                           AS TotalUnitsScrap,

    CAST(SUM(f.UnitsGood) * 100.0
         / NULLIF(SUM(f.UnitsProduced), 0) AS DECIMAL(10,2))    AS YieldRate_Pct,

    SUM(f.ActualCost)                                           AS TotalActualCost,
    CAST(SUM(f.ActualCost)
         / NULLIF(SUM(f.UnitsGood), 0) AS DECIMAL(10,2))        AS CostPerUnit,

    -- Share of Total
    CAST(SUM(f.UnitsGood) * 100.0
         / NULLIF((SELECT SUM(UnitsGood)
                   FROM dbo.FactProduction), 0) AS DECIMAL(10,2)) AS ShareOfTotal_Pct

FROM dbo.FactProduction f
JOIN dbo.DimRegion  r  ON f.RegionKey  = r.RegionKey
JOIN dbo.DimChannel ch ON f.ChannelKey = ch.ChannelKey
JOIN dbo.DimDate    d  ON f.DateKey    = d.DateKey
GROUP BY r.Region, r.Country, ch.ChannelName,
         d.YearNumber, d.MonthNumber, d.MonthName;
GO


SELECT 
    -- Availability
    CAST(
        (SUM(ProductionHours) - SUM(DowntimeHours)) * 1.0
        / NULLIF(SUM(ProductionHours), 0)
    AS DECIMAL(10,4)) AS Availability,

    -- Quality (Yield)
    CAST(
        SUM(UnitsGood) * 1.0
        / NULLIF(SUM(UnitsProduced), 0)
    AS DECIMAL(10,4)) AS Quality,

    -- Performance (Normalized)
    CAST(
        (SUM(UnitsProduced) * 1.0 
        / NULLIF(SUM(ProductionHours), 0)) / 100
    AS DECIMAL(10,4)) AS Performance,

    -- Final OEE %
    CAST(
        (
            (SUM(ProductionHours) - SUM(DowntimeHours)) * 1.0
            / NULLIF(SUM(ProductionHours), 0)
        )
        *
        (
            SUM(UnitsGood) * 1.0
            / NULLIF(SUM(UnitsProduced), 0)
        )
        *
        (
            (SUM(UnitsProduced) * 1.0 
            / NULLIF(SUM(ProductionHours), 0)) / 100
        ) * 100
    AS DECIMAL(10,2)) AS OEE_Pct

FROM dbo.vw_ProductionSummary;


