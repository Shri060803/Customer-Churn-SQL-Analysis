create database customers;
use customers;

RENAME TABLE `tele communication dataset`
TO tele_com_data;

SHOW TABLES FROM customers;
select * from tele_com_data;


							### Data Cleaning ###

#total Number of records
SELECT COUNT(*)
FROM tele_com_data;

#data structure check 
describe tele_com_data;

#duplicate check 
SELECT customerID,
COUNT(*) AS total
FROM tele_com_data
GROUP BY customerID
HAVING COUNT(*) > 1;

# NULL values
SELECT
SUM(customerID IS NULL) AS customerID_null,
SUM(gender IS NULL) AS gender_null,
SUM(tenure IS NULL) AS tenure_null,
SUM(MonthlyCharges IS NULL) AS monthly_null,
SUM(TotalCharges IS NULL) AS total_null,
SUM(Churn IS NULL) AS churn_null
FROM tele_com_data;

#blank values
SELECT *
FROM tele_com_data
WHERE TRIM(TotalCharges) = '';

						### EDA ###
                        
#Total Customers
select count(*) as total_customers
from tele_com_data;

#Total Churned customers
select count(*) as churned_customers
from tele_com_data
where Churn = 'Yes';

#Total Active Customers
select count(*) as churned_customers
from tele_com_data
where Churn = 'Yes';

#Total number of customers
SELECT COUNT(*) AS total_customers
FROM tele_com_data;

#Churn and notr churn
SELECT 
    Churn,
    COUNT(*) AS customer_count
FROM tele_com_data
GROUP BY Churn;

#Churn Rate
SELECT 
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2
) AS churn_rate_percentage
FROM tele_com_data;

#Churn rate by gender
SELECT 
    gender,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*), 
        2
    ) AS churn_rate
FROM tele_com_data
GROUP BY gender;

#Churn rate by senior Citizen 
SELECT
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM tele_com_data
GROUP BY SeniorCitizen;

#Churn Rate by contract type of customer
SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM tele_com_data
GROUP BY Contract
ORDER BY churn_rate DESC;

#churn by payment method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS churn_rate
FROM tele_com_data
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

#Churned vs Active(Monthly Average)
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges
FROM tele_com_data
GROUP BY Churn;

#Churned vs Active(Total Average)
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM tele_com_data
GROUP BY Churn;

#Tenure by month
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(tenure), 2) AS avg_tenure_months
FROM tele_com_data
GROUP BY Churn;

# CUSTOMER BY TENURE
SELECT tenure, COUNT(*) AS customer_count
FROM tele_com_data
GROUP BY tenure
ORDER BY tenure;

#Churn By Service
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate
FROM tele_com_data
GROUP BY InternetService
ORDER BY churn_rate DESC;

#Churn by Pyment Method
SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate
FROM tele_com_data
GROUP BY PaymentMethod
ORDER BY churn_rate DESC;

#Charges by Churn Status
SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS avg_monthly_charges,
    ROUND(AVG(TotalCharges), 2) AS avg_total_charges
FROM tele_com_data
GROUP BY Churn;

#Churn customers
SELECT
    customerID,
    tenure,
    Contract,
    PaymentMethod,
    MonthlyCharges,
    TotalCharges
FROM tele_com_data
WHERE Churn = 'Yes'
  AND MonthlyCharges >= 80
ORDER BY MonthlyCharges DESC;

# Churn by Contract and Payment Method
SELECT
    Contract,
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate
FROM tele_com_data
GROUP BY Contract, PaymentMethod
ORDER BY churn_rate DESC;

# Analysis of Churn
SELECT Factor, Service_Type, Total_Customers, Churned_Customers,
       ROUND(Churned_Customers * 100.0 / Total_Customers, 2) AS Churn_Rate
FROM (
    SELECT 'Contract' AS Factor, Contract AS Service_Type,
           COUNT(*) AS Total_Customers,
           SUM(Churn = 'Yes') AS Churned_Customers
    FROM tele_com_data
    GROUP BY Contract
    UNION ALL
    SELECT 'Payment Method', PaymentMethod,
           COUNT(*), SUM(Churn = 'Yes')
    FROM tele_com_data
    GROUP BY PaymentMethod
    UNION ALL
    SELECT 'Internet Service', InternetService,
           COUNT(*), SUM(Churn = 'Yes')
    FROM tele_com_data
    GROUP BY InternetService
    UNION ALL
    SELECT 'Tech Support', TechSupport,
           COUNT(*), SUM(Churn = 'Yes')
    FROM tele_com_data
    GROUP BY TechSupport
    UNION ALL
    SELECT 'Online Security', OnlineSecurity,
           COUNT(*), SUM(Churn = 'Yes')
    FROM tele_com_data
    GROUP BY OnlineSecurity
) AS summary
ORDER BY Churn_Rate DESC;














































