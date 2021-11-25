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

-- (e) Determine how many instances there are of each sku associated with each store in the skstinfo table and the trnsact table?
















