-- Create the database
CREATE DATABASE IF NOT EXISTS MarketingDB;

-- Use the database
USE MarketingDB;

-- Create the table
CREATE TABLE IF NOT EXISTS marketing_campaign (
    ID INT,
    Year_Birth INT,
    Education VARCHAR(50),
    Marital_Status VARCHAR(50),
    Income FLOAT,
    Kidhome INT,
    Teenhome INT,
    Dt_Customer DATE,
    Recency INT,
    MntWines INT,
    MntFruits INT,
    MntMeatProducts INT,
    MntFishProducts INT,
    MntSweetProducts INT,
    MntGoldProds INT,
    NumDealsPurchases INT,
    NumWebPurchases INT,
    NumCatalogPurchases INT,
    NumStorePurchases INT,
    NumWebVisitsMonth INT,
    AcceptedCmp1 INT,
    AcceptedCmp2 INT,
    AcceptedCmp3 INT,
    AcceptedCmp4 INT,
    AcceptedCmp5 INT,
    Response INT,
    Complain INT,
    Country VARCHAR(50),
    CampaignMonth INT
);

