Write a query to print all prime numbers less than or equal to 1000. Print your result on a single line, and use the ampersand (&) character as your separator (instead of a space).
For example, the output for all prime numbers <= 10 would be:
You can read the challenge [here](https://www.hackerrank.com/challenges/print-prime-numbers/problem?isFullScreen=true).

**what is prime number?**
- A prime number is a whole number greater than 1 whose only factors are 1 and itself. A factor is a whole number that can be divided evenly into another number. The first few prime numbers are 2, 3, 5, 7, 11, 13, 17, 19, 23 and 29. Numbers that have more than two factors are called composite numbers.

**what is the DECLARE statement in sql?**
- used to declare a variable in SQL Server. In the second step, we have to specify the name of the variable. Local variable names have to start with an at (@) sign because this rule is a syntax necessity. Finally, we defined the data type of the variable.
```sql
/*DECLARE @str_name datatype[],
@int_num datatype[];*/


-- DECLARE example 1)
DECLARE @str_name int(1000);
SET @str_nanme = 'numbers';

-- DECLARE example 2)
declare @emp_name varchar(40);
set @emp_name = 'Mike';

select emp_name, emp_salary, emp_age
from employees
where emp_name = @emp_name

```

**Answer**
```sql
SET @range = 1000;

SELECT GROUP_CONCAT(R2.n SEPARATOR '&')
FROM (
        SELECT @ctr2:=@ctr2+1 "n"
        FROM information_schema.tables R2IS1,
        information_schema.tables R2IS2,
        (SELECT @ctr2:=1) TI
        WHERE @ctr2<@range
     ) R2
WHERE NOT EXISTS (
                SELECT R1.n
                FROM (
                    SELECT @ctr1:=@ctr1+1 "n"
                    FROM information_schema.tables R1IS1,
                    information_schema.tables R1IS2,
                    (SELECT @ctr1:=1) I1
                    WHERE @ctr1<@range
                ) R1
                WHERE R2.n%R1.n=0 AND R2.n>R1.n
        )
```
