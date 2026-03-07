/*
----- Load Bronze Layer -----

Script Purpose:
	This stored procedure 'bronze.load_bronze' loads raw data into the Bronze layer of the data warehouse.
	It performs the following steps:

	1. Loads CRM tables:
		- bronze.crm_cust_info       
		- bronze.crm_prd_info        
		- bronze.crm_sales_details   

	2. Loads ERP tables:
		- bronze.erp_cust_az12       
		- bronze.erp_loc_a101        
		- bronze.erp_px_cat_g1v2    

	3. For each table:
		- Truncates the existing table in the Bronze schema
		- Loads data from CSV files using BULK INSERT
		- Measures and prints the duration of each table load

	4. Prints the total batch load duration
	5. Implements basic error handling using TRY...CATCH, printing error messages if loading fails

	This script is intended to be used for initial ingestion of raw CSV data into the Bronze layer,
	as part of a standard ETL pipeline, before further transformations to Silver/Gold layers.

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;;
	BEGIN TRY

		SET @batch_start_time = GETDATE();

		PRINT '-------------------------------';
		PRINT 'Load Table: cust_info';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\ionut\Desktop\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';
		PRINT ''; 


		PRINT '-------------------------------';
		PRINT 'Load Table: prd_info';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\ionut\Desktop\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';
		PRINT ''; 


		PRINT '-------------------------------';
		PRINT 'Load Table: sales_details';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;

		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\ionut\Desktop\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';
		PRINT '';


		PRINT '-------------------------------';
		PRINT 'Load Table: cust_az12';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;

		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\ionut\Desktop\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';
		PRINT '';


		PRINT '-------------------------------';
		PRINT 'Load Table: loc_a101';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;

		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\ionut\Desktop\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';
		PRINT '';


		PRINT '-------------------------------';
		PRINT 'Load Table: px_cat_g1v2';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\ionut\Desktop\datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT 'Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '-------------------------------';
		PRINT '';


		SET @batch_end_time = GETDATE();
		PRINT '-------------------------------'
        PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';


	END TRY
	BEGIN CATCH
		PRINT 'Error occured during loading...';
		PRINT 'Error message' + ERROR_MESSAGE();
	END CATCH
END

EXEC bronze.load_bronze;