Two tables:
- Students (Columns ID, Name, Marks)
- Grades (Grade, min_mark, max_mark)

```sql
select if(grade < 8, null, name), grade, marks
from students
join grades
where marks between min_mark and max_mark
order by grade desc, name
```
