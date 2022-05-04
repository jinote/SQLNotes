-- CREATE TABLE EmployeeDemographics 
-- CREATE TABLE EmployeeSalary

SELECT FirstName, LastName, Gender, Salary, 
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM EmployeeDemographics dem 
JOIN EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeId

SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics dem 
JOIN EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeId
GROUP BY Gender

WITH cte_employee AS 
(SELECT firstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender,
AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM EmployeeDemographics dem 
JOIN EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeId
WHERE salary > '45000')

SELECT FirstName, LastName, Salary
FROM cte_employee

/* Today's topic: temp tables */
CREATE TABLE #temp_Employee(
EmployeeID int,
JobTitle varchar(100),
Salary int)

SELECT *
FROM #temp_Employee

INSERT INTO #temp_Employee VALUES 
('1001', 'HR', '45000')

INSERT INTO #temp_Employee
SELECT *
FROM EmployeeSalary

DROP TABLE IF EXISTS #temp_Employee2
CREATE TABLE #temp_Employee2 (
JobTitle varchar(50),
EmployeesPerJob int,
AvgAvg int,
AvgSalary int)

INSERT INTO #temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeId = sal.EmployeeId
GROUP BY JobTitle


SELECT *
FROM #temp_Employee2


/* String Function */
CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

Select *
From EmployeeErrors

-- Using Trim, Ltrim, Rtrim
SELECT EmployeeID, TRIM(EmployeeID) AS IDTRIM, 
LTRIM(EmployeeID) AS LIDTRIM, 
RTRIM(EmployeeID) AS RIDTRIM
FROM EmployeeErrors 

-- using Replace

SELECT LastName, REPLACE(LastName, '- Fired', '') AS LastNameFixed
FROM EmployeeErrors

-- using substring
SELECT SUBSTRING(FirstName, 3,3)
FROM EmployeeErrors

SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), dem.FirstName, SUBSTRING(dem.FirstName,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
ON SUBSTRING(err.FirstName,1,3) = SUBSTRING(dem.FirstName,1,3)

-- Gender
-- LastName
-- AGE
-- DOB

/* Stored Procedures*/
CREATE PROCEDURE TEST
AS 
SELECT *
FROM EmployeeDemographics

EXEC TEST


CREATE PROCEDURE Temp_Employee
AS
CREATE TABLE #temp_employee(
JobTitle varchar(100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int
)

SELECT *
FROM #temp_employee

EXEC Temp_Employee

/*Subqueires*/

SELECT *
FROM EmployeeSalary

-- Subquery in select
SELECT employeeid, salary, (select avg(salary) from employeesalary) as AllAvgSalary
FROM EmployeeSalary

SELECT employeeid, salary, (select avg(salary) from employeesalary) as AllAvgSalary
FROM EmployeeSalary

-- How to do it with partition by
SELECT employeeid, salary, avg(salary) over () as AllAvgSalary
FROM EmployeeSalary

-- why group by doesn't work
SELECT employeeid, salary, avg(salary) as AllAvgSalary
FROM EmployeeSalary
group by employeeid, salary
order by 1,2

-- subquery in from
select a.EmployeeID, AllAvgSalary
from (SELECT employeeid, salary, avg(salary) over () as AllAvgSalary
FROM EmployeeSalary) a

-- subquery in where
SELECT EmployeeID, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeId in (
				SELECT EmployeeId 
				FROM EmployeeDemographics
				WHERE Age > 30)
