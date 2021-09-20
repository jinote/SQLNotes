## Using Google BigQuery

#### Using the "new_york_trees" dataset
1. top5 most common trees in the "tree_census_2015" table
```sql
SELECT spc_common, count(spc_common) as sps_common_count
FROM 'new_york_trees.tree_census_2015'
GROUP BY spc_common
ORDER BY count(spc_common) DESC
LIMIT 5
```

2. Average tree diameter of trees in "Good" health by borough in the "tree_census_2015" table
```sql
SELECT round(avg(tree_dbh), 3) as avg_tree_diameter, boroname, health
FROM 'new_york_trees.tree_census_2015'
WHERE health = "Good"
GROUP BY boroname, health
```

3. The common name of the tree with the largest tree diameter in the Borough of "Brooklyn"
```sql
SELECT spc_common, tree_dbh, boroname
FROM 'new_york_trees.tree_census_2015'
WHERE boroname = "Brooklyn"
ORDER BY tree_dbh DESC
LIMIT 1
```
