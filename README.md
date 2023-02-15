# Lesson 2

### Why we can't use aliases in WHERE clause?

[More about query order](https://jvns.ca/blog/2019/10/03/sql-queries-don-t-start-with-select/)


![sql query schema](https://jvns.ca/images/sql-queries.jpeg)


### Calculated fields
[MySQL functions](https://www.w3schools.com/sql/sql_ref_mysql.asp)

```
*, +, -, /, %
ABS
CONCAT_WS
INSERT
LENGTH
TRIM
LOCATE
REPLACE
LOWER
UPPER
```


### Aggregation

[Aggregation Functions Ref](https://www.w3schools.com/sql/sql_count_avg_sum.asp)

```SQL
SELECT COUNT(column_name)
FROM table_name
WHERE condition;
```

### CASE

[Case Ref](https://www.w3schools.com/sql/sql_case.asp)

```SQL
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
```

### Order by

[OrderBy ref](https://www.w3schools.com/sql/sql_orderby.asp)

```SQL
SELECT column1, column2, ...
FROM table_name
ORDER BY column1, column2, ... ASC|DESC;
```


### Select distinct

[Distinct ref](https://www.w3schools.com/sql/sql_distinct.asp)

```SQL
SELECT DISTINCT column1, column2, ...
FROM table_name;
```
