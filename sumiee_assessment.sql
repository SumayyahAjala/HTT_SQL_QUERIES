-- 1. Data Retrieval
Select name,website, primary_poc
From accounts

-- 2. Data Filtering
Select id,account_id, standard_qty
From orders
-- 2b Top 10 Selector
Select account_id, total
From orders
Order by total Desc
Limit 10;
-- 2c Greater than 2k orders
Select account_id, total
From orders
Where total > 2000

-- 3. Using Count
Select max(total) as Max_Total_Order
From orders

-- 4. Data Filtering II
Select account_id, total_amt_usd, total
From orders
Order by total_amt_usd Desc
Limit 3;

-- 5. Data Filtering III
Select account_id, standard_qty, gloss_qty, poster_qty
From orders
Where total > 2000 And total_amt_usd > 5000
Order by account_id Asc