# SQL Data Warehouse Project

## Overview
This project demonstrates the implementation of a **modern Data Warehouse architecture using SQL**, following the **Bronze, Silver and Gold layered approach** commonly used in modern data platforms.

The goal of this project is to simulate a real-world data engineering workflow including:

* Data ingestion
* Data transformation
* Data modeling
* Data quality validation
* Analytical data layer

The solution is fully implemented using **SQL scripts** and organized as a structured ETL pipeline.

---

## Project Structure
- `datasets/` – Contains raw source datasets:
  - `source_crm/` – CRM-related CSV files
  - `source_erp/` – ERP-related CSV files
- `scripts/` – Contains SQL scripts organized by pipeline layers:
  - `01_setup/` – Scripts for creating the data warehouse
  - `02_bronze_layer/` – DDL and load scripts for the Bronze layer
  - `03_silver_layer/` – DDL and load scripts for the Silver layer
  - `04_gold_layer/` – Scripts to create analytical views in the Gold layer
  - `05_quality_checks/` – Scripts for Silver and Gold data quality validation

---

## Data Pipeline Flow
1. Create the Data Warehouse
2. Load raw data into Bronze tables
3. Transform and clean data into Silver tables
4. Create analytical views in the Gold layer
5. Execute data quality checks

---

## Data Warehouse Architecture

### Bronze Layer (Raw Data)
Contains **raw ingested data** directly loaded from source systems.

**Characteristics:**
* minimal transformations
* raw data storage

### Silver Layer (Cleaned Data)
Performs **data cleansing and transformation**.

**Operations include:**
* data standardization
* type casting
* removing duplicates
* data quality improvements

### Gold Layer (Business Layer)
Contains **business-ready datasets** used for analytics and reporting.

**Features:**
* curated datasets
* aggregated views
* business-friendly schema

---

## Data Quality Checks
Validation scripts include:

* Duplicate detection
* Null validation

Checks are implemented for both **Silver and Gold layers**.

---

## Tools Used
- SQL Server Management Studio 22
