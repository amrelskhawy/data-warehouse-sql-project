/*
==================================================
LOAD Script for Bonze Schema
==================================================
Script Purpose:
    This Script Loads Data from source to our Database
    It Truncate the Table before insert in it 
==================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME;
    set @start_time = GETDATE()
    BEGIN TRY

        -- Start with CRM Tables

        PRINT '======================';
        PRINT 'Loading Bronze Layer';
        PRINT '======================';

        PRINT 'Truncating Table: bronze.crm_cust_info';

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '----------------------';
        PRINT 'Loading CRM Sources';
        PRINT '----------------------';

        PRINT 'Inserting Table: bronze.crm_cust_info';

        BULK INSERT bronze.crm_cust_info
        FROM '/data/source_crm/cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT 'Truncating Table: bronze.crm_prod_info';

        TRUNCATE TABLE bronze.crm_prod_info;

        PRINT 'Inserting Table: bronze.crm_prod_info';

        BULK INSERT bronze.crm_prod_info
        FROM '/data/source_crm/prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT 'Truncating Table: bronze.crm_sales_details';

        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT 'Inserting Table: bronze.crm_sales_details';

        BULK INSERT bronze.crm_sales_details
        FROM '/data/source_crm/sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '----------------------';
        PRINT 'Loading ERP Sources';
        PRINT '----------------------';


        -- Start with ERP Tables

        PRINT 'Truncating Table: bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT 'Inserting Table: bronze.erp_cust_az12';

        BULK INSERT bronze.erp_cust_az12
        FROM '/data/source_erp/CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT 'Truncating Table: bronze.erp_loc_a101';

        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT 'Inserting Table: bronze.erp_loc_a101';

        BULK INSERT bronze.erp_loc_a101
        FROM '/data/source_erp/LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT 'Truncating Table: bronze.erp_px_cat_g1v2';

        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT 'Inserting Table: bronze.erp_px_cat_g1v2';

        BULK INSERT bronze.erp_px_cat_g1v2
        FROM '/data/source_erp/PX_CAT_G1V2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '======================';
        PRINT 'Finish Loading Bronze Layer';
        PRINT '======================';
    END TRY
    BEGIN CATCH
        PRINT 'An error occurred while loading Bronze Layer.';
        PRINT ERROR_MESSAGE();
        PRINT 'Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR);
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
        PRINT 'Procedure: ' + ISNULL(ERROR_PROCEDURE(), 'N/A');
    END CATCH
    set @end_time = GETDATE()

    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR ) + ' Seconds';
END

-- SELECT * FROM bronze.crm_cust_info;
-- SELECT * FROM bronze.crm_prod_info;
-- SELECT * FROM bronze.crm_sales_details;
-- SELECT * FROM bronze.erp_cust_az12;
-- SELECT * FROM bronze.erp_loc_a101;
-- SELECT * FROM bronze.erp_px_cat_g1v2;