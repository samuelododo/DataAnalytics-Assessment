-- Q1: High-Value Customers with Multiple Products

SELECT
    u.id AS owner_id,
    COALESCE(u.name, CONCAT(u.first_name, ' ', u.last_name)) AS name,
    
    -- Count of regular savings products
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,

    -- Count of investment products
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,

    -- Total deposits (convert from kobo to major currency unit)
    COALESCE(SUM(sa.confirmed_amount), 0) / 100 AS total_deposits

FROM users_customuser u

-- Join users to their plans
JOIN plans_plan p ON u.id = p.owner_id

-- Join to savings transactions with confirmed amounts
LEFT JOIN savings_savingsaccount sa 
    ON p.id = sa.plan_id 
    AND sa.confirmed_amount > 0

-- Consider only savings or investment plans
WHERE p.is_regular_savings = 1 OR p.is_a_fund = 1

GROUP BY u.id, name

-- Filter users with both savings and investment products
HAVING savings_count > 0 AND investment_count > 0

-- Rank by highest deposit value
ORDER BY total_deposits DESC;
