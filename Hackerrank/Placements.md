You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

#### solution 1
```sql
-- select student name
-- where bf with higher salary than them
-- order by salary desc
-- no two studentsiwith same salary offer
select s.name
from (students s
      join friends f
      using(ID)
      join packages p1 on s.id = p1.id
      join packages p2 on f.friend_id = p2.id
where p2.salary > p1.salary
order by p2.salary;
```

#### solution 2
```sql
select s.name
from students s
join friends f
on s.id = f.id
join packages p1 
on s.id = p1.id
join packages p2
on f.friend_id = p2.id
where p2.salary > p1.salary
order by p2.salary

```
