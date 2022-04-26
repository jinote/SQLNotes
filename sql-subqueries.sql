SELECT * FROM employee;

SELECT * FROM department;
/* Q: Find the employees who's salary is more than the average salary earned by all employees
-- 1) Find the avg salary
-- 2) Filter the employees based on the above result.*/

-- inner subquery
SELECT AVG(salary) -- 5791.66666
FROM employee

SELECT *
FROM employee
WHERE salary > 5791.66666

SELECT *
FROM employee
WHERE salary > (SELECT AVG(salary) FROM employee); -- subquery / inner query

-- Scalary subquery
-- it always returns 1 row and 1 column
SELECT e.* -- outer query / main query
FROM employee e
JOIN (SELECT AVG(salary) sal
               FROM employee) avg_sal
ON e.salary > avg_sal.sal;

-- multiple row subquery
-- subquery which returns multiple column and multiple row
-- subquery which returns only 1 column and multiple rows

/*Q: Find the employees who earn the highest salary in each department
-- 1. find the highest salary in each department
-- 2. compare with employees*/

SELECT dept_name, max(salary)
FROM employee e
GROUP BY dept_name

SELECT *
FROM employee
WHERE (dept_name, salary) IN (SELECT dept_name, max(salary)
                              FROM employee e
                              GROUP BY dept_name);


-- single column, multiple row subquery
/*Q: Find department who do not have any employees*/
-- 1. find each distinct department 
SELECT DISTINCT dept_name 
FROM employee;

SELECT *
FROM department
WHERE dept_name NOT IN (SELECT DISTINCT dept_name FROM employee)

-- Correlated subquery 
-- A subquery which is related to the outer query
/* Q: find the employees in each department who earn more than the average salary in that department*/
SELECT AVG(salary)
FROM employee 
WHERE dept_name = "specific_dept"

SELECT *
FROM employee e1
WHERE salary > (SELECT AVG(salary)
                FROM employee e2
                WHERE e2.dept_name = e1.dept_name
                );

/* Q: find department who do not have any employees*/
SELECT *
FROM department 
WHERE NOT EXSITS (SELECT 1 
                  FROM employee e
                  WHERE e.dept_name = d.dept_name);

SELECT 1
FROM employee e
WHERE e.dept_name = 'Marketing';

-- Subquery inside a subquery
SELECT * 
FROM sales;
/* Q: find stores who's sales where better than the average sales across all stores*/
-- 1) find total sales for each store
-- 2) find avg sales for all the stores
-- 3) compare 1 & 2

SELECT *
FROM (SELECT store_name, SUM(price) as total_sales
      FROM sales
      GROUP BY store_name) sales
JOIN (SELECT AVG(total_sales) as sales 
      FROM (SELECT store_name, SUM(price) AS total_sales
             FROM sales
             GROUP BY store_name) x) avg_sales
      ON sales.total_sales > avg_sales.sales;
      












