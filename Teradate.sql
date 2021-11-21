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

