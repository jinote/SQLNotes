Find the average tip left by taxi riders that paid with a "Credit Card" for rides that were longer than 15 minutes

```sql
SELECT avg(trips) avg_trips, payment_type
FROM chicago_taxi_trips.taxi_trips
WHERE payment_type = "Credit Card"
AND trip_seconds > (900)
GROUP BY payment_type;
```

Find the payment type that resulted in the largest average tip for rides that were longer than 10 minutes between 5 and 10 miles

```sql
SELECT payment_type, avg(tips) as avg_tips
FROM chicago_taxi_trips.taxi_trips
WHERE trip_seconds > (600)
AND trip_miles >= 5
AND trip_miles <= 10
GROUP BY payment_type
ORDER BY avg(tips) DESC
LIMIT 1;
```

Find the most expensive taxi "company"
```sql
SELECT compnany, ROUND(SUM(fare)/SUM(trip_miles), 3) as cost_per_mile
FROM chicago_taxi_trips.taxi_trips
WHERE trip_miles != 0
GROUP BY company
ORDER BY SUM(fare)/SUM(trip_miles) DESC
LIMIT 1;
```
