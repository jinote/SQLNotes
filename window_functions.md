## **What is a window function?**
- applies a function a window
- perform calculations across a set of rows or a window

**Differences between GROUP BY and Window Functions**
- Window function: each row remains its seperate identity
- Group by: populates only one row per aggregation

```sql
SELECT 
  functions() OVER()
FROM Table
```

**functions()**<br>
select a function
- Aggregate functions
- Ranking functions
- Analytic functions

**OVER()**<br>
Define a window
- Partition by
- Order by
- Rows

## **Define a Window** Over Clause
- PARTITION BY: divides the result into partitions
- ORDER BY: defines the logical order of the rows within each group
- ROWS/RANGE: specifies the starting and end points of a group
```sql
OVER (
[<PARTITION BY clause>]
[<ORDER BY clause>]
[<ROW or RANGE clause>]
)
```

**PARTITION BY**
- Creates window frames by partitioning values
- partition one or more columns, or partition a subquery, a function or user defined variable

```sql
<PARTITION BY clause> ::=
PARTITION BY value_expression, ... [n]
```

ex. User activity
- fun() OVER (PARTITION BY user_id)
- fun() OVER (PARTITION BY user_id, date)

**ORDER BY**
- Defines the logical order of the rows within each partition
- Default order is ascending order

```sql
<ORDER BY clause> ::=
ORDER BY order_by_expression
  [COLLATE collation_name]
  [ASC | DESC]
  [ ,...n]
```

- Can be used together with the PARTITION BY clause
fun() OVER (PARTITION BY user_id ORDER BY date)

**ROWS/RANGE**
- Specify start and end points of a window frame
- Create fixed sized windows
```sql
<ROW or RANGE clause> ::=
{ROWS | RANGE} <window frame extent>
<window frame extent> ::=
{ <window frame preceding>
  | <window frame between>
}
<window frame between>::=
  BETWEEN <window frame bound> AND <window frame bound>
```
- **ROWS**: specify a fixed number of rows that precede or follow the current row
- **RANGE**: specifies the range of values with respect to the value of the current row

<window frame between> ::=
  BETWEEN <window frame bound> AND <window frame bound>
  
<window frame bound> ::=
  { <window frame preceding>
    | <window frame following>
  }

<window frame preceding>::=
{
  UNBOUNDED PRECEDING
  | <unsigned_value_specification> PRECEDING
  | CURRENT ROW
}
<window frame following>::=
{
  UNBOUNDED FOLLOWING
  | <unsigned_value_specification> FOLLOWING
  | CURRENT ROW
}

## Functions
**Aggregation Functions**
```sql
SELECT value, 
  SUM(value) OVER(ORDER BY value) AS total,
  AVG(value) OVER(ORDER BY value) AS "Avg",
  COUNT(value) OVER(ORDER BY value) AS "Count",
  MIN(value) OVER(ORDER BY value) AS "MIN",
  MAX(value) OVER(ORDER BY value) AS "MAX"
FROM table
```

**Ranking Functions**
- Calculate the rank of each row within each group
- Commonly used ranking functions
1. ROW_NUMBER: numbers all rows sequentially
2. RANK: provides the same numeric value for rows with the same value (ties)
3. DENSE_RANK: provides ranks no gap in the ranking values
4. NTILE
- Useful for selecting the top N records per category
  
```sql
SELECT value,
  ROW_NUMBER(value) OVER(ORDER BY value) AS "ROW_NUMBER", # each number is unique
  RANK(value) OVER(ORDER BY value) AS "RANK", # not always sequential integer
  DENSE_RANK(value) OVER(ORDER BY value) AS "DENSE_RANK" # sequential (NO Gap)
FROM table
```
  
**Anlaytic Functions**
- Access the values of multiple rows in a window
- Compare multiple rows and calculate the differences between rows
- Commonly used analytic functions
  1) LAG: access to rows before the current row
  2) LEAD: access to rows after the current row
  
```sql
  LAG (scalar_expression [,offset] [,default]) # offset can't be negative
  OVER ([partition_by_clause ] order_by_clause)
  
SELECT value, 
  LAG(value, 2) OVER(ORDER BY value) as "LAG"
FROM table
```
```sql
  LEAD (scalar_expression [,offset], [default] )
  OVER ([partition_by_clause] order_by_clause)
  
SELECT value, 
  LEAD(value,2) OVER(ORDER BY value) AS "LEAD"
FROM table
```
```sql
SELECT value, 
  LAG(value, 2) OVER(ORDER BY value) as "LAG"
  LEAD(value, 2) OVER(ORDER BY value) as "LEAD"
FROM table
```
  
**More examples of window function**
```sql
# bring all rows with Max_Salary
SELECT e.*,
  MAX(salary) OVER() AS Max_Salary
FROM employee e
  
# Max_Salary in each dept
SELECT e.*, 
  MAX(salary) OVER(PARTITION BY dept_nmae) AS max_salary
FROM employee e

# Row_number
SELECT e.*,
  ROW_NUMBER() OVER() AS RN

SELECT e.*,
  ROW_NUMBER() OVER(PARTITION BY dept_name) AS RN
FROM employee e;

-- Fetch the first 2 employees from each department to join the company
SELECT * FROM (
  SELECT e.*,
    ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY emp_id) AS RN
  FROM employee e) x
WHERE x.rn < 3;

-- RANK 
-- Fetch the top 3 employees in each dept earning the max salary
SELECT * FROM (
  SELECT e.*,
  RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk
  FROM employee e) x
WHERE x.rnk < 4;
  
SELECT e.*,
  RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rnk,
  DENSE_RANK() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS dense_rank,
  ROW_NUMBER() OVER(PARTITION BY dept_name ORDER BY salary DESC) AS rn
FROM employee e

-- Lead
SELECT e.*,
  LAG(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS prev_emp_salary
  LEAD(salary) OVER(PARTITION BY dept_name ORDER BY emp_id) AS next_emp_salary
FROM employee e

-- Fetch a query to display if the salary of an employee is higher, lower or equal to the previous employee
SELECT e.*,
  LAG(salary) OVER (PARTITION BY dept_name ORDER BY emp_id AS prev_emp_salary,
  CASE WHEN 
```
  
```sql
first_value(product_name) 
  over (partition by product_category order by price desc)
  as most_exp_product,
last_value(product_name)
  over (partition by product_category order by price desc
  rows between unbounded preceding and unbounded following)
  # range between unbounded preceding and current row)
  # range between 2 preceding and 2 following)
  as least_exp_product
from product
where product_category = "Phone";
  
-- Alternate way to write SQL query using Window functions
select *, 
  first_value(product_name) over w as most_exp_product,
  last_value(product_name) over w as least_exp_product
from product
where product_category = 'Phone'
window w as (partition by product_category order by price desc
  range between 2 preceding and 2 following)
```
  
```sql
-- nth_value
select e.*,
  nth_value(product_name, 2) over (partition by product_category order by price desc
                                   range bewteen unbounded preceding and unbounded following);
select e.*, 
  nth_value(product_name, 2) 
from product
window w as (partition by product_category order by price desc
             range between unbounded preceding and unbounded following);
```
  
```sql
-- ntile
-- write a query to segregate all the expensive phones, mid range phones and the cheaper phones.
select product_name,
case when x.buckets = 1 then 'Expensive Phones'
     when x.buckets = 2 then 'Mid Range Phones'
     when x.buckets = 3 then 'Cheaper Phones' END phone_category
from (
  select *,
  ntile(3) over() (order by price desc) as buckets
  from product
  where product_category = 'Phone') x
```

```sql
-- CUME_DIST (cumulative distribution):
/* value --> 1 <= cume_dist > 0 */
/* formula = current row no (or row no with value same as current row) / total no of rows */
-- query to fetch all products which are constituting the first 30%
-- of the data in products table based on price
select *, 
  cume_dist() over (order by price desc) as cume_distribution,
  round(cume_dist() over (order by price desc):: numeric * 100, 2) as cume_dist_percentage
from product;
  
```
  
```sql
select product_name, per_rank
from (
  select *
  percent_rank() over(order by price) as percentage_rank,
  round(percent_rank() over(order by price)::numeric *100, 2) as per_rank
  from product) x
where x.product_name = 'Galaxy Z Fold 3';
```
