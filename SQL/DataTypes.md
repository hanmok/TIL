# DataTypes


## Characters
<hr>

### CHAR
- Fixed length
- CHAR is faster for fixed length text
- If it is about to have <ins>similar characters size</ins>, use **CHAR**. Otherwise, use **VARCHAR**
- If inserting data is longer than specified length, it throws ***ERROR***

|Value|Char(4)|Storage|Varchar(4)|Storage|
|--|--|--|--|--|
|''|' '|4 bytes|''|1 byte|
|'ab'|'ab '|4 bytes|'ab'|3 byte|
|'abcd'|'abcd'|4 bytes|'abcd'|5 bytes|

```SELECT CHAR_LENGTH(abbr) FROM states``` : show Characters length

<Br>
<br>
<br>

## Numbers
<hr>

### Int


| Type | Storage | Range (Signed) | Range (Unsigned) |
| :---: | :---: | :---: | :---: |
| TINYINT | 1 | -128 ~ 127 | 0 ~ 255 |
| SMALLINT | 2 | -32768 ~ 32767 | 0 ~ 65535 |
| MEDIUMINT | 3 | -8388608 ~ 8388607 | 0 ~ 16777215 |
| INT | 4 | -2147483648 ~ 2147483647 | 0 ~ 4294967295 |
| BIGINT | 8 | -2^63 ~ 2^63 - 1 | 0 ~ 2^64 - 1 |

```SQL
CREATE TABLE parent
(
	children TINYINT UNSIGNED
)
```

### DECIMAL
<br>

DECIMAL(5, 2)  
5: Total Number of Digits  
2: Digits After Decimal  
![](images/DataTypes_Decimal.png)

```SQL
CREATE TABLE products (price DECIMAL(5, 2));
INSERT INTO products(price) VALUES (8347.1); -- Error (Out of Range)
INSERT INTO products(price) VALUES (5.026) -- 5.03 with Warning.
```

<br>

### FLOAT, DOUBLE
|Data Type|Memory Needed|Precision Issues|
|--|--|--|
|FLOAT|4 Bytes|~7 digits|
|DOUBLE|8 Bytes|~15 digits|

```SQL
CREATE TABLE nums(x FLOAT, y DOUBLE);
INSERT INTO nums(x, y) VALUES(1.12345678, 1.12345678)
SELECT * FROM nums;
```

![](images/DataTypes_Float_Double.png)

<br>
<br>
<br>

## DATE & TIMES

### DATE
- Values With a Data But no Time  
- 'YYYY-MM-DD
  
### TIME
- Values With a Time But No Date
- 'HH:MM:SS'

### DATETIME
- Values With a Date And Time
- 'YYYY-MM-DD HH:MM:SS'

```SQL
CREATE TABLE people
(
	name VARCHAR(100),
	birthdate DATE,
	birthtime TIME,
	birthdt DATETIME
)

INSERT INTO people (name, birthdate, birthtime, birthdt)
VALUES ('Elton', '2000-12-25', '11:00:00', '2000-12-15 11:00:00')
```

```SQL
SELECT CURTIME(); -- 00:54:24 (CURRENT_TIME())
SELECT CURDATE(); -- 2023-04-02 (CURRENT_DATE())
SELECT NOW(); -- 2023-04-02 00:54:00 (CURRENT_TIMESTAMP())
```

```SQL
INSERT INTO people(name, birthdate, birthtime, birthdt)
VALUES ('Hazel', CURDATE(), CURTIME(), NOW())
```
<br>

참고 자료   
https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html