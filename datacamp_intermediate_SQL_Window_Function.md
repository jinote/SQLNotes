**Today** 

SQL Window Function 공부하기!

- OVER, PARTITION, PARTITION BY, CTE 등

Window Function

- Calculate on an already generated result set (a window)
- Aggregate calculations
    - Simliar to subqueries in SELET
    - Running totals, rankings, moving averages

```sql
# this is subquery in select 
Select 
date, (home_goal + away_goal) as goals,
(select avg(home_goal + away_goal) 
from match
where season = '2011/2012') as overall_avg
from match
where season = '2011/2012';
```

```sql
# using WINDOW FUNCTION
# how many goals were scored in each match in 2011/2012, and how did that compare to the average?

select 
date, (home_goal + away_goal) as goals,
avg(home_goal + away_goal) OVER() AS overall_avg # subquery에서 사용한 from/where을 대체
# OVER() clause allows you to pass an aggregate functino down a data set
from match
where season = '2011/2012';
```

RANK

- What is the rank of matches based on number of goals scored?

```sql
select 
date, (home_goal+away_goal) as goals,
RANK() OVER(ORDER BY home_goal + away_goal) as goals_rank
from match
where season = '2011/2012';

# window functions allow you to create a RANK 
```

```sql
# desc 추가하기 
select
l.name as league,
avg(m.home_goal + m.away_goal) as avg_goals,
rank() over(order by avg(m.home_goal + m.away_goal) desc) as league_rank # desc 추가해서 내림차순 정렬
from league as l
left join match as m
on l.id = m.country_id
where m.season = '2011/2012'
group by l.name
order by league_rank;
```

Window Partitions

- Over and Partition by
    - Calculate separate values for different categoris
    - Calculate different calculations in the same column

```sql
avg(home_goal) over(partition by season) # it's simpler than 
```

Partition your data 

1)번과 2)번 비교해보기

```sql
# 1) how many goals were scored in each match, and how did that compare to the overall average?

select
date, (home_goal + away_goal) as goals,
avg(home_goal + away_goal) over() as overall_avg
from match;
```

```sql
# 2) how many goals were scored in each match, and how did that compare to the season's average?

select
date, (home_goal + away_goal) as goals,
avg(home_goal + away_goal) over(partition by season) as season_avg # season별로 평균구하기
from match;
```

```sql
select
c.name,
m.season,
(home_goal + away_goal) as goals,
avg(home_goal + away_goal)
over(partition by m.season, c.name) as season_ctry_avg
from country as c
left join match as m
on c.id = m.country_id
```

- can partition data by 1 or more columns

Sliding windows

- calculations relative to the current row
- running totals, sums, averages, etc
- partitioned by one or more columns

```sql
# sliding window keywords
# rows between <start> and <finish>

preceding # number of rows before that current row that you want calculation
following # number of rows after that current row that you want calculation
unbounded preceding # including every row since the beginning
unbounded following # including every row from the end
current row # stop calculation at the row
```

```sql
select 
date, home_goal, away_goal, sum(home_goal)
over(order by date rows between 
unbounded preceding and current row) as running_total # sum 구하기
from match
where hometeam_id = 8456 and season = '2011/2012';
```

```sql
select 
date, home_goal, away_goal, sum(home_goal)
over(order by date rows between 
1 preceding and current row) as last2
from match
where hometeam_id = 8456 and season = '2011/2012';
```

최종정리 +  case study

```sql
# case 복습
select date,
case when home_goal > away_goal then 'home win!'
		when home_goal < away_goal then 'Home loss :('
		else 'Tie' end as outcome
from matches;
```

```sql
# CTE 복습
with home as (
select m.id, t.team_long_name,
case when m.home_goal > m.away_goal then 'MU Win'
		when m.home_goal < m.away_goal then 'MU Loss'
		else 'Tie' end as outcome
from match as m
left join team as t 
on m.hometeam_id = t.team_api_id),

away as ( # 두번재 with - as 쓸 때는 with 생략!
selet m.id, t.team_long_name,
case when m.home_goal > m.away_goal then 'MU Win'
		when m.home_goal < m.away_goal then 'MU Loss'
		else 'Tie' end as outcome
from match as m
left join team as t
on m.awayteam_id = t.team_api_id) ## home과 away CTE 정한 후, 원하는 select 실행

select distinct
m.date, 
home.team_long_name as home_team,
away.team_long_name as away_team,
m.home_goal,
m.home_goal,
rank() over(order by ABS(home_goal - away_goal) desc) as match_rank # ABS = absolute value
from match as m
left join home on m.id = home.id
left join away on m.id = away.id
where m.season = '2014/2015'
and (home.team_long_name = 'Manchester United'
or away.team_long_name = 'Mancester United');
```
