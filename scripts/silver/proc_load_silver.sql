-- Insert in the silver.crm_cust_info 
INSERT INTO silver.crm_cust_info (
    cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status,
    cst_gndr, cst_create_date
)
-- check the duplicates in cst_id
SELECT 
cst_id,
cst_key,
TRIM(cst_firstname) AS cst_firstname,
TRIM(cst_lastname)  AS cst_lastname,
-- cst_marital_status
CASE WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
     WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
     ELSE 'n/a'
END AS cst_marital_status, -- Normalize martial status values to readable format
-- cst_gndr
CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
     WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
     ELSE 'n/a'
END AS cst_gndr, -- Normalize gender values to readable format
cst_create_date
FROM
(
    SELECT 
        *, 
        ROW_NUMBER() OVER (
            PARTITION BY cst_id 
            ORDER BY cst_create_date DESC
        ) as flag_last
    FROM bronze.crm_cust_info
) t  -- <-- This is an alias for the subquery
WHERE flag_last = 1 AND cst_id IS NOT NULL;



-- Insert in the silver.crm_prod_info 

-- SELECT 
-- prd_id,
-- prd_key,
-- REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,
-- prd_nm,
-- prd_line,
-- prd_cost,
-- prd_start_dt,
-- prd_end_dt
-- FROM bronze.crm_prod_info
-- WHERE REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') NOT IN 
-- (SELECT DISTINCT id from bronze.erp_px_cat_g1v2)