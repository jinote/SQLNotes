Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

```sql
-- hacker_id, name, total challenges created by each student
-- order by total challenges desc,
-- name having same challenges > 1 -> order by hacker_id
-- count < max num of challenges -> exclude 
-- Question: num of challenges based on challenge_id?

SELECT c.hacker_id, h.name, count(c.challenge_id) AS challenges_created 
FROM Hackers h 
JOIN Challenges c 
ON h.hacker_id = c.hacker_id
GROUP BY c.hacker_id, h.name 
HAVING challenges_created = (SELECT count(c1.challenge_id) FROM Challenges AS c1 GROUP BY c1.hacker_id 
              ORDER BY count(*) desc limit 1) or
challenges_created NOT IN (SELECT count(c2.challenge_id) FROM Challenges AS c2 GROUP BY c2.hacker_id 
            HAVING c2.hacker_id <> c.hacker_id)
ORDER BY count(c.challenge_id) DESC, c.hacker_id;

```

select h.hacker_id, h.name, count(c.challenge_id) as challenges_created
from challenges c
join hackers h
on c.hacker_id = h.hacker_id
where count(c.challenge_id) >= max(count(c.challenge_id))
group by h.hacker_id, h.name
having h.hacker_id > 1
order by count(c.challenge_id) desc, h.hacker_id 
