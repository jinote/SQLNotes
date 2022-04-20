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


### Window functions 
**1) Aggregate Functions**
- Compute statsitcs within each group
- same functions that you can use with the group by statement (sum, avg, min, max..)
```sql
select employee_id, 
       count(employee_id) over (partition by team_id) as team_size
from employee
```

2) ranking function 
useful for selecting the top N records per category
- row_number
- rank
- dense_rank

```sql
-- 185. department top three salaries (leetcode)
-- find all employees with top three salaries in each department

select d.name as department, 
dense_rank() over (partition by d.name order by d.name) as employee,
e.salary
from employee e
join department d
on e.id = d.id
limit 3
```

**Solution**<br>
Step1: Obtain a ranking of employees
```sql 
select e.name as Employee,
       e.salary as Salary,
       d.name as Department,
       Dense_rank() over (partition by d.id
                          order by Salary DESC) AS rank
from employee e
join department d 
on e.departmentId = d.id
```

why do we use DENSE_RANK?
- The problem requires querying ALL the individuals with the top 3 salaries
- In the IT department, there are 4 people with the top 3 salaries

Step2: select employees with rank <= 3
```sql
select department, employee, salary
from (select
      e.name as Employee,
      e.salary as Salary,
      d.name as Department,
      DENSE_RANK() OVER (PARTITION BY d.id ORDER BY d.salary desc) as rank
select
from employee e
join department d
on e.departmentId = d.id) as t
where rank <= 3
```

2) Analytics Functions
- Calculate an aggregate value based on a group of rows
- Compute moving averages, running totals, percentages or top-N results within a group 

```sql
-- 1454. Active users (Accounts, Logins)
-- 1. check difference between current login_date and LAG(login_date, 4)
-- if the difference = 4 -> user must have logged in for 5 consecutive days

select id, 
       login_date, 
       LAG(login_date, 4) OVER(PARTITION BY id ORDER BY login_date) AS lag4
from logins
```

```sql
SELECT DISTINCT t.id, a.name
FROM (SELECT id, 
             login_date, 
             LAG(login_date, 4) OVER(PARTITION BY id ORDER BY login_date) AS lag4
      FROM Logins) t
JOIN accounts a 
ON a.id = t.id
WHERE datediff(day, lag4, login_date) = 4;

```

**Advantage of Window Functions**
- We don't have to use window functions
- Use subqueries and joins to solve problems (but it can be longer or spagetti queries)
