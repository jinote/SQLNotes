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

select w.id, wp.age, w.coins_needed, w.power
from Wands as w
join Wands_Property as wp
on w.code = wp.code
where wp.is_evil = 0
and w.coins_needed = (
select min(w2.coins_needed)
from Wands as w2
join Wands_Property as wp2
on w2.code = wp2.code
where wp.age = wp2.age
and w.power = w2.power
)
order by w.power desc, 
wp.age desc 

```
