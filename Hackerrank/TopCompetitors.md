Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

```sql
-- hacker_id, name
-- full scores > 1 
-- order by total num of challenges desc, hacker_id asc

SELECT h.hacker_id, h.name
FROM submissions AS s
JOIN challenges AS c
ON s.challenge_id = c.challenge_id
JOIN difficulty d
ON c.difficulty_level = d.difficulty_level
JOIN hackers h
ON h.hacker_id = s.hacker_id
WHERE d.score = s.score
GROUP BY h.hacker_id, h.name
HAVING count(h.hacker_id) > 1
ORDER BY count(h.hacker_id) DESC, h.hacker_id ASC
```
