# Pyhton+SQL_Project

-> Pandas Data Cleaning & Preprocessing
   * Automated data pipeline for order analytics.

-> Key Operations:

   1.Data Ingestion & Null Handling
     -> Read CSV with custom na_values to standardize missing data (Not Available/unknown).
  
   2.Validated data integrity using unique() checks.
  
   3.Column Standardization
  
   4.Renamed columns to lowercase with underscores (e.g., Order Id → order_id) for SQL compatibility.

-> Feature Engineering

   5.Derived profit dynamically from sale_price and cost_price (commented: discount calculations).

-> DateTime Conversion

   6.Parsed order_date strings into datetime objects for time-series analysis.

-> Optimized Storage

   7.Dropped redundant columns (list_price, cost_price) to reduce memory usage.

Tools: Python, Pandas.
Impact: Transformed raw data into analysis-ready format, enabling faster reporting.
