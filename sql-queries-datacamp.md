Aug 26, 2021 - Datacamp

## Database in Python
### SQLALchemy querying

```py
from sqlalchemy import Table, Metadata
  metadata = Metadata()
  census = Table('census', metadata, autoload=True,
  autoload_with = engine)
  stmt = "SELECT * FROM census"
  results = connection.execute(stmt).fetchall()
  ```
  

```py
from sqlalchemy import select
  metadata = Metadata()
  census = Table('census', metadata, autoload=True,
  autoload_with = engine)
  stmt = select([census])
  results = connection.execute(stmt).fetchall()
```
<br>

- Get the first row of the results by using an index: first row<br>
<code>first_row = results[0]</code>

### Filtering and targeting data

Practice
```py
stmt = select([census])
stmt = stmt.where(census.columns.state == 'California')
results = connection.execute(stmt).fetchall()
for result in results
  print(result.state, result.age)
  

stmt = select([census])
stmt = stmt.where(census.columns.state.startswith('New'))
for result in connection.execute(stmt):
  print(result.state, result.pop2000)
  
#Conjunctions - and_(), or_(), not_()  
  
  
  ```




















