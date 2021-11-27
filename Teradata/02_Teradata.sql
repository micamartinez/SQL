-- Make the company’s database your default database:
DATABASE ua_company;

-- GROUP BY clauses in Teradata:
SELECT sku, retail, cost, COUNT(sku)
FROM skstinfo
GROUP BY sku, retail, cost;

SELECT sku, COUNT(sku), AVG(retail), AVG(cost)
FROM skstinfo
GROUP BY sku;


-- Exercise 1 --
-- (a) Determine how many distinct skus there are in pairs of the skuinfo, skstinfo, and trnsact tables:
SELECT COUNT(DISTINCT a.sku) 
FROM skuinfo a 
 JOIN skstinfo b 
  ON a.sku=b.sku;

SELECT COUNT(DISTINCT a.sku) 
FROM skuinfo a 
 JOIN trnsact b 
  ON a.sku=b.sku;

SELECT COUNT(DISTINCT a.sku) 
FROM skstinfo a 
 JOIN trnsact b 
  ON a.sku=b.sku;

-- (b) Which skus are common to the three tables? 
SELECT DISTINCT a.sku
FROM skuinfo a
 JOIN skstinfo b
  ON a.sku = b.sku
 JOIN trnsact c
  ON b.sku = c.sku;

-- (c) Which skus are common to pairs of tables?
SELECT DISTINCT a.sku 
FROM skuinfo a 
 JOIN skstinfo b 
  ON a.sku=b.sku;

SELECT DISTINCT a.sku 
FROM skuinfo a 
 JOIN trnsact b 
  ON a.sku=b.sku;

SELECT DISTINCT a.sku 
FROM skstinfo a 
 JOIN trnsact b 
  ON a.sku=b.sku;

-- (d) Which skus are unique to specific tables?
-- unique skus in skuinfo table
SELECT a.sku, b.sku, c.sku
FROM skuinfo a
 LEFT JOIN skstinfo b
  ON a.sku = b.sku
 LEFT JOIN trnsact c 
  ON a.sku=c.sku
WHERE b.sku IS NULL AND c.sku IS NULL;

-- unique skus in skstinfo table
SELECT a.sku, b.sku, c.sku
FROM skuinfo a
 LEFT JOIN skstinfo b
  ON a.sku = b.sku
 LEFT JOIN trnsact c 
  ON a.sku=c.sku
WHERE a.sku IS NULL AND c.sku IS NULL;

-- unique skus in trnsact table
SELECT a.sku, b.sku, c.sku
FROM skuinfo a
 LEFT JOIN skstinfo b
  ON a.sku = b.sku
 LEFT JOIN trnsact c 
  ON a.sku=c.sku
WHERE a.sku IS NULL AND b.sku IS NULL;

-- (e) Determine how many instances there are of each sku associated with each store in the skstinfo table and the trnsact table?
SELECT sku, store, COUNT(sku)
FROM skstinfo
GROUP BY sku, store
ORDER BY COUNT(sku) DESC;

SELECT sku, store, COUNT(sku)
FROM trnsact 
GROUP BY sku, store
ORDER BY COUNT(sku) DESC;


-- Exercise 2 --
-- (a) Determine how many distinct stores there are in the strinfo, store_msa, skstinfo, and trnsact tables:
SELECT COUNT(DISTINCT store) 
FROM strinfo;

SELECT COUNT(DISTINCT store) 
FROM skstinfo;

SELECT COUNT(DISTINCT store) 
FROM store_msa;

SELECT COUNT(DISTINCT store) 
FROM trnsact;

-- (b) Which stores are common to all four tables?
SELECT a.store, b.store, c.store, d.store 
FROM strinfo a 
 JOIN skstinfo b
  ON a.store = b.store
 JOIN store_msa c 
  ON c.store = a.store
 JOIN trnsact d 
  ON c.store = d.store;
 
 -- (c) Which stores are unique to specific tables?
-- unique stores in strinfo table
SELECT a.store, b.store, c.store, d.store
FROM strinfo a
 LEFT JOIN skstinfo b
  ON a.store = b.store
 LEFT JOIN store_msa c 
  ON a.store = c.store
 LEFT JOIN trnsact d 
  ON  d.store = c.store
WHERE b.store IS NULL AND c.store IS NULL AND d.store IS NULL;

-- unique stores in skstinfo table
SELECT a.store, b.store, c.store, d.store
FROM strinfo a
 LEFT JOIN skstinfo b
  ON a.store = b.store
 LEFT JOIN store_msa c 
  ON a.store = c.store
 LEFT JOIN trnsact d 
  ON  d.store = c.store
WHERE a.store IS NULL AND c.store IS NULL AND d.store IS NULL;

-- unique stores in store_msa table
SELECT a.store, b.store, c.store, d.store
FROM strinfo a
 LEFT JOIN skstinfo b
  ON a.store = b.store
 LEFT JOIN store_msa c 
  ON a.store = c.store
 LEFT JOIN trnsact d 
  ON  d.store = c.store
WHERE a.store IS NULL AND b.store IS NULL AND d.store IS NULL;

-- unique stores in trnsact table
SELECT a.store, b.store, c.store, d.store
FROM strinfo a
 LEFT JOIN skstinfo b
  ON a.store = b.store
 LEFT JOIN store_msa c 
  ON a.store = c.store
 LEFT JOIN trnsact d 
  ON  d.store = c.store
WHERE a.store IS NULL AND b.store IS NULL AND c.store IS NULL;


-- Exercise 3 --
-- Examine some of the rows in the trnsact table that are not in the skstinfo table:
SELECT *
FROM trnsact t
 LEFT JOIN skstinfo s
   ON t.store = s.store AND t.sku = s.sku
WHERE s.sku IS NULL
ORDER BY t.sku DESC;


-- Exercise 4 --
-- What is the company’s average profit per day? 
SELECT SUM(t.amt - s.cost * t.quantity) / COUNT(DISTINCT t.saledate) AS avg_daily_profit
FROM trnsact t
 LEFT JOIN skstinfo s
  ON s.sku = t.sku AND s.store = t.store
WHERE t.stype = 'P';

-- Find the average profit per day from register 640:
SELECT SUM(t.amt - s.cost * t.quantity) / COUNT(DISTINCT t.saledate) AS avg_daily_profit
FROM trnsact t
 LEFT JOIN skstinfo s
  ON s.sku = t.sku AND s.store = t.store
WHERE t.stype = 'P' AND register = '640';


-- Exercise 5 --
-- On what day was the total value (in $) of returned goods the greatest?
SELECT TOP 1 saledate, SUM(amt) 
FROM trnsact
WHERE stype = 'R'
GROUP BY saledate
ORDER BY SUM(amt) DESC;

-- On what day was the total number of individual returned items the greatest? 
SELECT TOP 1 saledate, SUM(quantity) 
FROM trnsact
WHERE stype = 'R'
GROUP BY saledate
ORDER BY SUM(quantity) DESC;


-- Exercise 6 --
-- What is the maximum price paid for an item in our database?
SELECT MAX(orgprice)
FROM trnsact 
WHERE stype = 'P';

SELECT MAX(sprice)
FROM trnsact 
WHERE stype = 'P';

SELECT MAX(amt/quantity)
FROM trnsact 
WHERE stype = 'P';

SELECT MAX(retail)
FROM skstinfo;

-- What is the minimum price paid for an item in our database? 
SELECT MIN(orgprice)
FROM trnsact 
WHERE stype = 'P';

SELECT MIN(sprice)
FROM trnsact 
WHERE stype = 'P';

SELECT MIN(amt/quantity)
FROM trnsact 
WHERE stype = 'P';

SELECT MIN(retail)
FROM skstinfo;


-- Exercise 7 --
-- How many departments have more than 100 brands associated with them, and what are their descriptions? 
SELECT s.dept, d.deptdesc, COUNT(DISTINCT s.brand) 
FROM skuinfo s 
 LEFT JOIN deptinfo d 
  ON s.dept = d.dept
GROUP BY s.dept, d.deptdesc
HAVING COUNT(DISTINCT s.brand) > 100;

-- Exercise 8 --
-- Write a query that retrieves the department descriptions of each of the skus in the skstinfo table. 
SELECT a.sku, c.deptdesc
FROM skstinfo a
 LEFT JOIN skuinfo b
  ON a.sku = b.sku
 LEFT JOIN deptinfo c
  ON b.dept = c.dept 
GROUP BY a.sku, c.deptdesc;


-- Exercise 9 --
-- What department (with department description), brand, style, and color had the greatest total value of returned items? 
SELECT TOP 1 d.dept, d.deptdesc, 
s.brand, s.style, s.color,
SUM(t.amt) 
FROM deptinfo d
 LEFT JOIN skuinfo s
  ON d.dept = s.dept
 LEFT JOIN trnsact t
  ON s.sku = t.sku
WHERE t.stype = 'R'
GROUP BY d.dept, d.deptdesc, s.brand, s.style, s.color
ORDER BY SUM(t.amt) DESC;


-- Exercise 10 --
-- In what state, city and zip code is the store that had the greatest total revenue during the time period monitored in our dataset? 
SELECT TOP 1 s.state, s.city, s.zip, SUM(t.amt)
FROM strinfo s
 LEFT JOIN trnsact t
  ON s.store = t.store
WHERE t.stype = 'P'
GROUP BY s.state, s.city, s.zip
ORDER BY SUM(t.amt) DESC;
