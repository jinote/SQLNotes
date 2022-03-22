You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.

Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:

Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.

```sql
select case 
       when p is null then concat(n, "Root")
       when n is (select distinct p from bst) then concat(n, "Inner")
       else concat(n, "Leaf")
   end
from bst
order by n asc

```

```sql
select n, if(p is null, "Root", if(n in (select b.p from bst as b), "Inner", "Leaf"))
from bst as b
order by n;
```
