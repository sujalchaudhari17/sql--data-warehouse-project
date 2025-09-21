/*
=================================================================================
Stored Procedure : Load Bronze Layer( Source-> Bronze)
=================================================================================
Script purpose :
  This stored procedure load data into the 'bronze' schema from external csv files.
  It perfrom the following action:
  -Truncates the bronze tables before loading data.
  -Uses the'BULK INSERT' command to load data from CSV FILES to BRONZE TABLES.


PARAMETERS:
  NONE.
  This stored procedure does not accept any parameter or return any values.
  Usage Example:
  EXEC Bronze.load_bronze;
=================================================================================
/*


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME ,@end_time datetime,@start_time_batch DATETIME,@end_time_batch DATETIME;
	BEGIN TRY
	SET @start_time_batch =GETDATE();

		PRINT'=======================';
		PRINT'LOADING BRONZE LAYER';
		PRINT'=======================';

		PRINT'------------------------';
		PRINT'LOADING CRM TABLE ';
		PRINT'------------------------';
		
		SET @start_time=GETDATE();

		PRINT '>> Truncating table: bronze.crm_cust_info'

		Truncate Table Bronze.crm_cust_info;

		PRINT '>> Inserting data into: bronze.crm_cust_info'

		BULK Insert bronze.crm_cust_info
		from 'C:\Users\Sujal\OneDrive\Desktop\sql project\data warehouses\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time = getdate();
		PRINT '>> LOAD DURATION :'+ CAST( DATEDIFF (SECOND,@start_time,@end_time)AS nvarchar) +'second'

		PRINT '>> Truncating table: bronze.crm_prd_info'

		SET @start_time=GETDATE();

		Truncate Table Bronze.crm_prd_info;

		PRINT '>> Inserting data into: bronze.crm_prd_info'

		BULK Insert bronze.crm_prd_info
		from 'C:\Users\Sujal\OneDrive\Desktop\sql project\data warehouses\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time = getdate();
		PRINT '>> LOAD DURATION :'+ CAST( DATEDIFF (SECOND,@start_time,@end_time)AS nvarchar) +'second'

		PRINT '>> Truncating table: bronze.crm_sales_details'

		SET @start_time=GETDATE();
		Truncate Table Bronze.crm_sales_details;

		PRINT '>> Inserting data into: bronze.crm_sales_details'

		BULK Insert bronze.crm_sales_details
		from 'C:\Users\Sujal\OneDrive\Desktop\sql project\data warehouses\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time = getdate();
		PRINT '>> LOAD DURATION :'+ CAST( DATEDIFF (SECOND,@start_time,@end_time)AS nvarchar) +'second'

		PRINT'------------------------';
		PRINT'LOADING ERM TABLE ';
		PRINT'------------------------';

		SET @start_time = getdate();

		PRINT '>> Truncating table: bronze.erp_cust_az12'

		Truncate Table Bronze.erp_cust_az12;

		PRINT '>> Inserting data into: bronze.erp_cust_az12'

		BULK Insert bronze.erp_cust_az12
		from 'C:\Users\Sujal\OneDrive\Desktop\sql project\data warehouses\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time = getdate();
		PRINT '>> LOAD DURATION :'+ CAST( DATEDIFF (SECOND,@start_time,@end_time)AS nvarchar) +'second'
		 
	    SET @start_time =getdate();

		PRINT '>> Truncating table: bronze.erp_loc_a101'
		
		Truncate Table Bronze.erp_loc_a101;
		PRINT '>> Inserting data into: bronze.erp_loc_a101'

		BULK Insert bronze.erp_loc_a101
		from 'C:\Users\Sujal\OneDrive\Desktop\sql project\data warehouses\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time = getdate();
		PRINT '>> LOAD DURATION :'+ CAST( DATEDIFF (SECOND,@start_time,@end_time)AS nvarchar) +'second'

		SET @start_time =getdate();
		PRINT '>> Truncating table: Bronze.erp_px_cat_g1v2'

		Truncate Table Bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting data into: bronze.erp_px_cat_g1v2'
	

		BULK Insert bronze.erp_px_cat_g1v2
		from 'C:\Users\Sujal\OneDrive\Desktop\sql project\data warehouses\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);

		SET @end_time = getdate();
		PRINT '>> LOAD DURATION :'+ CAST( DATEDIFF (SECOND,@start_time,@end_time)AS nvarchar) +'second'
		PRINT '================'

        SET @end_time_batch =GETDATE();
		PRINT 'Loading Bronze Layer is Completed'
		PRINT '-Total load duration:'+CAST (DATEDIFF(SECOND,@start_time_batch,@end_time_batch)AS nvarchar)
		PRINT'========='
	END TRY
	BEGIN CATCH
	     PRINT '================================='
		 PRINT ' ERROR OCCURED DURING LOADING BRONZE LAYER'
		 PRINT'Error Messgae' + error_message();
		 Print'Error Messgae' + cast(error_number() as nvarchar);
		 PRINT'Error Messgae' + cast(error_state() as nvarchar);
		 PRINT'=================================='

	END CATCH
END
go

exec bronze.load_bronze


