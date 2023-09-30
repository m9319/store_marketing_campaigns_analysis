USE marketing_campaign;

SELECT * FROM customer_details;

SELECT * FROM campaign_results;

SELECT * FROM deals_taken;


-- DATA CLEANING (DC)

-- DC 1. CHANGING THE NAME FORMAT

ALTER TABLE customer_details
RENAME COLUMN `Birth Year` TO `birth_year`; 

ALTER TABLE customer_details
RENAME COLUMN `Kids Count` TO `kids_count`;

ALTER TABLE customer_details
RENAME COLUMN `Teens Count` TO`teens_count`;

ALTER TABLE customer_details
RENAME COLUMN `Join Date` TO `join_date`;

ALTER TABLE customer_details
RENAME COLUMN `Last Purchase` TO `last_purchase`;

ALTER TABLE customer_details
RENAME COLUMN `Join Year` TO `join_year`;

ALTER TABLE customer_details
RENAME COLUMN `Join Month` TO `join_month`;


ALTER TABLE campaign_results
RENAME COLUMN `Results-Campaign3`TO `Results_Campaign3`;

ALTER TABLE campaign_results
RENAME COLUMN `Results-Campaign4`TO `Results_Campaign4`;

ALTER TABLE campaign_results
RENAME COLUMN `Results-Campaign5`TO `Results_Campaign5`;

ALTER TABLE campaign_results
RENAME COLUMN `Results-Campaign1`TO `Results_Campaign1`;

ALTER TABLE campaign_results
RENAME COLUMN `Results-Campaign2`TO `Results_Campaign2`;


ALTER TABLE deals_taken
RENAME COLUMN `Deals-Discounted`TO `deals_discounted`;

ALTER TABLE deals_taken
RENAME COLUMN `Deals-Website`TO `deals_website`;

ALTER TABLE deals_taken
RENAME COLUMN `Deals-Catalogue`TO `deals_catalogue`;

ALTER TABLE deals_taken
RENAME COLUMN `Deals-Store`TO `deals_store`;

ALTER TABLE deals_taken
RENAME COLUMN `Website Visits`TO `website_visits`;




-- DC 2. TRIMMING COLUMNS TO REMOVE ALL STARTING AND TRAILING SPACES

UPDATE `customer_details` SET `ID` = TRIM(`ID`);                           
UPDATE `customer_details` SET `birth_year` = TRIM(`birth_year`);
UPDATE `customer_details` SET `Education` = TRIM(`Education`);                           
UPDATE `customer_details` SET `marital_status` = TRIM(`marital_status`);                           
UPDATE `customer_details` SET `Income` = TRIM(`Income`);                           
UPDATE `customer_details` SET `kids_count` = TRIM(`kids_count`);                           
UPDATE `customer_details` SET `teens_count` = TRIM(`teens_count`);                           
UPDATE `customer_details` SET `last_purchase` = TRIM(`last_purchase`);                           
UPDATE `customer_details` SET `Amount-Wines` = TRIM(`amount_wines`);                           
UPDATE `customer_details` SET `Amount-Fruits` = TRIM(`amount_fruits`);                           
UPDATE `customer_details` SET `Amount-Meat` = TRIM(`amount_meat`);                           
UPDATE `customer_details` SET `Amount-Fish` = TRIM(`amount_fish`);                           
UPDATE `customer_details` SET `Amount-Sweets` = TRIM(`amount_sweets`);                           
UPDATE `customer_details` SET `Amount-Gold` = TRIM(`amount_gold`);                                                                                
UPDATE `customer_details` SET `join_year` = TRIM(`join_year`);                                                                                
UPDATE `customer_details` SET `join_month` = TRIM(`join_month`);    

UPDATE `campaign_results` SET `Results_Campaign3` = TRIM(`Results_Campaign3`);                         
UPDATE `campaign_results` SET `Results_Campaign4` = TRIM(`Results_Campaign4`);                              
UPDATE `campaign_results` SET `Results_Campaign5` = TRIM(`Results_Campaign5`);                              
UPDATE `campaign_results` SET `Results_Campaign1` = TRIM(`Results_Campaign1`);                              
UPDATE `campaign_results` SET `Results_Campaign2` = TRIM(`Results_Campaign2`);                              

UPDATE `campaign_results` SET `deals_discounted` = TRIM(`deals_discounted`);       
UPDATE `campaign_results` SET `deals_website` = TRIM(`deals_website`);       
UPDATE `campaign_results` SET `deals_catalogue` = TRIM(`deals_catalogue`);       
UPDATE `campaign_results` SET `deals_store` = TRIM(`deals_store`);       
UPDATE `campaign_results` SET `website_visits` = TRIM(`website_visits`);       




-- TO VIEW THE DATATYPES OF ALL THE FIELDS IN THE TABLE

SHOW FIELDS FROM customer_details;

-- DC 3. VIEWING AND REMOVING DATA WHERE AGE IS > 100

SELECT ID, (YEAR(CURRENT_DATE) - birth_year) AS age
FROM customer_details
ORDER BY age DESC;

SELECT *
FROM customer_details
	INNER JOIN campaign_results
		ON customer_details.ID = campaign_results.ID
	INNER JOIN deals_taken
		ON campaign_results.ID = deals_taken.ID
WHERE (YEAR(CURRENT_DATE) - birth_year) > 100;

DELETE FROM customer_details
WHERE (YEAR(CURRENT_DATE) - birth_year) > 100;

SELECT *
FROM customer_details
WHERE ID IN (1150, 7829, 11004);

DELETE FROM campaign_results
WHERE ID IN (1150, 7829, 11004);

SELECT *
FROM campaign_results
WHERE ID IN (1150, 7829, 11004);

DELETE FROM deals_taken
WHERE ID IN (1150, 7829, 11004);

SELECT *
FROM deals_taken
WHERE ID IN (1150, 7829, 11004);

-- DC 4. DROPPING COLUMNS THAT DO NOT ADD ANY VALUE

ALTER TABLE campaign_results
DROP COLUMN Complain;

ALTER TABLE customer_details
DROP COLUMN `last_purchase`;

ALTER TABLE campaign_results
DROP COLUMN `join_year`;                           
                           
ALTER TABLE campaign_results
DROP COLUMN `join_month`;  
                      

-- DC 5. To rearrange the Results_Campaign columns from 1st to 5th

ALTER TABLE campaign_results
MODIFY COLUMN Results_Campaign1 TEXT AFTER ID; -- column moves to the 2nd place

ALTER TABLE campaign_results
MODIFY COLUMN Results_Campaign2 TEXT AFTER Results_Campaign1;

-- DC 6. Now changing False to 0 and True to 1.

UPDATE campaign_results
SET Results_Campaign1 = (CASE WHEN Results_Campaign1 = 'TRUE' THEN 1
                           WHEN Results_Campaign1 = 'FALSE' THEN 0
                           END); -- works!
                           
UPDATE campaign_results
SET Results_Campaign2 = (CASE WHEN Results_Campaign2 = 'TRUE' THEN 1
                           WHEN Results_Campaign2 = 'FALSE' THEN 0
                           END);

UPDATE campaign_results
SET Results_Campaign3 = (CASE WHEN Results_Campaign3 = 'TRUE' THEN 1
                           WHEN Results_Campaign3 = 'FALSE' THEN 0
                           END);

UPDATE campaign_results
SET Results_Campaign4 = (CASE WHEN Results_Campaign4 = 'TRUE' THEN 1
                           WHEN Results_Campaign4 = 'FALSE' THEN 0
                           END);

UPDATE campaign_results
SET Results_Campaign5 = (CASE WHEN Results_Campaign5 = 'TRUE' THEN 1
                           WHEN Results_Campaign5 = 'FALSE' THEN 0
                           END);

-- DC 7. changing the datatype of the results_campaign fileds to boolean

ALTER TABLE campaign_results    
MODIFY Results_Campaign1 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign2 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign3 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign4 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign5 TINYINT;  -- The data type was text before these queries were executed



SELECT * FROM customer_details;
SELECT * FROM campaign_results;
SELECT * FROM deals_taken;

-- Analyzing the data (DA)


-- DA 1. COUNT OF CUSTOMERS BY EDUCATION

SELECT DISTINCT Education, COUNT(*) AS num_of_customers
FROM customer_details
GROUP BY Education
ORDER BY num_of_customers DESC;

-- O/P - Graduation - 1126, PhD - 483, Master - 369, 2n Cycle - 201, Basic - 54


-- O/P - Married - 864, Together - 580, Single - 480, Divorced - 232, Widow - 77, Alone - 3, YOLO - 2, Absurd - 2

-- Since alone is similiar to Single, the status for alone can be chnaged to single, YOLO, absurd can be removed since
-- just 4 records have YOLO as the marital_status. 

UPDATE customer_details
SET marital_status = 'Single'
WHERE marital_status = 'Alone';

DELETE
FROM customer_details
WHERE marital_status = 'YOLO'
	OR marital_status = 'Absurd';

-- COUNT OF CUSTOMERS AS PER MARITAL STATUS

SELECT DISTINCT marital_status, COUNT(*) AS num_of_customers
FROM customer_details
GROUP BY marital_status
ORDER BY num_of_customers DESC;

-- O/P - Married - 864, Together - 580, Single - 483, Divorced - 232, Widow - 77

-- CAMPAIGN SUCCESS RATES

WITH CTE AS(

SELECT

	SUM(CASE WHEN Results_Campaign1 = 1 THEN 1 ELSE 0 END) AS success_campaign1,
    SUM(CASE WHEN Results_Campaign2 = 1 THEN 1 ELSE 0 END) AS success_campaign2,
    SUM(CASE WHEN Results_Campaign3 = 1 THEN 1 ELSE 0 END) AS success_campaign3,
    SUM(CASE WHEN Results_Campaign4 = 1 THEN 1 ELSE 0 END) AS success_campaign4,
    SUM(CASE WHEN Results_Campaign5 = 1 THEN 1 ELSE 0 END) AS success_campaign5,
    -- SUM(Results_Campaign1 + Results_Campaign2 + Results_Campaign3 + Results_Campaign4 + Results_Campaign5) AS campaign_total
	COUNT(*) AS campaign_total
FROM
    campaign_results)

SELECT 
	success_campaign1 / campaign_total AS success_rate_campaign1,
    success_campaign2 / campaign_total AS success_rate_campaign2,
	success_campaign3 / campaign_total AS success_rate_campaign3,
    success_campaign4 / campaign_total AS success_rate_campaign4,
    success_campaign5 / campaign_total AS success_rate_campaign5
FROM 
	CTE;


-- INCOME TO EXPENSE RATIO FOR CUSTOMERS

SELECT
    cd.ID AS customer_ID,
    -- cd.Education,
    cd.Income,
    SUM(cd.Amount_Wines + cd.Amount_Fruit + cd.Amount_Meat + cd.Amount_Fish + cd.Amount_Sweets + cd.Amount_Gold) AS amt_spent,
	((SUM(cd.Amount_Wines + cd.Amount_Fruit + cd.Amount_Meat + cd.Amount_Fish + cd.Amount_Sweets + cd.Amount_Gold)) / Income) * 100 AS spend_pc

FROM
    customer_details cd
GROUP BY 1,2
ORDER BY spend_pc DESC;


-- CUSTOMERS WHO HAVE NOT USED ANY DEAL
	
WITH more_than_2 AS (

	SELECT
		customer_details.ID AS cust_ID,
		SUM( deals_discounted + deals_website + deals_catalogue + deals_store ) AS num_of_deals_taken
	FROM customer_details
		LEFT JOIN deals_taken
			ON customer_details.ID = deals_taken.ID
	GROUP BY customer_details.ID
	ORDER BY num_of_deals_taken DESC
    )
    
    SELECT 
		cust_ID,
        num_of_deals_taken
	FROM more_than_2
    WHERE num_of_deals_taken = 0;


SELECT * FROM customer_details;
SELECT * FROM campaign_results;
SELECT * FROM deals_taken;


SELECT CURRENT_DATE - INTERVAL FLOOR(RAND() * 28) DAY;


select date_format(
    from_unixtime(
         rand() * 
            (unix_timestamp('2012-11-13 16:00:00') - unix_timestamp('2014-12-31 23:00:00')) + 
             unix_timestamp('2014-12-31 23:00:00')
                  ), '%Y-%m-%d %H:%i:%s') as datum_roden
;











