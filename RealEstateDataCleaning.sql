/* Data Cleaning for Real Estate Data Set */
/* Created by: Joseph Christian San Pablo */

/* Deleting rows where environment, price, area and energy_cost  has NA or Null Values */
SELECT * FROM dbo.[Real Estate Dataset]

DELETE FROM [Real Estate Dataset] WHERE price IS NULL;

DELETE FROM [Real Estate Dataset] WHERE environment IS NULL;

DELETE FROM [Real Estate Dataset] WHERE area IS NULL;

DELETE FROM dbo.[Real Estate Dataset] WHERE energy_costs = 'NA';

DELETE FROM dbo.[Real Estate Dataset] WHERE environment = 'NA';

SELECT * FROM dbo.[Real Estate Dataset]
/* Deleting Unneccesary and Incomplete Columns */
ALTER TABLE dbo.[Real Estate Dataset] DROP COLUMN energy_costs

ALTER TABLE dbo.[Real Estate Dataset] DROP COLUMN provision, certificate, construction_type, 
orientation, year_built, last_reconstruction, total_floors, floor, lift, balkonies, loggia, cellar;

