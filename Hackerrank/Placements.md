You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

```sql
-- select student name
-- where bf with higher salary than them
-- order by salary desc
-- no two studentsiwith same salary offer
select s.name
from students as s
join packages as p
on s.id = p.id
where p.salary > (select p2.salary 
                  from friends f2
                  join packages p2
                  on f2.friend_id = p2.id
                  group by p2.salary
                 )
group by s.name, p.salary
order by p.salary desc
```
