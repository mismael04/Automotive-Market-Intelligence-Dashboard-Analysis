-- SQL Automotive Project - Data Cleaning & Standardization
-- Database: automotive | Table: vehicle_sales
-- Dataset: Vehicle Sales and Market Trends
-- URL: https://www.kaggle.com/datasets/mannatpruthi/vehicle-sales-and-market-trends-dataset

-- Steps for data cleaning:
-- 1. Create a staging environment to protect raw data
-- 2. Isolate and remove duplicate records via VIN tracking
-- 3. Standardize text data and fix string errors
-- 4. Normalize rating scales (Vehicle Condition)
-- 5. Convert date fields from text to int type for year
-- 6. Remove non-viable rows

-- view raw data
SELECT * FROM automotive.vehicle_sales
LIMIT 10;


-- ====================================================================
-- 1. Create a staging environment to protect raw data
-- ====================================================================

CREATE TABLE automotive.sales_staging 
LIKE automotive.vehicle_sales;

INSERT INTO automotive.sales_staging 
SELECT * FROM automotive.vehicle_sales;

-- ====================================================================
-- 2. Isolate and remove duplicate records via VIN tracking
-- ====================================================================

-- Identify duplicate entries across all core transactional criteria using a CTE
WITH duplicate_cte AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY year, make, model, trim, body, transmission, vin, state, condition_rating, odometer, seller, mmr, sellingprice, saledate
            ORDER BY (SELECT NULL)
        ) AS row_num
    FROM automotive.sales_staging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- Deduplicate by creating a clean secondary staging table containing only unique records
CREATE TABLE automotive.sales_staging2 LIKE automotive.sales_staging;

INSERT INTO automotive.sales_staging2
SELECT DISTINCT 
    year, make, model, trim, body, transmission, vin, state, condition_rating, odometer, color, interior, seller, mmr, sellingprice, saledate
FROM automotive.sales_staging;



-- ====================================================================
-- 3. Standardize text data and fix string errors
-- ====================================================================

-- Trim white spaces and enforce upper casing across descriptive attributes
UPDATE automotive.sales_staging2
SET 
    make = UPPER(TRIM(make)),
    model = UPPER(TRIM(model)),
    trim = TRIM(trim),
    body = UPPER(TRIM(body)),
    transmission = UPPER(TRIM(transmission)),
    vin = UPPER(TRIM(vin)),
    state = UPPER(TRIM(state));

-- Standardize blank string entries to explicit NULL values
UPDATE automotive.sales_staging2 SET transmission = NULL WHERE transmission = '' OR transmission = '—';
UPDATE automotive.sales_staging2 SET body = NULL WHERE body = '' OR body = '—';
UPDATE automotive.sales_staging2 SET trim = NULL WHERE trim = '' OR trim = '—';

SELECT DISTINCT make
FROM sales_staging2
ORDER BY 1 ASC; 

-- After looking at distinct makes, a lot of them have multiple makes for the same make,
-- so that needs to be standardized
UPDATE automotive.sales_staging2
SET make = CASE 
    WHEN make LIKE 'MERCEDES%' THEN 'MERCEDES-BENZ'
    WHEN make LIKE 'MAZDA%' THEN 'MAZDA'
    WHEN make LIKE 'HYUNDAI%' THEN 'HYUNDAI'
    WHEN make LIKE 'FORD%' THEN 'FORD'
    WHEN make LIKE 'GMC%' THEN 'GMC'
    WHEN make LIKE 'LANDROVER%' THEN 'LAND ROVER'
    WHEN make LIKE 'VW%' THEN 'VOLKSWAGEN'
    WHEN make LIKE 'DODGE%' THEN 'DODGE'
    WHEN make LIKE 'CHEV%' THEN 'CHEVROLET'
    ELSE make
END;

-- now all the makes are organized
SELECT DISTINCT make
FROM sales_staging2
ORDER BY 1 ASC; 


-- ====================================================================
-- 4. Normalize rating scales (Vehicle Condition)
-- ====================================================================

SELECT MAX(condition_rating), MIN(condition_rating)
FROM automotive.sales_staging2;

-- Rescale condition rating from a 0-50 scale down to a standard 0.0-5.0 scale
-- Allow decimals before running division since the column is an int
ALTER TABLE automotive.sales_staging2
MODIFY COLUMN condition_rating DECIMAL(3,1);

UPDATE automotive.sales_staging2
SET condition_rating = condition_rating / 10.0;

SELECT MAX(condition_rating), MIN(condition_rating)
FROM automotive.sales_staging2;


-- ====================================================================
-- 5. Convert date fields from text to date type
-- ====================================================================

-- 1. Add a clean integer column for the sale year
ALTER TABLE automotive.sales_staging2
ADD COLUMN sale_year INT AFTER saledate;

-- 2. Extract the year using SUBSTRING (This is incredibly lightweight and fast)
UPDATE automotive.sales_staging2
SET sale_year = CAST(SUBSTRING(saledate, 12, 4) AS UNSIGNED)
WHERE saledate IS NOT NULL 
  AND LENGTH(TRIM(saledate)) >= 15;

SELECT sale_year FROM automotive.sales_staging2;

-- ====================================================================
-- 6. Remove non-viable rows
-- ====================================================================

-- 1. Remove the original messy text column
ALTER TABLE automotive.sales_staging2
DROP COLUMN saledate;

-- 2. Final table is ready
SELECT * FROM automotive.sales_staging2
LIMIT 10;
