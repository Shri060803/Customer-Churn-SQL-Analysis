# Customer Churn Analysis Using SQL

## Project Overview
This project analyzes customer churn in a telecommunications dataset using MySQL. The analysis focuses on customer demographics, tenure, services, contract types, payment methods, and billing information to identify patterns associated with customer churn.

## Objectives
- Analyze customer churn and retention.
- Calculate overall churn rate.
- Compare churn across different customer segments.
- Analyze contract, payment, and service-related churn.
- Identify segments with higher observed churn rates.

## Dataset
The dataset contains customer information including:
- Demographics
- Tenure
- Phone and Internet services
- Online Security and Tech Support
- Contract and Payment Method
- Monthly and Total Charges
- Churn status

## Data Cleaning
Performed:
- Record count check
- Data structure check
- Duplicate customer ID check
- NULL value check
- Blank value check

## SQL Analysis
The project includes:
- Total, active, and churned customers
- Overall churn rate
- Churn by gender and senior citizen status
- Churn by contract type
- Churn by payment method
- Churn by internet service
- Churn by online security and tech support
- Average monthly and total charges by churn status
- Customer tenure analysis
- Contract and payment method analysis
- Consolidated churn factor analysis

## Key Insights
The analysis shows differences in churn rates across customer segments. Some contract types, payment methods, internet services, and subscribed services show higher observed churn rates.

The consolidated analysis ranks these segments based on their observed churn rate.

> Note: The analysis identifies associations in the dataset and does not establish direct causation.

## Tools & Technologies
- MySQL
- SQL
- MySQL Workbench
- GitHub

## SQL Concepts Used
`SELECT`, `WHERE`, `COUNT()`, `SUM()`, `AVG()`, `ROUND()`, `GROUP BY`, `ORDER BY`, `CASE WHEN`, `UNION ALL`, subqueries, conditional aggregation, and percentage calculations.

## Project Structure

Customer-Churn-SQL-Analysis/
- README.md
- customer_churn_analysis.sql
