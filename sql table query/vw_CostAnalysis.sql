CREATE OR ALTER VIEW dbo.vw_CostAnalysis AS
SELECT
    d.YearNumber,
    d.MonthNumber,
    d.MonthName,
    fa.FactoryName,
    fa.PlantType,
    s.SupplierName,
    s.SupplierType,

    SUM(f.UnitsGood)                                            AS TotalUnitsGood,
    SUM(f.StandardCost)                                         AS TotalStandardCost,
    SUM(f.ActualCost)                                           AS TotalActualCost,
    SUM(f.ActualCost) - SUM(f.StandardCost)                     AS CostVariance,

    CAST((SUM(f.ActualCost) - SUM(f.StandardCost)) * 100.0
         / NULLIF(SUM(f.StandardCost), 0) AS DECIMAL(10,2))     AS CostVariance_Pct,

    CAST(SUM(f.ActualCost)
         / NULLIF(SUM(f.UnitsGood), 0) AS DECIMAL(10,2))        AS ActualCostPerUnit,
    CAST(SUM(f.StandardCost)
         / NULLIF(SUM(f.UnitsGood), 0) AS DECIMAL(10,2))        AS StandardCostPerUnit,

    CASE
        WHEN SUM(f.ActualCost) <= SUM(f.StandardCost)           THEN 'Under Budget'
        WHEN (SUM(f.ActualCost) - SUM(f.StandardCost)) * 100.0
             / NULLIF(SUM(f.StandardCost), 0) <= 5              THEN 'Within Tolerance'
        WHEN (SUM(f.ActualCost) - SUM(f.StandardCost)) * 100.0
             / NULLIF(SUM(f.StandardCost), 0) <= 10             THEN 'Over Budget'
        ELSE 'Critical Overrun'
    END                                                         AS BudgetStatus

FROM dbo.FactProduction f
JOIN dbo.DimDate     d  ON f.DateKey     = d.DateKey
JOIN dbo.DimFactory  fa ON f.FactoryKey  = fa.FactoryKey
JOIN dbo.DimSupplier s  ON f.SupplierKey = s.SupplierKey
GROUP BY d.YearNumber, d.MonthNumber, d.MonthName,
         fa.FactoryName, fa.PlantType,
         s.SupplierName, s.SupplierType;
GO


SELECT * FROM vw_CostAnalysis