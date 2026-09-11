/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the yearly performance products by compring their sales 
to both the averger sales performance of product and the previous year sales */

with yearly_products_sales As (
select year(f.order_date) as order_year , p.product_name ,
sum(f.sales_amount) as current_sales 
from [gold.fact_sales] f
left join [gold.dim_products] p
on f.product_key = p.product_key
where order_date is not null
group by year(f.order_date) ,p.product_name 
)
select order_year,product_name,current_sales,
Avg(current_sales) over (partition by product_name) avg_sales,
current_sales - Avg(current_sales) over (partition by product_name) as diff_avg,
case when current_sales - Avg(current_sales) over (partition by product_name) > 0 then 'Above_Avg'
	 when current_sales - Avg(current_sales) over (partition by product_name) < 0 then 'below_Avg'
	 else 'Average'
End Avg_change,
LAG(current_sales) OVER (partition by product_name order by order_year) py_sales,
current_sales - LAG(current_sales) OVER (partition by product_name order by order_year) as diff_py,
case when current_sales - LAG(current_sales) OVER (partition by product_name order by order_year) > 0 then 'Increace'
	 when current_sales - LAG(current_sales) OVER (partition by product_name order by order_year) < 0 then 'Decrease'
	 else 'No Change'
END py_change
from [yearly_products_sales]
