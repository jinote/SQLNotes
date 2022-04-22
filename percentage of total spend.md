**Percentage of total spend**<br>
Find the percentage of the total spend a customer spent on each other. 
Output the customer's first name, order details, and percentage of their total spend for each order transaction rounded to the nearest whole number.
Assume each customer has a unique first name (ex. there is only 1 customer named Karen in the dataset)

table1: orders
table2: customers

```sql
-- join the orders with customers using an inner join 
-- sum the total amount spent by each customer
-- find the % total spent (order cost / sum(order cost)) by customer
-- round(*100)

SELECT 
first_name, 
order_details,
ROUND(order_cost / SUM(ORDER_COST) OVER (PARTITION BY first_name)::FLOAT * 100) AS percentage_of_total_spend
FROM orders o
JOIN customers c
   ON c.id = o.cust_id
ORDER BY first_name
```

