USE marketing_campaign;

SELECT * FROM customer_details;

SELECT * FROM campaign_results;

SELECT * FROM deals_taken;


-- DATA CLEANING (DC)

-- DC 1. Changing the name format of columns

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



-- DC 2. Trimming columns to remove all starting and trailing spaces

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


-- DC 3. Viewing and removing data where the customer's age is > 100

SELECT ID, (YEAR(CURRENT_DATE) - birth_year) AS age
FROM customer_details
ORDER BY age DESC; -- There are 3 customers with age above 100 years, cust ID - 1150, 7829, 11004.

DELETE FROM customer_details
WHERE ID IN (1150, 7829, 11004);

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



-- DC 4. Dropping columns that do not add any value

ALTER TABLE campaign_results
DROP COLUMN Complain; -- blank column

ALTER TABLE customer_details
DROP COLUMN `last_purchase`; -- no relevant data for any record

ALTER TABLE campaign_results
DROP COLUMN `join_year`; -- duplicate column                          
                           
ALTER TABLE campaign_results
DROP COLUMN `join_month`; -- duplicate column
                      

-- DC 5. Rearranging the Results_Campaign columns in order from 1st to 5th (The column order was 2, 1, 3, 4, 5)

ALTER TABLE campaign_results
MODIFY COLUMN Results_Campaign1 TEXT AFTER ID; -- column moves to the 2nd place

ALTER TABLE campaign_results
MODIFY COLUMN Results_Campaign2 TEXT AFTER Results_Campaign1; -- the columns are in order

-- DC 6. The entries in the campaign_results table are 'True' or 'False', changing the data in the campaign_results table from false to 0 and true to 1.

UPDATE campaign_results
SET Results_Campaign1 = (CASE WHEN Results_Campaign1 = 'TRUE' THEN 1
                           WHEN Results_Campaign1 = 'FALSE' THEN 0
                           END);
                           
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

-- DC 7. changing the datatype of the results_campaign fields to tinyint ( The data type was text initially.)

ALTER TABLE campaign_results    
MODIFY Results_Campaign1 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign2 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign3 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign4 TINYINT;  

ALTER TABLE campaign_results    
MODIFY Results_Campaign5 TINYINT;  


-- Analyzing the data (DA)


-- DA 1. Count of customers by Education 

SELECT DISTINCT Education, COUNT(*) AS num_of_customers
FROM customer_details
GROUP BY Education
ORDER BY num_of_customers DESC;

-- O/P - Graduation - 1126, PhD - 483, Master - 369, 2n Cycle - 201, Basic - 54


-- DA 2. Count of customers by marital status

SELECT DISTINCT marital_status, COUNT(*) AS num_of_customers
FROM customer_details
GROUP BY marital_status
ORDER BY num_of_customers DESC;


-- O/P A) - Married - 864, Together - 580, Single - 480, Divorced - 232, Widow - 77, Alone - 3, YOLO - 2, Absurd - 2

-- Other values in marital status columns:
-- i) Alone - Alone is similar to 'Single' and hence would be included in the 'Single' type.
-- ii) YOLO, absurd  - These would be removed.

UPDATE customer_details
SET marital_status = 'Single'
WHERE marital_status = 'Alone';

DELETE
FROM customer_details
WHERE marital_status = 'YOLO'
	OR marital_status = 'Absurd';

-- Therefore, the count of customers as per marital status is:

SELECT DISTINCT marital_status, COUNT(*) AS num_of_customers
FROM customer_details
GROUP BY marital_status
ORDER BY num_of_customers DESC;

-- O/P B) - Married - 864, Together - 580, Single - 483, Divorced - 232, Widow - 77



-- DA 3. Campaign success rates

WITH CTE AS (

SELECT

    SUM(CASE WHEN Results_Campaign1 = 1 THEN 1 ELSE 0 END) AS success_campaign1,
    SUM(CASE WHEN Results_Campaign2 = 1 THEN 1 ELSE 0 END) AS success_campaign2,
    SUM(CASE WHEN Results_Campaign3 = 1 THEN 1 ELSE 0 END) AS success_campaign3,
    SUM(CASE WHEN Results_Campaign4 = 1 THEN 1 ELSE 0 END) AS success_campaign4,
    SUM(CASE WHEN Results_Campaign5 = 1 THEN 1 ELSE 0 END) AS success_campaign5,
    COUNT(*) AS campaign_total
FROM
    campaign_results 
	     )

SELECT 
	success_campaign1 / campaign_total AS success_rate_campaign1,
    success_campaign2 / campaign_total AS success_rate_campaign2,
	success_campaign3 / campaign_total AS success_rate_campaign3,
    success_campaign4 / campaign_total AS success_rate_campaign4,
    success_campaign5 / campaign_total AS success_rate_campaign5
FROM 
	CTE; -- success rates for campaign1 - 0.0644, campaign2 - 0.0134, campaign3 - 0.0729, campaign4 - 0.0747, campaign5 - 0.0724, campaign4 was the most successful of all


-- DA 4. Income to expense ratio for all customers

SELECT
    cd.ID AS customer_ID,
    cd.Income,
    SUM(cd.Amount_Wines + cd.Amount_Fruit + cd.Amount_Meat + cd.Amount_Fish + cd.Amount_Sweets + cd.Amount_Gold) AS amt_spent,
    ((SUM(cd.Amount_Wines + cd.Amount_Fruit + cd.Amount_Meat + cd.Amount_Fish + cd.Amount_Sweets + cd.Amount_Gold)) / Income) * 100 AS spend_pc

FROM
    customer_details cd
GROUP BY 1,2
ORDER BY spend_pc DESC;


-- DA 5. Customers who did not use any deal
	
WITH zero_deals AS (

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
    FROM zero_deals
    WHERE num_of_deals_taken = 0; -- O/P cust IDs - 3955, 5555, 11110, 11181 did not use any deals




