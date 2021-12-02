-- Make the company’s database your default database:
DATABASE ua_company;

-- Exercise 1 --
-- How many distinct dates are there in the saledate column of the transaction table for each month/year combination in the database?
SELECT EXTRACT(YEAR FROM saledate) AS year_num,
       EXTRACT(MONTH  FROM saledate) AS month_num,
       COUNT(DISTINCT saledate) AS distinct_days
FROM trnsact
GROUP BY year_num, month_num
ORDER BY year_num ASC, month_num ASC;


-- Exercise 2 --
-- Determine which sku had the greatest total sales during the combined summer months of June, July, and August. 
SELECT sku,
       SUM(CASE WHEN EXTRACT(MONTH FROM saledate)=6 AND stype='P' THEN amt END) AS june_sales,
       SUM(CASE WHEN EXTRACT(MONTH FROM saledate)=7 AND stype='P' THEN amt END) AS july_sales,
       SUM(CASE WHEN EXTRACT(MONTH FROM saledate)=8 AND stype='P' THEN amt END) AS august_sales, 
       (june_sales + july_sales + august_sales) AS summer_sales      
FROM trnsact
GROUP BY sku
ORDER BY summer_sales DESC;

-- Exercise 3 --
-- How many distinct dates are there in the saledate column of the transaction table for each month/year/store combination in the database?
-- Sort your results by the number of days per combination in ascending order. 
SELECT EXTRACT(YEAR FROM saledate) AS year_num,
       EXTRACT(MONTH FROM saledate) AS month_num,
       store,
       COUNT(DISTINCT saledate) AS num_saledates
FROM trnsact
GROUP BY month_num, year_num, store
ORDER BY num_saledates ASC; 
