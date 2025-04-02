# BEVERAGE SALES ANALYSIS USING MYSQL AND EXCEL

![Beverage Sales Analysis](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*WNTneKaklgnIOh3G7w8c7w.png)


# PROBLEM STATEMENT

Some Beverage companies, leading distributor of consumer products, was facing a pressing issue — inconsistent sales performance across different regions. 
While some areas thrived, others lagged behind, causing a disconnect between budgeted and actual sales. Profit margins fluctuated, and managers struggled to pinpoint the root causes behind the underperformance.

Company executives grew concerned. Were certain products not performing well? Were sales managers assigned inefficiently? Was regional demand being misjudged? Without concrete data-driven insights, decision-making felt like a guessing game.

To tackle this, they turned to their data analytics team, seeking clear, actionable insights that could help them identify trends, optimize sales strategies, and boost profitability across all regions. The challenge was set — could data unlock the secrets behind their sales struggles?


![](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*n1NVeHXGSvcwan3lQLhRIw.png)

# DATA MODEL

![Data Model](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*XZ9aMgNtZSlTfHRM8ydUbg.png)


# ANALYSIS:


### 1.Market Share of Each Company

**SQL QUERY**
```sql

SELECT o.company,
       ROUND((SUM(o.units_sold) / (SELECT SUM(units_sold) FROM orders)) * 100, 2) AS market_share
FROM orders o
GROUP BY o.company;

```


Output:

![Market Share Of Each Company](https://miro.medium.com/v2/resize:fit:498/format:webp/1*GKQRYyIxEpdDr3s993S0tA.png)

Visualization :

![Market Share Of Each Company](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*nUUB9JzqBMEEK4hTVgNKyw.png)


### 2.CUSTOMER COUNT OF EACH COMPANY

**SQL QUERY**

```sql 

select  o.company,count(customer_name) as cust_no 
from 
orders o 
group by 1
order by 1 desc;

```

Output : 

![Customer_Count_Of_Each_Company](https://miro.medium.com/v2/resize:fit:460/format:webp/1*kYFDhY0tAp0wqi8JqZ1RoA.png)

Visualization :
              
![Customer_Count_of_Each_Company](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*MoelDR6cAONdl_bqPVGpsw.png)


## 3. MONTH WISE SALES TRENDS

**SQL QUERY**

```sql 

SELECT DATE_FORMAT(STR_TO_DATE(purchase_date, '%Y-%m-%d'), '%M') AS month,
       company, 
       SUM(units_sold) AS sales 
FROM orders 
GROUP BY month, company;

```

Output :

![Month_Wise_Sales_Trends](https://miro.medium.com/v2/resize:fit:566/format:webp/1*dq0zwBa6fyvEDjR9fKD4Ow.png)

Visualization :

![](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*ABFgmp8zUs9p-gsJvc46IQ.png)


## 4.MONTH WISE PROFIT PERCENTAGE

**SQL QUERY** 

```sql

SELECT 
    DATE_FORMAT(STR_TO_DATE(purchase_date, '%Y-%m-%d'), '%M') AS months, 
    company, 
    (SUM(profit) / NULLIF(SUM(sales), 0)) * 100 AS profit_percentage
FROM orders 
GROUP BY months, company
order by company desc;

```

Output :

![MOnth_Wise_Profit](https://miro.medium.com/v2/resize:fit:640/format:webp/1*yVnIv0FY3IGsxvlTNr6Ovg.png)

Visualization :
![](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*oh3FU1GtQgjpRue_6Vh4qA.png)


## 5.REGIONS WITH LOW SALES UNITS

**SQL QUERY** 

```sql 

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

```

Output :

![Regions_With_Low_Sales](https://miro.medium.com/v2/resize:fit:640/format:webp/1*Iuc-6WyOo_bNIGzWbXPauQ.png)


## 6.STATE PERFORMANCE WITH RESPECT PROFIT %

**SQL QUERY**

```sql 

SELECT 
    o.customer_state,
    SUM(o.sales) AS total_sales,
    SUM(o.profit) AS total_profit,
    (SUM(o.profit) / SUM(o.sales)) * 100 AS profit_margin_percentage
FROM orders o
GROUP BY 1
ORDER BY profit_margin_percentage DESC;

```

Output :

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*611-QpAYbD_GavVIYBfUFA.png)

Visualization :

![](https://miro.medium.com/v2/resize:fit:4642/format:webp/1*vgW5v2YcGO84RKBh7589rA.png)


## 7.REGIONS WHERE SALES > ACTUAL SALES

**SQL QUERY**

```sql 

SELECT r.region, 
       SUM(o.budget_sales) AS planned_sales,
       SUM(o.sales) AS actual_sales
FROM orders o
JOIN regions r ON o.customer_state = r.state
GROUP BY r.region
HAVING actual_sales >planned_sales
ORDER BY actual_sales DESC;

``` 

Output :

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*vksUWLcaNOPBGpucPfMEHA.png)

Visualization :
![](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*o3V4wPdbSfXlPSJQM6ymaw.png)


## Profit percentage With Respect to the Category

**SQL QUERY**

```sql 

SELECT 
    o.category,
    (SUM(profit) / (SELECT SUM(sales) FROM orders)) * 100 AS total_profit_percentage
FROM orders o
GROUP BY o.category
ORDER BY total_profit_percentage DESC;

```

Output :
![](https://miro.medium.com/v2/resize:fit:544/format:webp/1*qbrEkXnz8ebMJWRbsxrC4Q.png)

Visualization :

![](https://miro.medium.com/v2/resize:fit:4800/format:webp/1*qF9nIAAJAbJpF1-eGGNwQw.png)



# OBSERVATIONS

1.All Companies are having the equal and tough competition in the market , each of them are trying their best to improve their sales

2.Customers are slightly interested to buy coca-coala than pepsi and dr.pepper

3.December is the Most highly saled month then following by March- September as there is a constant sales

4. December ,February ,March is the Most Profitable Months because of the summer month in the American State

5.There are cities like Halfmoon-bay,Tamaqua where sales are only 100 units ,West virginia,North_dakot,South_Dakota showing negative profits

6.Sallisaw,Tamaqua,Cotulla,Berne and some other cities are showing only 100 units sales which is the least

7.Sates like West Virginia,South Dakota,North Dakota are showing negative profits in the sales

8.South east, NorthEast,West,South West are the regions where Sales are greater than planned sales

9.Soft drinks,Alcohol are most profitable Categories and coffee is the least profitable


# SUGGESTIONS

1.Should concentrate on the Low units saled regions and promote them with high reaching promotions

2.Collaborating with any other food brands so that they can send it along with the food so that customer will come

3.Giving any special offers to the low foot fall regions to increase the sales

## Tools Used

- MySQL for data extraction, transformation, and querying
- Excel for data visualization and trend analysis

## Project Presentatio

[![Click the image for Project Presentation](https://miro.medium.com/v2/resize:fit:1100/format:webp/1*WNTneKaklgnIOh3G7w8c7w.png)](https://www.linkedin.com/feed/update/urn:li:activity:7307604739771224067/)












