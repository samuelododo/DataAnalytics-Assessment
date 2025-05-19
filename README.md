# DataAnalytics-Assessment
Data Analyst TecThis repository provides solutions to the Cowrywise Data Analytics technical assessment, with each of the four questions addressed in individual SQL scripts for better structure and readability.

This repository contains solutions to four SQL-based assessment questions designed to evaluate data analytics capabilities, focusing on customer segmentation, transaction analysis, inactivity alerts, and customer lifetime value estimation.

Question Explanations

### Q1: High-Value Customers with Multiple Products
This query identifies users who have both savings and investment products and ranks them by their total deposits. The logic includes:
- Counting distinct savings and investment plans.
- Summing confirmed deposits (in kobo, converted to the main unit).
- Filtering to users with both savings and investment products.

### Q2: Transaction Frequency Analysis
The query classifies users based on their average number of transactions per month:
- First, monthly transaction counts are calculated.
- Then, the average per user is computed.
- Finally, users are categorized into High, Medium, or Low Frequency.

### Q3: Account Inactivity Alert
This query flags accounts with no activity in the last 365 days:
- It joins plans with transactions.
- Calculates the date of the most recent transaction.
- Uses `DATEDIFF` to determine the number of inactive days.

### Q4: Customer Lifetime Value (CLV) Estimation
This query estimates the CLV of each customer using:
- Total number and value of transactions.
- Tenure in months since joining.
- A simplified CLV formula that annualizes activity.

## Challenges

- **NULL and Missing Values**: Several fields such as `name` and `transaction_date` can be null, so careful use of `COALESCE` and `LEFT JOIN` was essential.
- **Unit Conversion**: Deposits in kobo needed conversion to the major currency unit, which required dividing by 100 or 1000 depending on the context.
- **Complex Aggregations**: Balancing accuracy with readability while using multiple CTEs and conditional logic in aggregations was key.
