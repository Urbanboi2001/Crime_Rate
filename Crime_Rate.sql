-- Check if the entries in the table are equal with respect to UOM to prevent
-- double counting  
USE crime_rate;
SELECT UOM, count(year) FROM violent_and_sexual_crime
group by UOM;

-- Delete one UOM type to prevent double counting
DELETE FROM violent_and_sexual_crime
WHERE UOM = 'Counts';

-- No of cases per 100 thousand for each coutnry , year wise Top ten country

With CTE as (SELECT Country, SUM(Value) FROM violent_and_sexual_crime 
GROUP BY Country
ORDER BY 2 DESC
Limit 10)
SELECT Year, Country, SUM(Value) AS Count_per_lakh FROM violent_and_sexual_crime
WHERE Country IN (SELECT Country FROM CTE)
GROUP BY Country,Year
ORDER BY Country;

-- No of cases per 100 thousand for country lowest 20 countries
With CTE as (SELECT Country, SUM(Value) FROM violent_and_sexual_crime 
GROUP BY Country
ORDER BY 2 ASC
Limit 20)
SELECT Country, SUM(Value) AS Count_per_100K FROM violent_and_sexual_crime
WHERE Country IN (SELECT Country FROM CTE)
GROUP BY Country
ORDER BY 2 Asc;

-- Total No of cases country wise
SELECT Country, SUM(Value) AS Total_Count_per_lakh FROM violent_and_sexual_crime
GROUP BY Country
ORDER BY 2;


-- Averge No of cases by region
SELECT Region, AVG(Value) AS Total_Count_per_100K FROM violent_and_sexual_crime
GROUP BY Region
ORDER BY 2;

-- Average No of cases by indicator
SELECT Indicator, AVG(Value) AS Average_Count_per_lakh FROM violent_and_sexual_crime
GROUP BY Indicator
ORDER BY 1;

-- Average No of cases by relationship to perpetrator
SELECT Category, AVG(Value) AS Average_Count_per_lakh FROM violent_and_sexual_crime
WHERE Dimension = "by relationship to perpetrator"
GROUP BY Category
ORDER BY 1;

-- Average No of cases by Type of offence
SELECT Category, AVG(Value) AS Average_Count_per_lakh FROM violent_and_sexual_crime
WHERE Dimension = "by type of offence"
GROUP BY Category
ORDER BY 1;

-- Average No of cases by Sex
SELECT Sex, AVG(Value) AS Count_per_100K FROM violent_and_sexual_crime
WHERE Sex IN ('Male','Female')
GROUP BY Sex
ORDER BY 1;

