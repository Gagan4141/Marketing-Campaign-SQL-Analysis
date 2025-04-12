-- Customer segments based on income and total spending
SELECT 
    CASE 
        WHEN Income < 30000 THEN 'Low Income'
        WHEN Income < 60000 THEN 'Middle Income'
        ELSE 'High Income'
    END AS Income_Group,
    COUNT(*) AS Customer_Count,
    ROUND(AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds), 2) AS Avg_Total_Spending
FROM marketing_campaign
WHERE Income IS NOT NULL
GROUP BY Income_Group
ORDER BY Avg_Total_Spending DESC;
-- Customers with their basic demographic information
SELECT 
    ID,
    Year_Birth AS Birth_Year,
    Education,
    Marital_Status,
    Income
FROM marketing_campaign
ORDER BY ID;
-- Household composition analysis
SELECT 
    Marital_Status,
    AVG(Kidhome) AS Avg_Kids_At_Home,
    AVG(Teenhome) AS Avg_Teens_At_Home,
    COUNT(*) AS Customer_Count
FROM marketing_campaign
GROUP BY Marital_Status
ORDER BY Customer_Count DESC;
-- Customer enrollment by year
SELECT 
    YEAR(Dt_Customer) AS Enrollment_Year,
    COUNT(*) AS New_Customers
FROM marketing_campaign
GROUP BY YEAR(Dt_Customer)
ORDER BY Enrollment_Year;
-- Customers by recency of purchase
SELECT 
    CASE 
        WHEN Recency <= 30 THEN '0-30 days'
        WHEN Recency <= 60 THEN '31-60 days'
        WHEN Recency <= 90 THEN '61-90 days'
        ELSE '90+ days'
    END AS Recency_Bucket,
    COUNT(*) AS Customer_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM marketing_campaign), 2) AS Percentage
FROM marketing_campaign
GROUP BY Recency_Bucket
ORDER BY Recency_Bucket;

-- Average spending by product category
SELECT 
    ROUND(AVG(MntWines), 2) AS Avg_Wine_Spending,
    ROUND(AVG(MntFruits), 2) AS Avg_Fruit_Spending,
    ROUND(AVG(MntMeatProducts), 2) AS Avg_Meat_Spending,
    ROUND(AVG(MntFishProducts), 2) AS Avg_Fish_Spending,
    ROUND(AVG(MntSweetProducts), 2) AS Avg_Sweet_Spending,
    ROUND(AVG(MntGoldProds), 2) AS Avg_Gold_Spending
FROM marketing_campaign;
-- Customer purchase channels
SELECT 
    ROUND(AVG(NumDealsPurchases), 2) AS Avg_Deal_Purchases,
    ROUND(AVG(NumWebPurchases), 2) AS Avg_Web_Purchases,
    ROUND(AVG(NumCatalogPurchases), 2) AS Avg_Catalog_Purchases,
    ROUND(AVG(NumStorePurchases), 2) AS Avg_Store_Purchases,
    ROUND(AVG(NumWebVisitsMonth), 2) AS Avg_Web_Visits
FROM marketing_campaign;
-- Campaign acceptance rates
SELECT 
    SUM(AcceptedCmp1) AS Cmp1_Accepted,
    SUM(AcceptedCmp2) AS Cmp2_Accepted,
    SUM(AcceptedCmp3) AS Cmp3_Accepted,
    SUM(AcceptedCmp4) AS Cmp4_Accepted,
    SUM(AcceptedCmp5) AS Cmp5_Accepted,
    SUM(Response) AS Latest_Campaign_Response,
    COUNT(*) AS Total_Customers
FROM marketing_campaign;
-- Customers with complaints
SELECT 
    Complain,
    COUNT(*) AS Customer_Count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM marketing_campaign), 2) AS Percentage
FROM marketing_campaign
GROUP BY Complain;
-- Identifying high-value customers (top 10% spenders)
WITH CustomerSpending AS (
    SELECT 
        ID,
        (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS Total_Spending,
        NTILE(10) OVER (ORDER BY (MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) DESC) AS Spending_Decile
    FROM marketing_campaign
)
SELECT 
    c.ID,
    c.Year_Birth,
    c.Education,
    c.Income,
    cs.Total_Spending,
    cs.Spending_Decile
FROM marketing_campaign c
JOIN CustomerSpending cs ON c.ID = cs.ID
WHERE cs.Spending_Decile = 1
ORDER BY cs.Total_Spending DESC;
SELECT * FROM marketing_campaign
LIMIT 5;
SELECT 
    CASE 
        WHEN NumWebPurchases > NumCatalogPurchases AND NumWebPurchases > NumStorePurchases THEN 'Web'
        WHEN NumCatalogPurchases > NumWebPurchases AND NumCatalogPurchases > NumStorePurchases THEN 'Catalog'
        WHEN NumStorePurchases > NumWebPurchases AND NumStorePurchases > NumCatalogPurchases THEN 'Store'
        ELSE 'Mixed'
    END AS primary_channel,
    COUNT(*) AS customer_count,
    SUM(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS total_spending,
    AVG(MntWines + MntFruits + MntMeatProducts + MntFishProducts + MntSweetProducts + MntGoldProds) AS avg_spending_per_customer,
    SUM(NumDealsPurchases) AS total_deal_purchases,
    SUM(NumWebVisitsMonth) AS total_web_visits
FROM marketing_campaign
GROUP BY primary_channel
ORDER BY avg_spending_per_customer DESC;
