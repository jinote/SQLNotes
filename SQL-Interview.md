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
# Numerator: Count customers whose first order is an immediate order
with first_order as (
select customer_id
from delivery
group by customer_id
having min(order_date) = min(customer_pref_delivery_date))

# denominator: count total number of customers
select round(cast(count(customer_id) as decimal) / (select count(distinct customer_id) from delivery) *100,2) as immediate_percentage
from first_order
```

### Categorization
Organize numerical data into categorical data
- generate a summary
- transform data into a more intuitive formate
- examples
1) numerical values -> low, medium, high
2) monthly / yearly profit -> net gain / loss

```sql
SELECT 
  CASE 
    WHEN duration < 300 THEN '[0-5>'
    WHEN duration < 600 THEN '[5-10>'
    WHEN duration < 900 THEN '[10-15>'
    ELSE '15 or more' # if not specified, it returns NULL if no condition satisfies
   END AS bin, 
   COUNT(*) AS total
FROM Sessions
GROUP BY 1
```

### Cumulative Sums
Often associated with time series data
Cumulative sum of the metric up tilla particular data
ex. 
- cumulative number of sales
- cumulative sales in a 7 day time window
```sql
SELECT 
  a.player_id, 
  b.event_date
  SUM(b.games_played) AS games_played_so_far
FROM activity a
JOIN activity b
ON a.player_id = b.player_id
WHERE a.event_date >= b.event_date # Every record is mapped with current and all previous records
GROUP BY a.player_id, a.event_date
ORDER BY a.player_id;
```

Another way is to use **window functions**
```sql
SELECT player_id, 
       event_date, 
       sum(games_played)
       OVER (PARTITION BY player_id
             ORDER BY event_date) AS games_played_so_far
FROM Activity;
```

Computing Ratios
- LeetCode 1174 Immediate Food Delivery II
- LeetCode 1322 Ads Performance
- LeetCode 1211 Queries Quality and Percentage

Data Categorization
- LeetCode 1393. Capital Gain Loss
- LeetCode 1907. Count Salary Categories
- LeetCode 1468. Calculate Salaries
- LeetCode 1212. Team Scores in Football Tournament

Cumulative Sums
- LeetCode 1097. Game Play Analysis V
- LeetCode 1454. Active Users
- LeetCode 579. Find cumulative salary of an employee

Self Join
- LeetCode 1270 All People Report to the Given Manager
- LeetCode 1811 Find Interview Candidates
- LeetCode 1285 Find the Start and End Number of Continuous Ranges
