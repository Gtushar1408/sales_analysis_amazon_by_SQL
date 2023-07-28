--Step 1: Analyze
select * from superstore;

SELECT* FROM superstore where RowID < 6;

--1.What are total sales and total profits of each year?
select a.year_, sum(sales) as t_sales, sum(profit) as t_profit from
(SELECT datepart(year, orderDate) AS year_, sales AS sales, profit AS profit FROM superstore) a
group by a.year_
ORDER BY a.year_;

--2. What are the total profits and total sales per quarter?
with a as(select datepart(yy, orderdate) as y,CASE WHEN datepart(month, orderdate) IN (1,2,3) THEN 'Q1' 
WHEN datepart(month, orderdate) IN (4,5,6) THEN 'Q2' WHEN datepart(month, orderdate) IN (7,8,9) THEN 'Q3' ELSE 'Q4' END AS
quarter_, sales AS s, profit as p from superstore)
select y,quarter_,sum(s) as t_sales, sum(p) as t_profit from a
group by y,quarter_
ORDER BY y,quarter_;

--3. What region generates the highest sales and profits ?

SELECT region, SUM(sales) AS total_sales, SUM(profit) AS total_profits
FROM superstore GROUP BY region ORDER BY total_profits DESC;

--4--4. What region generates the highest profit_margin ?

SELECT region, ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_margin
FROM superstore GROUP BY region ORDER BY profit_margin DESC

--5.What state and city brings in the highest sales and profits ?

SELECT top 10 State, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits, 
ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_mar FROM superstore
GROUP BY State
ORDER BY Total_Profits DESC;

--6.What state and city brings in the lowest sales, profits and profits_margin ?

SELECT top 10 State, SUM(Sales) as Total_Sales, 
SUM(Profit) as Total_Profits FROM superstore
GROUP BY State ORDER BY Total_Profits ASC;

--7.What state and city brings in the highest profits_margin ?

SELECT top 10 City, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits, 
ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_marg FROM superstore
GROUP BY City ORDER BY Total_Profits DESC;

--8.What state and city brings in the lowes profits_margin ?

SELECT top 10 City, SUM(Sales) as Total_Sales, SUM(Profit) as Total_Profits, 
ROUND((SUM(profit) / SUM(sales)) * 100, 2) as profit_marg FROM superstore
GROUP BY City ORDER BY Total_Profits asc;

--5.9. The relationship between discount and sales and the total discount per category 

SELECT Discount, AVG(Sales) AS Avg_Sales FROM superstore GROUP BY Discount ORDER BY Discount;

--10 total discount on each category

SELECT category, SUM(discount) AS total_discount FROM superstore GROUP BY category ORDER BY total_discount DESC;

--11.total discount on each category of subcategory

 SELECT category,SubCategory, SUM(discount) AS total_discount FROM superstore GROUP BY 
 category,SubCategory ORDER BY total_discount DESC

 --.6.12. What category generates the highest sales and profits in each region and state ?
 
SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY category ORDER BY total_profit DESC;
--
 --13. What category generates the highest sales and profits in each region classified in each category ?
 
SELECT region, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY region,category ORDER BY total_profit DESC;

--14. What category generates the highest sales and profits in each state classified in each category ?
 
SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY state,category ORDER BY total_profit DESC;


--15. What category generates the lowest sales and profits in each state classified in each category ?
 
SELECT state, category, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY state,category ORDER BY total_profit;

--7.16. What subcategory generates the highest sales and profits in each region and state ?

SELECT subcategory, SUM(sales) AS total_sales, SUM(profit) AS total_profit, ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_marg
FROM superstore GROUP BY subcategory ORDER BY total_profit DESC;
--
 --17. What subcategory generates the highest sales and profits in each region classified in each subcategory ?
 
SELECT region, subcategory, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY region,subcategory ORDER BY total_profit DESC;

--18. What subcategory generates the highest sales and profits in each state classified in each subcategory ?
 
SELECT state, subcategory, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY state,subcategory ORDER BY total_profit DESC;


--19. What subcategory generates the lowest sales and profits in each state classified in each subcategory ?
 
SELECT state, subcategory, SUM(sales) AS total_sales, SUM(profit) AS total_profit,
ROUND(SUM(profit)/SUM(sales)*100, 2) AS profit_margin FROM superstore GROUP BY state,subcategory ORDER BY total_profit;


--8.20. What are the names of the products that are the most top 15 profitable to us?

SELECT top 15 productname, SUM(sales) AS total_sales, SUM(profit) AS total_profit FROM superstore
GROUP BY productname ORDER BY total_profit DESC;


--21. What are the names of the products that are the top 15 least profitable to us?

SELECT top 15 productname, SUM(sales) AS total_sales, SUM(profit) AS total_profit FROM superstore
GROUP BY productname ORDER BY total_profit ;

--9.22. What segment makes the most of our profits and sales ?
SELECT segment, SUM(sales) AS total_sales, SUM(profit) AS total_profit FROM superstore
GROUP BY segment ORDER BY total_profit ;

--23 no. of count of customer_id fro given data

SELECT COUNT(DISTINCT customerid) AS total_customers FROM superstore;

--24.no. of count of customer_id fro given data ineach region?

SELECT region, COUNT(DISTINCT customerid) AS total_customers FROM superstore GROUP BY region ORDER BY total_customers DESC;

--25.no. of count of customer_id fro given data ineach state?

SELECT state, COUNT(DISTINCT customerid) AS total_customers FROM superstore GROUP BY state ORDER BY total_customers DESC;

--11.25. Customer rewards program

SELECT customerid, SUM(sales) AS total_sales,SUM(profit) AS total_profit
FROM superstore GROUP BY customerid ORDER BY total_sales DESc;

--12.26. Average shipping time in total

SELECT ROUND(AVG(datediff(day,orderdate,shipdate)+1),1) AS avg_shipping_time FROM superstore

--27. Average shipping time per class and in total 

SELECT shipmode,ROUND(AVG(datediff(day,orderdate,shipdate)+1),1) AS avg_shipping_time FROM 
superstore GROUP BY shipmode ORDER BY avg_shipping_time


--------------------------------------------------------------------------------------------------------------------------------------------

(SELECT  top 5 productname, SUM(sales) AS total_sales, SUM(profit) AS total_profit FROM superstore
GROUP BY productname)
union all(SELECT top 5 subcategory, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore GROUP BY subcategory)
union all
(SELECT category, SUM(sales) AS total_sales, SUM(profit) AS total_profit
FROM superstore GROUP BY category)









