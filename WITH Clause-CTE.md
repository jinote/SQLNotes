Find stores who's sales where better than the average sales accross all stores

using subquery
```sql
-- 1) total sales per each store -- total sales
select s.store_id, sum(cost) as total_sales_per_store
from sales s
group by s.store_id;

-- 2) find the avg sales with respect all the stores -- avg_sales
select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_stores
from (select s.store_id, sum(cost) as total_sales_per_store
  from sales s
  group by s.sotre_id) x;

-- 3) find the stores where total sales > avg_sales of all stores
select *
from (select s.store_id, sum(cost) as total_sales_per_store
      from sales s
      group by s.store_id) total_sales
join (select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_store
      from (select s.store_id, sum(cost) as total_sales_per_store
            from sales s
            group by s.store_id) x) avg_sales
     on total_sales.total_sales_per_store > avg_sales.avg_sales_for_all_stores;
```

using cte
```sql
with Total_Sales (store_id, total_sales_per_store) as
      (select s.store_id, sum(cost) as total_sales_per_store
      from sales s
      group by s.store_id), 
      avg_sales(avg_sales_for_all_stores) as
        (select cast(avg(total_sales_per_store) as int) as avg_sales_for_all_stores
        from total_sales)
        
 select *
 from total_sales ts
 join avg_sales av
 on ts.total_sales_per_store > av.avg_sales_for_all_stores
```
