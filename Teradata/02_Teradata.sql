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




















