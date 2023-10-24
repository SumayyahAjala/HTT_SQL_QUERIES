-- Data Challenge: Day 11
Select * 
From orders;

-- Day 16
Select Round(Sum(total_amt_usd)/Sum(total), 2) as Overall_Average_Order_Value
From Orders;
-- Average Order value is 6.30

--SubQuery
Select a.name, o.total_amt_usd,o.total, 
		(o.total_amt_usd + 0.0000001) / (o.total +0.0000001) as Average_Order_Value
From accounts a
Join orders o
On a.id = o.account_id
Where (o.total_amt_usd + 0.0000001) / (o.total +0.0000001) >
		(Select Round(Sum(total_amt_usd)/Sum(total), 2) as Overall_Average_Order_Value
			From Orders)
Order by Average_Order_Value;

--SubQuery
Select w.channel, sum(o.total_amt_usd) as Total_Sales
From web_events w
Join orders o
On w.account = a.sales_rep_id
Join 
Group by channel
Order by Total_Sales Desc;

Select *
From orders