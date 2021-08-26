Aug 26, 2021 - Datacamp

### SQLALchemy querying

<code>from sqlalchemy import Table, Metadata</code><br>
  <code>metadata = Metadata()</code><br>
  <code>census = Table('census', metadata, autoload=True,</code><br>
  <code>autoload_with = engine)</code><br>
  <code>stmt = "SELECT * FROM census</code><br>
  <code>results = connection.execute(stmt).fetchall()</code><br>
<br>

<code>from sqlalchemy import select</code><br>
  <code>metadata = Metadata()</code><br>
  <code>census = Table('census', metadata, autoload=True,</code><br>
  <code>autoload_with = engine)</code><br>
  <code>stmt = select([census])</code><br>
  <code>results = connection.execute(stmt).fetchall()</code><br>
<br>

- Get the first row of the results by using an index: first row<br>
<code>first_row = results[0]</code>





















