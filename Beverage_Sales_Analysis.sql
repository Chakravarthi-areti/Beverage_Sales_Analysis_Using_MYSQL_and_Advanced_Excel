



/* Market Share of Each Company*/

select o.company ,
(sum(o.units_sold)/(select sum(units_sold) from orders)) * 100 as market_share
from
orders o
group by 1;




/* customer count for each company */ 

select  o.company,count(customer_name) as cust_no 
from 
orders o 
group by 1
order by 1 desc;






/*month wise  trends in the sales   */


SELECT DATE_FORMAT(STR_TO_DATE(purchase_date, '%Y-%m-%d'), '%M') AS month,
       company, 
       SUM(units_sold) AS sales 
FROM orders 
GROUP BY month, company;









/* month-wise profit % */


SELECT 
    DATE_FORMAT(STR_TO_DATE(purchase_date, '%Y-%m-%d'), '%M') AS months, 
    company, 
    (SUM(profit) / NULLIF(SUM(sales), 0)) * 100 AS profit_percentage
FROM orders 
GROUP BY months, company
order by company desc;




/* regions with low units sales */ 




select * from (
select o.company ,o.customer_city,sum(units_sold) as units
from regions r 
inner join 
orders o 
on 
r.state = o.customer_state
group by 1,2
order by units desc)b 
where units < 101;




/*  state Performance Based on Profit Margins*/

 
SELECT 
    o.customer_state,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit,
    (SUM(o.profit) / SUM(o.sales)) * 100 AS profit_margin_percentage
FROM orders o
GROUP BY 1
ORDER BY profit_margin_percentage DESC;








/* regions where actual sales > planned_sales*/
SELECT r.region, 
       SUM(o.budget_sales) AS planned_sales,
       SUM(o.sales) AS actual_sales
FROM orders o
JOIN regions r ON o.customer_state = r.state
GROUP BY r.region
HAVING actual_sales >planned_sales
ORDER BY actual_sales DESC;








/*7. profit% Performance by Product Category*/
SELECT 
    o.category,
    (SUM(profit) / (SELECT SUM(sales) FROM orders)) * 100 AS total_profit_percentage
FROM orders o
GROUP BY o.category
ORDER BY total_profit_percentage DESC;






























