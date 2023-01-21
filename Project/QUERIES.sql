#1
CREATE DATABASE house_price_regression;

USE house_price_regression;

/*
DROP TABLE IF EXISTS house_price_data;
CREATE TABLE house_price_data
(
`id`				BIGINT UNIQUE NOT NULL,
`bedrooms`			INT NOT NULL,
`bathrooms`			FLOAT NOT NULL,
`sqft_living`		INT NOT NULL,
`sqft_lot`			INT NOT NULL,
`floors`			INT NOT NULL,
`waterfront`		INT NOT NULL,
`view`				INT NOT NULL,
`condition`			INT NOT NULL,
`grade`				INT NOT NULL,
`sqft_above`		INT NOT NULL,
`sqft_basement`		INT NOT NULL,
`yr_built`			INT NOT NULL,
`yr_renovated`		INT NOT NULL,
`zipcode`			INT NOT NULL,
`lat`				FLOAT NOT NULL,
`long`				FLOAT NOT NULL,
`sqft_living15`		INT NOT NULL,
`sqft_lot15`		INT NOT NULL,
`price`				INT NOT NULL
);

SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;

LOAD DATA INFILE '/Users/pedro/Desktop/Ironhack/Projects/MidBootcampProject/data_mid_bootcamp_project_regression/regression_data.csv' INTO TABLE house_price_data 
FIELDS TERMINATED BY ',';
*/


#4
SELECT * FROM house_price_data;

#5
ALTER TABLE house_price_data DROP date;

SELECT * FROM house_price_data LIMIT 10;

#6
SELECT COUNT(*) as count_rows FROM house_price_data; -- It's missing 403 rows probably bc imported from the Wizard.

#7
SELECT DISTINCT(bedrooms) AS bedrooms_values FROM house_price_data ORDER BY bedrooms ASC;

SELECT DISTINCT(bathrooms) AS bathrooms_values FROM house_price_data ORDER BY bathrooms ASC; 

SELECT DISTINCT(floors) AS floors_values FROM house_price_data ORDER BY floors ASC;

SELECT DISTINCT(`condition`) AS condition_values FROM house_price_data ORDER BY `condition` ASC;

SELECT DISTINCT(grade) AS  grade_values FROM house_price_data ORDER BY  grade ASC;

#8
SELECT id FROM house_price_data ORDER BY price DESC LIMIT 10;

#9
SELECT AVG(price) AS avg_price FROM house_price_data;

#10
SELECT DISTINCT(bedrooms), ROUND(AVG(price),2) AS avg_price_by_bedrooms FROM house_price_data GROUP BY bedrooms;

SELECT DISTINCT(bedrooms), ROUND(AVG(sqft_living),2) AS avg_sqft_living_by_bedrooms FROM house_price_data GROUP BY bedrooms;

SELECT DISTINCT(waterfront), ROUND(AVG(price),2) AS avg_price_by_waterfront FROM house_price_data GROUP BY waterfront;

SELECT DISTINCT(`condition`), ROUND(AVG(grade),2) AS condition_grade FROM house_price_data GROUP BY `condition` ORDER BY `condition`;
-- Yes, they are positivly correlated.

#11
SELECT * FROM house_price_data
WHERE (bedrooms = 3 OR bedrooms = 4)
AND floors = 1
AND waterfront = 0
AND `condition` >= 3
AND grade >= 5
AND price <= 300000
ORDER BY price DESC, grade DESC, `condition` DESC, bedrooms DESC;

#12
SELECT id, price AS prices_above_twice_avg FROM house_price_data
HAVING price >= (SELECT 2*ROUND(AVG(price),2) FROM house_price_data)
ORDER BY price ASC;

#13
CREATE OR REPLACE VIEW price_above_twice_avg AS
SELECT id, price FROM house_price_data
HAVING price >= (SELECT 2*ROUND(AVG(price),2) FROM house_price_data)
ORDER BY price ASC;

SELECT * FROM price_above_twice_avg;

#14
CREATE OR REPLACE VIEW bedrooms_avg_price AS
SELECT bedrooms, ROUND(AVG(price),2) AS avg_price FROM house_price_data
WHERE (bedrooms = 3 OR bedrooms = 4)
GROUP BY bedrooms;

SELECT ABS(ROUND(SUM(

(SELECT avg_price FROM bedrooms_avg_price WHERE bedrooms = 3) 
- 
(SELECT avg_price FROM bedrooms_avg_price WHERE bedrooms = 4)

),2)) AS difference_bedrooms_avg_price_3_4;

#15
SELECT DISTINCT(zipcode) AS locations FROM house_price_data;

#16
SELECT id FROM house_price_data WHERE yr_renovated <> 0;

#17
SELECT * FROM house_price_data ORDER BY PRICE DESC LIMIT 1 OFFSET 10;



