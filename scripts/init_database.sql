/*
=====================================
CREATE DATABASE AND SCHEMAS
=====================================

Script Purpose: 
    This Script creates new database named "DataWarehouse" after checking if it already exists.

    If it exists, it is dropped and recreated. Additionally, the script set up three schemas within the database: 'bronze', 'silver', and 'gold'
*/

USE master;
GO

-- Check if there are any DATABASE in my system called DataWarehouse
-- then it Drop it immediatly 
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- CREATE THE DATABASE
CREATE DATABASE DataWarehouse;
GO

-- CREATE Schemas for Database

USE DataWarehouse;
Go

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;