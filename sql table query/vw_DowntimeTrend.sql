CREATE OR ALTER VIEW dbo.vw_DowntimeTrend AS
SELECT
    d.YearNumber,
    d.QuarterNumber,
    d.MonthNumber,
    d.MonthName,
    fa.FactoryName,
    fa.PlantType,
    fa.Country,

    SUM(f.ProductionHours)                                      AS TotalProductionHours,
    SUM(f.DowntimeHours)                                        AS TotalDowntimeHours,
    SUM(f.ProductionHours) - SUM(f.DowntimeHours)               AS EffectiveHours,

    CAST(SUM(f.DowntimeHours) * 100.0
         / NULLIF(SUM(f.ProductionHours), 0) AS DECIMAL(10,2))  AS DowntimeRate_Pct,

    -- Financial Impact of Downtime
    CAST(SUM(f.ActualCost)
         / NULLIF(SUM(f.ProductionHours), 0)
         * SUM(f.DowntimeHours) AS DECIMAL(18,2))               AS DowntimeCostImpact,

    CASE
        WHEN SUM(f.DowntimeHours) * 100.0
             / NULLIF(SUM(f.ProductionHours), 0) <= 5  THEN 'Excellent'
        WHEN SUM(f.DowntimeHours) * 100.0
             / NULLIF(SUM(f.ProductionHours), 0) <= 10 THEN 'Good'
        WHEN SUM(f.DowntimeHours) * 100.0
             / NULLIF(SUM(f.ProductionHours), 0) <= 15 THEN 'Average'
        ELSE 'Critical'
    END                                                         AS DowntimeStatus

FROM dbo.FactProduction f
JOIN dbo.DimDate    d  ON f.DateKey    = d.DateKey
JOIN dbo.DimFactory fa ON f.FactoryKey = fa.FactoryKey
GROUP BY d.YearNumber, d.QuarterNumber, d.MonthNumber, d.MonthName,
         fa.FactoryName, fa.PlantType, fa.Country;
GO

SELECT * FROM vw_DowntimeTrend