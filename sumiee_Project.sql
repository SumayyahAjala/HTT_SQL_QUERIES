-- Query 1:
--The names of the sales rep to the top 10 customers that placed the highest orders. 
SELECT s.name sales_rep,o.total_amt_usd,a.name company
FROM orders o
LEFT JOIN accounts a
ON a.id=o.account_id
LEFT JOIN sales_reps s
ON a.sales_rep_id=s.id
ORDER BY o.total_amt_usd DESC
LIMIT 10;

-- Query 2:
--The quantities of paper ordered and the type of paper with the highest and lowest quantity ordered/sold.
SELECT MAX(standard_qty) as max_std_qty,MAX(gloss_qty) as max_gloss_qty,
	MAX(poster_qty) as max_pst_qty
FROM orders

-- 2b: Minimum Paper Order
SELECT MIN(standard_qty) as min_std_qty,MIN(gloss_qty) as min_gloss_qty,
	MIN(poster_qty) as min_pst_qty
FROM orders

-- Query 3:
SELECT channel, COUNT(total) AS channel_orders
FROM web_events w
LEFT JOIN accounts a
ON a.id=w.account_id
LEFT JOIN orders o
ON a.id=o.account_id
GROUP BY channel
ORDER BY channel_orders DESC

-- Query 4:The companies ordering the highest quantities of paper.
SELECT a.name company,total
FROM orders o
LEFT JOIN accounts a
ON a.id=o.account_id
GROUP BY a.name,total
ORDER BY total DESC
LIMIT 3

-- Query 5:The customers that orders consistently and the type of paper they order.
SELECT a.id, name, standard_qty, gloss_qty, poster_qty,COUNT (w.occurred_at) AS frequency_of_orders
FROM orders o
LEFT JOIN accounts a
ON a.id = o.account_id
LEFT JOIN web_events w
ON w.account_id = a.id
GROUP BY (a.id, name, o.standard_qty, o.gloss_qty, o.poster_qty)
ORDER BY frequency_of_orders desc
LIMIT 3

-- Query 6: The region where the highest orders come from.
SELECT r.name,
COUNT (total) AS region_orders
FROM region r
LEFT JOIN sales_reps s
ON r.id = s.region_id
LEFT JOIN accounts a
ON a.sales_rep_id = s.id
LEFT JOIN orders o
ON o.account_id = a.id
GROUP BY (r.name)
ORDER BY region_orders desc

--Query 7:The average total amount that Walmart uses to order from us.
SELECT a.name Company,AVG(total_amt_usd)
FROM orders o
LEFT JOIN accounts a
ON a.id=o.account_id
WHERE a.name='Walmart'
GROUP BY a.name

-- Query 8: Sales Over the year/Accumulative sales
SELECT DATE_PART('Year', occurred_at) AS year,COUNT(occurred_at),
		SUM(total_amt_usd) AS yearly_sales
FROM orders
GROUP BY year
ORDER BY year

-- Query 9:The top three customers with the lowest orders.
SELECT a.name Company,SUM(total) Total_orders
FROM orders o
LEFT JOIN accounts a
ON o.account_id=a.id
GROUP BY Company
ORDER BY Total_orders 
LIMIT 3

-- Query 10:
-- Ranking our sales reps by the orders they bring in, from high ranking,
-- middle ranking, and low ranking.
SELECT s.name Sales_rep, SUM(total) Total, CASE
	   WHEN SUM(total)>= 100000 THEN 'High Ranking'
	   WHEN SUM (total)< 100000 AND SUM (total) >= 75000 THEN 'Middle Ranking'
	   WHEN SUM(total) < 75000 AND SUM (total) >= 1 THEN 'Low Ranking'
	   ELSE 'No Ranking'
	   END AS Ranking
FROM orders o
LEFT JOIN accounts a
ON o.account_id=a.id
LEFT JOIN sales_reps s
ON s.id=a.sales_rep_id
