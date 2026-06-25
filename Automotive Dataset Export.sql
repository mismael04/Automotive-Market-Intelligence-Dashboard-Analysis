-- High-Performance Export from sales_staging2
SELECT 'year', 'make', 'model', 'trim', 'body', 'transmission', 'vin', 'state', 'condition_rating', 'odometer', 'color', 'interior', 'seller', 'mmr', 'sellingprice', 'sale_year'
UNION ALL
SELECT 
    year, 
    make, 
    model, 
    trim, 
    body, 
    transmission, 
    vin, 
    state, 
    condition_rating,
    odometer, 
    color, 
    interior, 
    seller, 
    mmr, 
    sellingprice,
    sale_year
FROM automotive.sales_staging2
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehicle_sales_final_clean.csv'
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n';