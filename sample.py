import sqlglot
# r = sqlglot.transpile("SELECT EPOCH_MS(1618088028295)", read="duckdb", write="hive")[0]

#17.4.1
"""
SQL Dialects Reference
https://en.wikibooks.org/wiki/SQL_Dialects_Reference/Print_version

PostgreSQL Vs MySQL differences in syntax - A developer guide
https://tipseason.com/postgres-vs-mysql-syntax-comparision/

SQL Server, PostgreSQL, MySQL... what's the difference? Where do I start?
https://www.datacamp.com/blog/sql-server-postgresql-mysql-whats-the-difference-where-do-i-start
"""




# r = sqlglot.transpile("\l", read="postgres", write="mysql")[0]  # sqlglot.errors.ParseError: Invalid expression. # Can't convert Postgres Meta-Commands

# r = sqlglot.transpile("CURRENT_DATE()", read="postgres", write="mysql")[0] # CURRENT_DATE # Doesn't convert Postgresq functions

# r = sqlglot.transpile("CREATE TABLE t1 (col1 INT NOT NULL PRIMARY KEY AUTO_INCREMENT);", read="mysql", write="postgres")[0] #




"""
https://docs.databricks.com/en/sql/language-manual/sql-ref-ansi-compliance.html
-- Examples of explicit casting

-- `spark.sql.ansi.enabled=true`
> SELECT CAST('a' AS INT);
  error: invalid input syntax for type numeric: a

> SELECT CAST(2147483648L AS INT);
  error: Casting 2147483648 to int causes overflow

> SELECT CAST(DATE'2020-01-01' AS INT)
  error: cannot resolve 'CAST(DATE '2020-01-01' AS INT)' due to data type mismatch: cannot cast date to int.
To convert values from date to int, you can use function UNIX_DATE instead.

-- `spark.sql.ansi.enabled=false` (This is a default behavior)
> SELECT cast('a' AS INT);
  null

> SELECT CAST(2147483648L AS INT);
  -2147483648

> SELECT CAST(DATE'2020-01-01' AS INT);
  null

-- Examples of store assignment rules
> CREATE TABLE t (v INT);

-- `spark.sql.storeAssignmentPolicy=ANSI`
> INSERT INTO t VALUES ('1');
  error: Cannot write incompatible data to table '`default`.`t`':
- Cannot safely cast 'v': string to int;

-- `spark.sql.storeAssignmentPolicy=LEGACY` (This is a legacy behavior until Spark 2.x)
> INSERT INTO t VALUES ('1');
> SELECT * FROM t;
  1
"""

# r = sqlglot.transpile("SELECT CAST(DATE'2020-01-01' AS INT);", read="databricks", write="postgres")[0] # SELECT CAST(CAST('2020-01-01' AS DATE) AS INT)

"""
https://www.postgresql.org/docs/current/sql-syntax-lexical.html#SQL-PRECEDENCE
"""
# 4.1.6. Operator Precedence
# r = sqlglot.transpile("SELECT 3 OPERATOR(pg_catalog.+) 4;", read="postgres", write="databricks")[0] # SELECT CAST(CAST('2020-01-01' AS DATE) AS INT) # sqlglot.errors.ParseError: Invalid expression / Unexpected token. Line 1, Col: 18.


"""
4.2. Value Expressions 
https://www.postgresql.org/docs/current/sql-expressions.html
"""
# 4.2.2. Positional Parameters
# r = sqlglot.transpile("""CREATE FUNCTION dept(text) RETURNS dept
#     AS $$ SELECT * FROM dept WHERE name = $1 $$
#     LANGUAGE SQL;""", read="postgres", write="databricks")[0] # sqlglot.errors.ParseError: Invalid expression / Unexpected token. Line 3, Col: 16.

# filename = 'sql/redshift/Redshift DDL 3_Tables.sql'
filename = 'sql/redshift/dim_ssga_security.sql'
f = open(filename, 'r')
s = f.read()

r = sqlglot.transpile(s, read="redshift", write="databricks", pretty = True)[0] # SELECT COLLECT_LIST(a) FROM table


# 4.2.7. Aggregate Expressions
# r = sqlglot.transpile("SELECT array_agg(a ORDER BY b DESC) FROM table;", read="redshift", write="databricks")[0] # SELECT COLLECT_LIST(a) FROM table

print(r)
