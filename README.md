# 🚗 Automotive Market Intelligence Analysis & Dashboard

**Tech Stack:** MySQL(CTEs, Window Functions, Data Cleaning) • Power BI • Tableau

---

## 📌 Project Overview

This project analyzes a **550,000+ row vehicle sales dataset** to uncover pricing trends, market behavior, and geographic demand patterns in the automotive resale market.

The workflow includes **SQL-based data cleaning, staging pipelines, deduplication logic, and feature engineering**, followed by interactive dashboards built in **Power BI and Tableau**.

---

## ⚙️ Key Features

- Created a full **SQL data analysis workflow** using staging tables for safe transformations
- Processed **558,833+ vehicle sales records**
- Performed **deduplication using VIN-based window functions (ROW_NUMBER CTEs)**
- Standardized inconsistent manufacturer and text fields (make, model, trim, state)
- Normalized vehicle condition ratings from a **0–50 scale → 0.0–5.0 scale**
- Extracted structured features such as **sale year from raw text timestamps**
- Reduced preprocessing time by ~**75% vs spreadsheet-based workflows**

---

## 📊 Key Insights

- Vehicle sales are heavily concentrated in major supply hubs:
  - **Florida**
  - **California**
  - **Texas**
  - **Pennsylvania**

- Market averages:
  - 🚘 Average vehicle age sold: **~5 years**
  - 💰 Average selling price: **$13,611**

- Strong correlation observed between:
  - Odometer reading ↑ → Selling price ↓
  - Condition rating ↑ → Selling price ↑

---

## 📈 Dashboards

### Power BI & Tableau Visualizations

The project includes interactive dashboards featuring:

- 🗺️ **Geographic sales distribution by state**
- 🧾 **Brand market share (Treemap visualization)**
- 📉 **Odometer vs Selling Price scatter plot with trend line**
- 🎨 **Condition rating impact (color-coded scatter analysis)**
- 📊 **Key Performance Indicators (KPIs)**:
  - Total Vehicle Sales: **558,833**
  - Average Vehicle Age: **5 years**
  - Average Selling Price: **$13,611**

---

## 🧹 Data Analysis (SQL)

### 1. Staging Layer Creation
- Created `sales_staging` to protect raw dataset integrity

### 2. Deduplication (VIN-based)
- Used `ROW_NUMBER()` window function to identify duplicate records
- Built clean staging layer (`sales_staging2`) with unique entries

### 3. Data Standardization
- Trimmed whitespace and standardized casing
- Fixed inconsistent manufacturer naming (e.g., CHEV → CHEVROLET, VW → VOLKSWAGEN)
- Converted empty strings and placeholders to NULL values

### 4. Feature Engineering
- Converted condition rating:
  - 0–50 scale → 0–5 scale

### 5. Date Extraction
- Extracted `sale_year` from raw date strings

### 6. Data Cleaning Finalization
- Removed raw text date column after transformation
- Final dataset optimized for BI tools

---

## 🧠 SQL Concepts Used

- CTEs (Common Table Expressions)
- Window Functions (`ROW_NUMBER()`)
- Data type conversion and casting
- String manipulation (`TRIM`, `UPPER`, `SUBSTRING`)
- Conditional logic (`CASE WHEN`)
- Staging table architecture

---

## 📁 Dataset

- Source: Kaggle Vehicle Sales Dataset  
- Records: **558,833 rows**
- Link: https://www.kaggle.com/datasets/mannatpruthi/vehicle-sales-and-market-trends-dataset

---

## 📌 Project Outcome

This project demonstrates:
- End-to-end data pipeline design
- Real-world SQL data cleaning at scale
- Business intelligence dashboard development
- Market analysis and KPI extraction

---

## 🚀 Future Improvements

- Add predictive pricing model using regression
- Build time-series forecasting for vehicle prices
- Integrate Python-based ML pipeline (scikit-learn)
- Deploy dashboards to cloud (Power BI Service / Tableau Public)

---
