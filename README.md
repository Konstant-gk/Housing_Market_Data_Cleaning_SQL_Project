# US Housing Market Data Cleaning - SQL Project

## Project Overview

This project demonstrates comprehensive data cleaning techniques applied to a real-world US housing market dataset using SQL Server. The objective was to transform raw, inconsistent housing data into a clean, standardized, and analysis-ready dataset through systematic data quality improvements.

## Objectives

The primary objectives of this project were to:

- **Standardize data formats** to ensure consistency across date fields and categorical variables
- **Handle missing data** intelligently by populating null values using data relationships
- **Restructure data** by splitting composite address fields into normalized columns for better query performance and analysis
- **Standardize categorical values** to improve data quality and reporting consistency
- **Identify and remove duplicate records** to ensure data integrity
- **Optimize database structure** by removing redundant columns after data transformation

## Summary

This project involved cleaning a comprehensive US housing market dataset containing property sales information. The dataset required extensive data quality improvements including date standardization, address normalization, missing value imputation, duplicate detection, and data type standardization. Through a systematic approach using SQL Server, I transformed the raw dataset into a clean, structured format suitable for analysis, reporting, and further data processing.

The cleaning process addressed multiple data quality issues commonly found in real-world datasets, including inconsistent date formats, missing property addresses, composite address fields that needed normalization, inconsistent categorical values, duplicate records, and redundant columns. Each issue was addressed methodically with proper validation queries before applying transformations.

## Tools and Technologies

- **SQL Server Management Studio (SSMS)** - Database management and query execution
- **Microsoft SQL Server** - Relational database management system
- **T-SQL (Transact-SQL)** - SQL dialect for data manipulation and transformation
- **Excel** - Initial data source format

## Data Cleaning Process

### 1. Date Standardization
Converted inconsistent date formats to a standardized DATE data type, creating a new `SaleDateConverted` column to preserve the original data while ensuring consistent date handling.

### 2. Missing Data Imputation
Identified and populated missing property addresses by leveraging relationships between records with the same ParcelID, using self-joins and the ISNULL function to intelligently fill gaps in the data.

### 3. Address Normalization
Split composite address fields into normalized columns:
- **Property Address**: Separated into `PropertySplitAddress` and `PropertySplitCity` using SUBSTRING and CHARINDEX functions
- **Owner Address**: Separated into `OwnerSplitAddress`, `OwnerSplitCity`, and `OwnerSplitState` using PARSENAME function

### 4. Categorical Value Standardization
Standardized the `SoldAsVacant` field by converting 'Y' and 'N' values to 'Yes' and 'No' using CASE statements, ensuring consistent reporting and analysis.

### 5. Duplicate Detection and Removal
Identified duplicate records using Common Table Expressions (CTEs) and the ROW_NUMBER() window function, partitioning by key fields (ParcelID, PropertyAddress, SalePrice, SaleDate, LegalReference) to detect exact duplicates.

### 6. Column Optimization
Removed redundant columns (`OwnerAddress`, `TaxDistrict`, `PropertyAddress`, `SaleDate`) after successfully splitting and converting them into normalized structures, improving database efficiency and reducing storage requirements.

## Results Summary

The data cleaning process successfully transformed the raw housing market dataset into a clean, standardized format. Key achievements include:

- **100% date standardization** - All sale dates converted to consistent DATE format
- **Complete address normalization** - All addresses split into structured components (Address, City, State)
- **Data consistency** - All categorical values standardized to consistent formats
- **Improved data quality** - Duplicate records identified and removed
- **Optimized structure** - Redundant columns eliminated, improving query performance
- **Enhanced analysis readiness** - Dataset prepared for advanced analytics, reporting, and visualization

The cleaned dataset is now ready for use in business intelligence dashboards, statistical analysis, machine learning models, and other data-driven applications.
