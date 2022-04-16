Generate the following two result sets:

Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
```sql
There are a total of [occupation_count] [occupation]s.
```
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.

```sql
select concat(name, "(", left(occupation,1), ")")
from occupations
order by name asc;

select concat("There are a total of ", count(occupation), " ", lower(occupation), "s.") 
from occupations
group by occupation
order by count(occupation) asc, occupation;

```

**Answer**<br>
Aamina(D)<br>
Ashley(P)<br>
Belvet(P)<br>
Britney(P)<br>
Christeen(S)<br>
Eve(A)<br>
Jane(S)<br>
Jennifer(A)<br>
Jenny(S)<br>
Julia(D)<br>
Ketty(A)<br>
Kristeen(S)<br>
Maria(P)<br>
Meera(P)<br>
Naomi(P)<br>
Priya(D)<br>
Priyanka(P)<br>
Samantha(A)<br>
There are a total of 3 doctors.<br>
There are a total of 4 actors.<br>
There are a total of 4 singers.<br>
There are a total of 7 professors.<br>
