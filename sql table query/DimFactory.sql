
CREATE TABLE dbo.DimFactory (
    FactoryKey    INT             IDENTITY(1,1)  PRIMARY KEY,
    FactoryCode   NVARCHAR(20)    NOT NULL,
    FactoryName   NVARCHAR(200)   NOT NULL,
    City          NVARCHAR(100)   NOT NULL,
    Country       NVARCHAR(100)   NOT NULL,
    Region        NVARCHAR(50)    NOT NULL,
    PlantType     NVARCHAR(50)    NOT NULL
);


INSERT INTO DimFactory (FactoryCode, FactoryName, City, Country, Region, PlantType)
VALUES 
('FAC-JPN-01', 'Osaka Assembly Plant', 'Osaka', 'Japan', 'APAC', 'Assembly'),
('FAC-IND-01', 'Pune Appliances Plant', 'Pune', 'India', 'APAC', 'Component'),
('FAC-IND-02', 'Bangluru Electronic Plant', 'Bangluru', 'India', 'APAC', 'Cell Manufacturing'),
('FAC-USA-01', 'Nevada Battery Plant', 'Nevada', 'America', 'North America', 'Cell Manufacturing'),
('FAC-GER-01', 'Munich Industrial Devices Plant', 'Munich', 'Germany', 'Europe', 'Component'),
('FAC-JPN-02', 'Tokyo ProAv Plant', 'Tokyo', 'Japan', 'APAC', 'Assembly');

SELECT * FROM DimFactory