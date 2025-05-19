Q2: Transaction Frequency Analysis

WITH monthly_txns AS (
    -- Count transactions per user per month
    SELECT
        owner_id,
        DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
        COUNT(*) AS transactions
    FROM savings_savingsaccount
    GROUP BY owner_id, txn_month
),

avg_monthly_txns AS (
    -- Calculate the average monthly transaction count per user
    SELECT
        owner_id,
        AVG(transactions) AS avg_txns_per_month
    FROM monthly_txns
    GROUP BY owner_id
)

-- Categorize users based on average transaction frequency
SELECT
    CASE
        WHEN avg_txns_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txns_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,

    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txns_per_month), 1) AS avg_transactions_per_month

FROM avg_monthly_txns
GROUP BY frequency_category;
