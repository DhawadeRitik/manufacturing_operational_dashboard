CREATE OR ALTER VIEW dbo.vw_ProductionSummary AS
SELECT
    -- DimDate (6 columns)
    dd.[Date],
    dd.YearNumber,
    dd.QuarterNumber,
    dd.MonthNumber,
    dd.MonthName,

    -- DimFactory (4 columns)
    df.FactoryName,
    df.PlantType,
    df.Country          AS FactoryCountry,
    df.Region           AS FactoryRegion,

    -- DimSupplier (2 columns)
    ds.SupplierName,
    ds.SupplierType,

    -- DimRegion (2 columns)
    dr.Region           AS SalesRegion,
    dr.Country          AS SalesCountry,

    -- DimChannel (1 column)
    dc.ChannelName,

    -- DimProduct (6 columns)
    dp.ProductName,
    dp.CategoryName,
    dp.BusinessDivisionName,
    dp.segmentName,
    dp.TechnologyType,
    dp.LaunchYear       AS ProductLaunchYear,

    -- FactProduction Raw (7 columns)
    fp.UnitsProduced,
    fp.UnitsGood,
    fp.UnitsScrap,
    fp.ProductionHours,
    fp.DowntimeHours,
    fp.StandardCost,
    fp.ActualCost,

    -- Calculated Columns (7 columns)
    fp.ActualCost - fp.StandardCost                             AS CostVariance,

    CAST(fp.UnitsGood * 100.0
         / NULLIF(fp.UnitsProduced, 0) AS DECIMAL(10,2))        AS YieldRate_Pct,

    CAST(fp.UnitsScrap * 100.0
         / NULLIF(fp.UnitsProduced, 0) AS DECIMAL(10,2))        AS ScrapRate_Pct,

    CAST(fp.DowntimeHours * 100.0
         / NULLIF(fp.ProductionHours, 0) AS DECIMAL(10,2))      AS DowntimeRate_Pct,

    CAST(fp.UnitsProduced * 100.0
         / NULLIF(fp.ProductionHours, 0) AS DECIMAL(10,2))      AS UnitPerHour,

    fp.ProductionHours - fp.DowntimeHours                       AS PlantWorkingHours,

    CAST((fp.ProductionHours - fp.DowntimeHours) * 100.0
         / NULLIF(fp.ProductionHours, 0) AS DECIMAL(10,2))      AS PlantEfficiencyPct

FROM dbo.FactProduction  fp
JOIN dbo.DimDate     dd ON fp.DateKey     = dd.DateKey
JOIN dbo.DimFactory  df ON fp.FactoryKey  = df.FactoryKey
JOIN dbo.DimSupplier ds ON fp.SupplierKey = ds.SupplierKey
JOIN dbo.DimRegion   dr ON fp.RegionKey   = dr.RegionKey
JOIN dbo.DimProduct  dp ON fp.ProductKey  = dp.ProductKey
JOIN dbo.DimChannel  dc ON fp.ChannelKey  = dc.ChannelKey;


