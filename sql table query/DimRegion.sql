
CREATE TABLE dbo.DimRegion (
    RegionKey   INT             IDENTITY(1,1)  PRIMARY KEY,
    Region      VARCHAR(50)     NOT NULL,  -- APAC, Europe, etc.
    Country     VARCHAR(100)    NOT NULL,
    CONSTRAINT UQ_DimRegion UNIQUE (Region, Country)
);

IF OBJECT_ID('dbo.DimRegion', 'U') IS NOT NULL BEGIN DELETE FROM dbo.DimRegion END;

INSERT INTO dbo.DimRegion (Region, Country)
VALUES
(N'APAC',                N'India'),
(N'APAC',                N'Japan'),
(N'APAC',                N'Singapore'),
(N'APAC',                N'Australia'),
(N'North America',       N'USA'),
(N'North America',       N'Canada'),
(N'Europe',              N'Germany'),
(N'Europe',              N'UK'),
(N'Europe',              N'France'),
(N'Middle East & Africa',N'UAE'),
(N'Middle East & Africa',N'South Africa'),
(N'Latin America',       N'Brazil'),
(N'Latin America',       N'Mexico');
