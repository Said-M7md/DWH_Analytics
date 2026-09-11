create view gold.report_product as
with base_query as (
select 
f.order_number,f.sales_amount,f.quantity,f.customer_key,f.order_date,
p.product_key,p.category,p.subcategory,p.product_name, p.cost
from [gold.fact_sales] f
left join [gold.dim_products] p
on p.product_key =  f.product_key)
,
product_aggregation as (
select
product_key ,
product_name,
category,
subcategory,
cost,
count(distinct order_number) as total_orders,
sum (sales_amount) as total_sales,
sum (quantity) as total_quantity_sold,
count(distinct customer_key) as total_customer,
max(order_date) as last_date,
datediff(month , min(order_date) , max(order_date)) as lifespan,
Round(Avg(cast(sales_amount as float) / nullif(quantity,0)),1) as avg_selling_price
from base_query
group by 
product_key ,
product_name,
category,
subcategory,
cost
)
select 
product_key ,
product_name,
category,
subcategory,
cost,
last_date,
case 
	when total_sales > 5000 then 'High-Performer'
	when total_sales >1000 then 'Mid-Performer'
	else 'Low-Performer'
end as Product_segment,
datediff(month , last_date, getdate()) as recency_in_months ,
total_orders,
total_sales,
total_quantity_sold,
avg_selling_price,
lifespan,
case when total_sales = 0 then 0
	 else total_sales / total_orders
end as avg_order_revenue,
case when lifespan = 0 then total_sales 
else total_sales / lifespan
end as avg_monthly_months
from product_aggregation 
