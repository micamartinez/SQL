--Make the company’s database your default database:
DATABASE ua_company;

--Use HELP and SHOW to confirm the relational schema for the company’s dataset:
HELP TABLE strinfo;
HELP TABLE skstinfo;
HELP TABLE skuinfo;
HELP TABLE deptinfo;
HELP TABLE trnsact;
HELP TABLE store_msa;

SHOW TABLE strinfo;
SHOW TABLE skstinfo;
SHOW TABLE skuinfo;
SHOW TABLE deptinfo;
SHOW TABLE trnsact;
SHOW TABLE store_msa;

--Look at examples of data from each of the tables:
SELECT TOP 10 *
FROM strinfo
ORDER BY state;

SELECT TOP 10 *
FROM skstinfo
ORDER BY cost DESC;

SELECT TOP 10 *
FROM skuinfo
ORDER BY vendor ASC;

SELECT *
FROM deptinfo
SAMPLE 10;

SELECT *
FROM trnsact
SAMPLE .10;

SELECT TOP 10 *
FROM store_msa
WHERE state='FL';

--Examine lists of distinct values in each of the tables:
SELECT DISTINCT city 
FROM strinfo 
ORDER BY city;

SELECT DISTINCT retail
FROM skstinfo
ORDER BY retail DESC;

SELECT DISTINCT color, size
FROM skuinfo;

SELECT DISTINCT deptdesc
FROM deptinfo
SAMPLE 10;

SELECT DISTINCT stype 
FROM trnsact
ORDER BY stype;

SELECT DISTINCT state, city 
FROM store_msa
ORDER BY state;

-- Examine instances of trnsact table where “amt” is different than “sprice”:
SELECT *
FROM trnsact
WHERE amt <> sprice;

-- Examine rows in the trsnact table that have “0” in their orgprice column:
SELECT *
FROM trnsact
WHERE orgprice=0;

-- Examine rows in the skstinfo table where both the cost and retail price are listed as 0.00:
SELECT *
FROM skstinfo
WHERE cost=0.0 AND retail=0.0;

-- Examine rows in the skstinfo table where the cost is greater than the retail price:
SELECT *
FROM skstinfo
WHERE cost > retail;

-- Write a query that retrieve multiple columns in a precise order from using “BETWEEN”
SELECT sprice, quantity
FROM trnsact
WHERE quantity BETWEEN 20 AND 100
ORDER BY quantity;

-- Write a query that retrieve multiple columns in a precise order from using “IN”
SELECT size, color
FROM skuinfo
WHERE color IN ('pink', 'blue', 'green');

-- Try one query that uses dates to restrict the rows you retrieve:
SELECT saledate, quantity, sprice
FROM trnsact
WHERE saledate < '2012-02-05';
