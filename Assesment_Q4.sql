Q4: Customer Lifetime Value (CLV) Estimation

WITH customer_transactions AS (
    -- Aggregate total transactions and value per user
    SELECT
        owner_id,
        COUNT(*) AS total_transactions,
        SUM(confirmed_amount) AS total_transaction_value
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id),
customer_tenure AS (
    -- Calculate months since account creation
    SELECT
        id AS customer_id,
        COALESCE(name, CONCAT(first_name, ' ', last_name)) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURDATE()) AS tenure_months
    FROM users_customuser)
-- Estimate CLV using simplified formula
SELECT
    c.customer_id,
    c.name,
    c.tenure_months,
    COALESCE(t.total_transactions, 0) AS total_transactions,
-- CLV = (Txns per month) * 12 * (avg transaction value)
    CASE 
        WHEN c.tenure_months > 0 AND COALESCE(t.total_transactions, 0) > 0 THEN
            (t.total_transactions / c.tenure_months) * 12 * 
            ((t.total_transaction_value * 0.001) / t.total_transactions)
        ELSE 0
    END AS estimated_clv
FROM customer_tenure c
LEFT JOIN customer_transactions t ON c.customer_id = t.owner_id
ORDER BY estimated_clv DESC;
