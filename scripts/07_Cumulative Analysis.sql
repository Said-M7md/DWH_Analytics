/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- calculate the total sales per month
-- and the running total of sales over time
select 
order_date ,
total_sales, 
sum(total_sales) over(order by order_date) as running_total_sales,
sum(Avg_price) over(order by order_date) as running_Avg_price
from
(
select
DATETRUNC( year, order_date ) as order_date,
sum(sales_amount) as total_sales,
AVG(price) as Avg_price
from [gold.fact_sales]
where order_date is not null
group by DATETRUNC( year, order_date)
) t