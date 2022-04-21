# Ollivander's Inventory 
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

solution

```sql
-- min number of gold galleons needed
-- non evil wand of high power & age
-- select id, age, coins_needed, power
-- order by power desc
-- order by age desc

SELECT w.id, wp.age, w.coins_needed, w.power
FROM Wands AS w
JOIN Wands_Property AS wp
ON w.code = wp.code
WHERE wp.is_evil = 0
AND w.coins_needed = (
      SELECT min(w2.coins_needed)
      FROM Wands AS w2
      JOIN Wands_Property AS wp2
      ON w2.code = wp2.code
      WHERE wp.age = wp2.age
      AND w.power = w2.power
)
ORDER BY w.power desc, 
wp.age desc 
```
