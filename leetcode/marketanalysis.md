Table1: users<br>
user_id is the primary key of this table.
This table has the info of the users of an online shopping website where users can sell and buy items.
<br>

Table2: orders<br>
order_id is the primary key of this table.
item_id is a foreign key to the Items table.
buyer_id and seller_id are foreign keys to the Users table.
<br>

Table3: items<br>
item_id is the primary key of this table.


Write an SQL query to find for each user, the join date and the number of orders they made as a buyer in 2019.
Return the result table in any order.

```sql
select
  u.user_id as buyer_id,
  u.join_date,
  count(order_id) as 'orders_in_2019'
from users u
left join orders o
on
  u.user_id = o.buyer_id
  and year(order_date) = '2019'
group by u.user_id
```
