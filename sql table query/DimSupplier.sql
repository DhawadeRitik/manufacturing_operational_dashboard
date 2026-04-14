CREATE TABLE dbo.DimSupplier (
    SupplierKey     INT             IDENTITY(1,1)   PRIMARY KEY,
    SupplierCode    VARCHAR(40)     NOT NULL UNIQUE,
    SupplierName    VARCHAR(200)    NOT NULL,
    SupplierType    VARCHAR(50)     NULL,   -- Raw Material / Component / Logistics etc.
    Country         VARCHAR(100)    NULL,
    Region          VARCHAR(50)     NULL,
    IsActive        BIT             NOT NULL DEFAULT (1)
);

IF OBJECT_ID('dbo.DimSupplier', 'U') IS NOT NULL BEGIN DELETE FROM dbo.DimSupplier; END

INSERT INTO dbo.DimSupplier (SupplierCode, SupplierName, SupplierType, Country, Region)
VALUES
(N'SUP-CHIP-01', N'Kippon Semicon',    N'Component',    N'Japan',     N'APAC'),
(N'SUP-PLAS-01', N'ColyMakers',        N'Raw Material', N'India',     N'APAC'),
(N'SUP-METL-01', N'Qlobal Metals',     N'Raw Material', N'Australia', N'APAC'),
(N'SUP-LOGI-01', N'Zwift Logistics',   N'Logistics',    N'USA',       N'North America'),
(N'SUP-PACK-01', N'KackRight',         N'Packaging',    N'Germany',   N'Europe'),
(N'SUP-BATT-01', N'MithiumSource',     N'Raw Material', N'Chile',     N'Latin America');
GO