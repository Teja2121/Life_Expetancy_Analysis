# World Life Expectancy Project
USE world_life_expectency;

# Data Cleaning
SELECT *
FROM world_life_expectancy
;

# First we find if there are any duplicated in the data

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM world_life_expectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year)) > 1
;

# Removing the duplicates
SELECT *
FROM (SELECT Row_ID,
CONCAT(Country, Year),
ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
FROM world_life_expectancy) AS Row_table
WHERE Row_Num > 1
;

DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN(
    SELECT Row_ID
	FROM (SELECT Row_ID,
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS Row_Num
	FROM world_life_expectancy) AS Row_table
	WHERE Row_Num > 1
    )
;


# Checking for missing values
SELECT *
FROM world_life_expectancy
WHERE status = ''
;

# Now we can fill these missing status values by using data from the table and filling them up
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE status != ''
;

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE status = 'Developing'
;

UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN(
	SELECT DISTINCT(Country)
	FROM world_life_expectancy
	WHERE status = 'Developing'
);


UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status != ''
AND t2.status = 'Developing'
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status != ''
AND t2.status = 'Developed'
;

# Next we populate the values that are blank in the Life expectancy column
SELECT *
FROM world_life_expectancy
WHERE `Life expectancy` = ''
;

SELECT Country, Year, `Life expectancy`
FROM world_life_expectancy
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`, 
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
	ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
WHERE t1.`Life expectancy` = ''
;

# EDA
# Check which countries did good with life expentencies

SELECT Country, MIN(`Life expectancy`) AS Min_Life, 
MAX(`Life expectancy`) AS Max_Life,
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 2) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years DESC
;

SELECT Country, MIN(`Life expectancy`) AS Min_Life, 
MAX(`Life expectancy`) AS Max_Life,
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`), 2) AS Life_Increase_15_Years
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC
;


#  Average Life Expectency of these countries
SELECT YEAR, ROUND(AVG(`Life expectancy`), 2) AS Average_Life_Expectany 
FROM world_life_expectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year
;

# Correlation between GDP and Life Expectancy
SELECT Country, ROUND(AVG(`Life expectancy`), 2) AS Life_Exp_AVG,
AVG(GDP) AS GDP
FROM world_life_expectancy 
GROUP BY Country
HAVING Life_Exp_AVG <> 0
AND GDP <> 0
ORDER BY GDP ASC
;

SELECT Country, ROUND(AVG(`Life expectancy`), 2) AS Life_Exp_AVG,
AVG(GDP) AS GDP
FROM world_life_expectancy 
GROUP BY Country
HAVING Life_Exp_AVG <> 0
AND GDP <> 0
ORDER BY GDP DESC
;

SELECT 
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) AS High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE NULL END) AS High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) AS Low_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE NULL END) AS Low_GDP_Life_Expectancy
FROM world_life_expectancy 
;

# Now the relation between the status of the country and the life_expectancy 
SELECT Status, ROUND(AVG(`Life expectancy`),1) AS AVG_Life_Exp_Dev
FROM world_life_expectancy
GROUP BY Status
;

# Check if there are more developed countries
SELECT Status, COUNT(DISTINCT Country) AS Country_Count, 
ROUND(AVG(`Life expectancy`),1) AS AVG_Life_Exp_Dev
FROM world_life_expectancy
GROUP BY Status
;

SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp_AVG, ROUND(AVG(BMI),1) AS BMI 
FROM world_life_expectancy 
GROUP BY Country
HAVING Life_Exp_AVG <> 0
AND BMI <> 0
ORDER BY BMI DESC
;

SELECT Country, ROUND(AVG(`Life expectancy`), 1) AS Life_Exp_AVG, ROUND(AVG(BMI),1) AS BMI 
FROM world_life_expectancy 
GROUP BY Country
HAVING Life_Exp_AVG <> 0
AND BMI <> 0
ORDER BY BMI ASC
;

# Adult mortality rate by using rolling total
SELECT Country,
Year, 
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
;

SELECT Country,
Year, 
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%'
;




