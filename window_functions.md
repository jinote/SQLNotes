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
  

  
