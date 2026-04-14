/* CREATE DATABASE Manufacturing_Operational_Data;
   USE Manufacturing_Operational_Data;
*/

-- 1) DimChannel Table 
CREATE TABLE DimChannel (
ChannelKey INT IDENTITY(1,1) PRIMARY KEY,
ChannelName VARCHAR(50)
);

INSERT INTO DimChannel (ChannelName)
VALUES 
('Retail'),
('B2B'),
('Distributor'),
('Online'),
('OEM');

SELECT * FROM DimChannel