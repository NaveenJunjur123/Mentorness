use Task2;
select * from [dbo].[task2_1];

-- Q1
SELECT *
FROM [dbo].[task2_1]
WHERE Province IS NULL AND
	  [Country_Region] IS NULL AND
	  Latitude IS NULL AND
	  Longitude IS NULL AND
	  Date IS NULL AND
	  Confirmed IS NULL AND
	  Deaths IS NULL AND
	  Recovered IS NULL;

-- Q2
UPDATE [dbo].[task2_1]
SET Province = '0'
WHERE Province IS NULL;

UPDATE [dbo].[task2_1]
SET [Country_Region] = '0'
WHERE [Country_Region] IS NULL;

UPDATE [dbo].[task2_1]
SET Latitude = '0'
WHERE Latitude IS NULL;

UPDATE [dbo].[task2_1]
SET Longitude = '0'
WHERE Longitude IS NULL;

UPDATE [dbo].[task2_1]
SET Date = NULL
WHERE Date IS NULL;

UPDATE [dbo].[task2_1]
SET Confirmed = '0'
WHERE Confirmed IS NULL;

UPDATE [dbo].[task2_1]
SET Deaths = '0'
WHERE Deaths IS NULL;

UPDATE [dbo].[task2_1]
SET Recovered = '0'
WHERE Recovered IS NULL;


-- Q3
SELECT COUNT(*) AS Count_Of_Rows
FROM [dbo].[task2_1];


-- Q4
SELECT MIN(Date) AS Start_Date
FROM [dbo].[task2_1];

SELECT MAX(Date) AS End_Date
FROM [dbo].[task2_1];


-- Q5
SELECT COUNT(DISTINCT YEAR(Date) * 12 + MONTH(Date)) AS number_of_months
FROM [dbo].[task2_1];

-- Q6
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    AVG(confirmed) AS avg_confirmed,
    AVG(deaths) AS avg_deaths,
    AVG(recovered) AS avg_recovered
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    YEAR(Date),
    MONTH(Date);

-- Q7(Excluded 0)
WITH MonthlyStats AS (
    SELECT 
        YEAR(Date) AS year,
        MONTH(Date) AS month,
        Confirmed,
        Deaths,
        Recovered,
        ROW_NUMBER() OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY COUNT(*) DESC) AS rn_confirmed,
        ROW_NUMBER() OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY COUNT(*) DESC) AS rn_deaths,
        ROW_NUMBER() OVER (PARTITION BY YEAR(Date), MONTH(Date) ORDER BY COUNT(*) DESC) AS rn_recovered
    FROM 
        [dbo].[task2_1]
	WHERE 
        Confirmed <> 0 AND Deaths <> 0 AND Recovered <> 0
    GROUP BY 
        YEAR(Date),
        MONTH(Date),
        Confirmed,
        Deaths,
        Recovered
)
SELECT 
    year,
    month,
    Confirmed,
    Deaths,
    Recovered
FROM 
    MonthlyStats
WHERE 
    rn_confirmed = 1 OR rn_deaths = 1 OR rn_recovered = 1;


-- Q8
SELECT 
    YEAR(Date) AS year,
    MIN(confirmed) AS min_confirmed,
    MIN(deaths) AS min_deaths,
    MIN(recovered) AS min_recovered
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date);

-- Q9
SELECT 
    YEAR(Date) AS year,
    MAX(confirmed) AS max_confirmed,
    MAX(deaths) AS max_deaths,
    MAX(recovered) AS max_recovered
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date);

-- Q10
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths,
    SUM(recovered) AS total_recovered
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    YEAR(Date),
    MONTH(Date);

-- Q11
SELECT 
    SUM(confirmed) AS total_confirmed_cases
FROM 
    [dbo].[task2_1];

SELECT 
    AVG(confirmed) AS average_confirmed_cases
FROM 
    [dbo].[task2_1];


SELECT
	VARP(Confirmed) AS variance_confirmed_cases
FROM 
	[dbo].[task2_1];


SELECT 
    STDEV(confirmed) AS stdev_confirmed_cases
FROM 
    [dbo].[task2_1];


-- Q12
-- Total Deaths as per month
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    SUM(deaths) AS total_death_cases
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    YEAR(Date),
    MONTH(Date);

-- Average deaths as per month
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    AVG(deaths) AS average_death_cases
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    YEAR(Date),
    MONTH(Date);

-- Variance Deaths as per month 
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    ROUND(VARP(deaths),2) AS variance_death_cases
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    YEAR(Date),
    MONTH(Date);

-- Standard deviation Death as per month
SELECT 
    YEAR(Date) AS year,
    MONTH(Date) AS month,
    ROUND(STDEV(deaths),2) AS sd_death_cases
FROM 
    [dbo].[task2_1]
GROUP BY 
    YEAR(Date),
    MONTH(Date)
ORDER BY 
    YEAR(Date),
    MONTH(Date);


-- Q13
SELECT 
    SUM(Recovered) AS total_recovered_cases
FROM 
    [dbo].[task2_1];

SELECT 
    AVG(Recovered) AS average_recovered_cases
FROM 
    [dbo].[task2_1];


SELECT
	ROUND(VARP(Recovered),2) AS variance_recovered_cases
FROM 
	[dbo].[task2_1];


SELECT 
    ROUND(STDEV(Recovered),2) AS stdev_recovered_cases
FROM 
    [dbo].[task2_1];


-- Q14
SELECT TOP 1 Country_Region, MAX(Confirmed) AS Highest_Confirmed_Cases
FROM [dbo].[task2_1]
GROUP BY Confirmed, Country_Region
ORDER BY Confirmed DESC;

--  Q15(excluded 0)
SELECT TOP 1 Country_Region, Deaths AS Least_Death_Cases
FROM [dbo].[task2_1]
WHERE Deaths > 0
ORDER BY Deaths ASC;


-- Q16
SELECT TOP 5 Country_Region, MAX(Recovered) AS Highest_Recovered_Cases
FROM [dbo].[task2_1]
GROUP BY Country_Region
ORDER BY MAX(Recovered) DESC;

