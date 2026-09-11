-- customers segmention
with customers_segemention as (
select c.customer_key,sum(f.sales_amount) as total_spending ,
min (f.order_date) as first_order ,
max (f.order_date) as last_order,
datediff (month, min (f.order_date),max (f.order_date)) as lifespan
from [gold.fact_sales] f 
left join [gold.dim_customers] c
on f.customer_key = c.customer_key
group by c.customer_key)

select customer_segement ,
count (customer_key) as total_customers
from (
        select
        customer_key , total_spending , lifespan,
        case when lifespan >= 12 and total_spending >= 5000 then 'Vip'
             when lifespan >= 12 and total_spending <= 5000 then 'Regular'
             else 'New'
        end customer_segement
        from customers_segemention) t
group by customer_segement
order by total_customers desc


