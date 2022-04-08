# The 3 Categoreis in SQL 
- Computing Ratio
- Data Categorization
- Cumulative Sums

### Ratio 
- Comute ratio / percentage
- Given user activities history / system logs
- Examples
1) Calculating click through rate of an advertisement
2) Calculating retention rate of users
3) Querying the percentage of users / product satisfying certain criteria

You will be given
- A table of user activities / system logs

You will need:
- Write queries to aggregate
1) The numerator
2) The denominator

Question 
- % of users whose first order was immediate order
- Immediate order = same-day order

Ratio strategy in the strategy 
Numerator: # of first orders are immedient orders
Denominator: # of distinct users
-> Compute the ratio

```sql
# Numerator: count customers whose first order is an immediate order
with first_order as (
select customer_id
from delivery
group by customer_id
having min(order_date) = min(customer_pref_delivery_date))

# denominator: count total number of customers
select round(cast(count(customer_id) as decimal) / 
(select count(distinct customer_id) 
from delivery) * 100, 2) as immediate_percentage
from first_order

```


