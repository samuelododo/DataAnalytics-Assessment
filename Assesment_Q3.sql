Q3: Account Inactivity Alert

SELECT
    p.id AS plan_id,
    p.owner_id,

    -- Identify the product type
    CASE
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,

    -- Most recent transaction date
    MAX(sa.transaction_date) AS last_transaction_date,

    -- Days since last transaction
    DATEDIFF(CURDATE(), MAX(sa.transaction_date)) AS inactivity_days

FROM plans_plan p

-- Include only confirmed deposits
LEFT JOIN savings_savingsaccount sa 
    ON p.id = sa.plan_id 
    AND sa.confirmed_amount > 0

-- Filter to only savings or investment products
WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1

GROUP BY p.id, p.owner_id, type

-- Only flag plans with no activity in the past 365 days
HAVING last_transaction_date IS NULL 
    OR last_transaction_date <= DATE_SUB(CURDATE(), INTERVAL 365 DAY);
