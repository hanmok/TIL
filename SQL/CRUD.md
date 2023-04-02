# CRUD

## CREATE

```sql
CREATE TABLE cats
(
cat_id INT AUTO_INCREMENT,
name VARCHAR(100),
breed VARCHAR(100),
age INT,
PRIMARY KEY (cat_id)
);
```

```sql
INSERT INTO cats(name, breed, age) 
VALUES ('Ringo', 'Tabby', 4),
       ('Cindy', 'Maine Coon', 10),
       ('Dumbledore', 'Maine Coon', 11),
       ('Egg', 'Persian', 4),
       ('Misty', 'Tabby', 13),
       ('George Michael', 'Ragdoll', 9),
       ('Jackson', 'Sphynx', 7);
```

<br>
<br>

## READ

`SELECT <col_name> FROM <table_name>`

```sql
SELECT * FROM cats; -- * : all 
SELECT name FROM cats;
SELECT age FROM cats;
SELECT age, name FROM cats;
```

```SQL
-- WHERE clause (not limited to SELECT
SELECT * FROM cats WHERE age=4;
SELECT name, age FROM cats WHERE age=4;
SELECT name FROM cats WHERE age=4;
```

```SQL
-- Practice
SELECT cat_id from cats;
SELECT name, breed from cats;

SELECT * FROM cats;
SELECT name, age FROM cats WHERE breed='Tabby';
SELECT cat_id, age FROM cats WHERE cat_id=age;
```

### Aliases

***Rename*** column name when selecting ***to read results easier***

```sql
SELECT cat_id AS id, name FROM cats;
DESC cats;
```

<br>
<br>

## Update

how do we alter existing data?

`UPDATE <table_name> SET col=val ...`

```sql
UPDATE cats SET breed='Shorthair'
WHERE breed='Tabby';

UPDATE employees SET current_status='laid-off', last_name='who cares';
```

***A Good Rule of Thumb***   
TRY SELECTING before you UPDATE or DELETE
<br>


```sql
SELECT * FROM cats;

-- Change Jackson's name to 'Jack'
SELECT * FROM cats WHERE name='Jackson';
UPDATE cats SET name='Jack'
WHERE name='Jackson';

-- Change Ringo's breed to 'British Shorthair'
SELECT * FROM cats WHERE name='Ringo';
UPDATE cats SET breed='British Shorthair'
WHERE name='Ringo';

-- Update both Maine Coons' ages to be 12
SELECT * FROM cats WHERE breed='Maine Coon';
UPDATE cats SET age=12
WHERE breed='Maine Coon';
```
<br>
<br>

## DELETE
```SQL
DELETE FROM cats WHERE name='Egg';
DELETE FROM cats; -- remove all rows..

SELECT * FROM cats;

SELECT * FROM employees;

-- DELETE all 4 year old cats
SELECT * FROM cats WHERE age=4;
DELETE FROM cats WHERE age=4;

-- DELETE cats whose age is the same as their cat_id
SELECT * FROM cats WHERE age=cat_id;
DELETE FROM cats WHERE age=cat_id;

-- DELETE all cats...
DELETE FROM cats;
DESC cats;
```