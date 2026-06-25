-- Automotive Dataset Setup

SET GLOBAL local_infile = 1;

CREATE DATABASE IF NOT EXISTS automotive;
USE automotive;

CREATE TABLE IF NOT EXISTS vehicle_sales (
    year INT,
    make VARCHAR(100),
    model VARCHAR(100),
    trim VARCHAR(100),
    body VARCHAR(100),
    transmission VARCHAR(50),
    vin VARCHAR(50),
    state VARCHAR(50),
    condition_rating INT,
    odometer INT,
    color VARCHAR(50),
    interior VARCHAR(50),
    seller VARCHAR(255),
    mmr INT,
    sellingprice INT,
    saledate VARCHAR(255)
);

LOAD DATA LOCAL INFILE 'C:\Users\akhwa\OneDrive\Desktop\SQL\car_prices.csv'
INTO TABLE vehicle_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES; -- This skips the header row of your CSV


LOAD DATA LOCAL INFILE 'C:/Users/akhwa/Downloads/car_prices.csv'
INTO TABLE vehicle_sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

SELECT *
FROM automotive.vehicle_sales