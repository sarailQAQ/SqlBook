# 3. 关系数据库-SQL

# 3.1 什么是 SQL

## 3.1.1 SQL 简介

SQL（Structured Query Language）是一种标准化的用于管理和处理关系型数据库的编程语言。它被设计用来查询、更新、操作和管理关系数据库系统中的数据，允许用户以各种方式高效地获取、组织和分析信息。SQL 可以执行各种任务，如查询数据（Select），插入记录（Insert），更新记录（Update），删除记录（Delete），创建新数据库，创建新表和存储过程，以及设置权限在数据库上。

关系型数据库就像是一个超级大的电子表格合集。想象一下，你有一个Excel表格，其中包含许多行和列，每一行代表一条记录（例如一个人的信息或一本书的详情），每一列则代表着记录的不同属性（如姓名、年龄、电话号码等）。而在关系型数据库中，这样的表格被称作“表”。

每个表都有自己的名称和结构（也就是列的名字和数据类型），并且每个表中的数据按照一定的规则组织起来。比如说，一个“学生表”可能会列出所有学生的姓名、学号、年龄等信息；另一个“课程表”则记录每门课程的编号、课程名称、教师等信息。

## 3.1.2 SQL 的分类

SQL（Structured Query Language）根据其功能可以分为以下几大类别：

- DDL（Data Definition Language，数据定义语言）： 用于创建、修改和删除数据库对象，如表、视图、索引、序列、存储过程、触发器等，主要关键字包括：CREATE、ALTER、DROP 等。
- DML（Data Manipulation Language，数据操纵语言）： 用于插入、更新和删除表中的数据行，主要关键字包括：INSERT（插入新数据）、UPDATE（更新数据）、DELETE（删除数据）等。
- DQL（Data Query Language，数据查询语言）：用于对数据库表中的数据进行查询和检索，主要关键词包括：SELECT、FROM、WHERE 等。
- DCL（Data Control Language，数据控制语言)：用于管理和控制数据库的权限以及事务控制， 主要关键字包括：GRANT（授予权限）、REVOKE（撤销权限）、COMMIT（提交事务）、ROLLBACK（回滚事务）等。

# 3.2 DDL

## 3.2.1 创建表

定义基本表的语法如下：

```sql

CREATE TABLE <表名>	(
	<列名> <数据类型>[ <列级完整性约束条件> ]
	[,<列名> <数据类型>[ <列级完整性约束条件>] ]
	…	[,<表级完整性约束条件> ] );
```

- <表名>：所要定义的基本表的名字
- <列名>：组成该表的各个属性（列）
- <表级完整性约束条件>：涉及一个或多个属性列的完整性约束条件
如果完整性约束条件涉及到该表的多个属性列，则必须定义在表级上，否则既可以定义在列级也可以定义在表级。

如：

```sql
-- 例 3.1
-- 建立“学生”表 CStudent，学号是主码，姓名取值唯一
CREATE TABLE CStudent(
  Sno    VARCHAR PRIMARY KEY,/* 列级完整性约束条件,Sno是主码*/
  Sname VARCHAR(20) UNIQUE, /* Sname取唯一值*/
  Ssex  VARCHAR(2),
  Sage  INT,
  Sdept VARCHAR(20)
);

CREATE TABLE CCourse (
    Cno INT Primary key,
    Cname VARCHAR(20),
    Cpno INT,
    Ccredit INT
);

Create table CSC(
    Sno INT,
    Cno INT,
    Grade INT,
    Primary key(Sno,Cno)
);
```

在创建表之后，我们可以用`SHOW TABLES`查看所有表，也可以用`DESCRIBE`来查看表的所有信息。

### 练习 3.2.1

```rust,editable
-- 练习 1：创建一个表，并用 SHOW TABLES 查看刚创建的表
CREATE TABLE Student(
  SS VARCHAR
);

SHOW TABLES;
```

```rust,editable
-- 练习 2：查看 Student 表的详细信息
DESCRIBE Student;
```



## 3.2.2 数据类型

SQL 中域的概念用数据类型来实现，定义表的属性时需要指明其数据类型及长度。

| 数据类型 | 含义 |
| --- | --- |
| CHAR(n),CHARACTER(n) | 长度为n的定长字符串 |
| VARCHAR(n), CHARACTERVARYING(n) | 最大长度为n的变长字符串 |
| CLOB | 字符串大对象 |
| BLOB | 二进制大对象 |
| INT，INTEGER | 长整数（4字节） |
| SMALLINT | 短整数（2字节） |
| BIGINT | 大整数（8字节） |
| NUMERIC(p，d) | 定点数，由p位数字（不包括符号、小数点）组成，小数后面有d位数字 |
| DECIMAL(p, d), DEC(p, d) | 同NUMERIC |
| REAL | 取决于机器精度的单精度浮点数 |
| DOUBLE PRECISION | 取决于机器精度的双精度浮点数 |
| FLOAT(n) | 可选精度的浮点数，精度至少为n位数字 |
| BOOLEAN | 逻辑布尔量 |
| DATE | 日期，包含年、月、日，格式为YYYY-MM-DD |
| TIME | 时间，包含一日的时、分、秒，格式为HH:MM:SS |
| TIMESTAMP | 时间戳类型 |
| INTERVAL | 时间间隔类型 |

## 3.2.3 修改表

如果想修改已存在的表结构，可以使用 `ALTER TABLE` 语句。`ALTER TABLE`的主要功能有：

- `RENAME TO`：重命名表
- `RENAME`：重命名列、约束等
- `ADD`：添加对象，如列、索引、约束等
- `ALTER COLUMN`：修改列

###  RENAME TO 子句

`RENAME TO` 子句用来重命名表，用法如下：

```sql
ALTER TABLE old_table_name RENAME TO new_table_name;
```

### RENAME 子句

`RENAME` 子句主要用于重命名表内的对象，具体用法如下：

**重命名列**：

```sql
ALTER TABLE table_name RENAME COLUMN old_column_name TO new_column_name;
```

**重命名索引：**

```sql
ALTER TABLE table_name RENAME INDEX old_index_name TO new_index_name;
```

**重命名约束：**

```sql
ALTER TABLE table_name RENAME CONSTRAINT old_constraint_name TO new_constraint_name;
```

### ADD 子句

`ADD` 子句用来向表内添加对象，有以下几种用法：

**添加列：**

```sql
ALTER TABLE table_name ADD COLUMN column_name data_type [column_constraints];
```

**添加索引或约束：**

```sql
# 添加唯一索引
ALTER TABLE table_name ADD UNIQUE INDEX idx_unique_column (column_name);

# 添加主键约束
ALTER TABLE table_name ADD PRIMARY KEY (column_name);

# 添加外键约束
ALTER TABLE childe_table_name ADD CONSTRAINT foreign_key_name
FOREIGN KEY (child_column) REFERENCES parent_table(parent_column);
```

### ALTER COLUMN 子句

`ALTER COLUMN` 子句用来修改列定义

**修改列的数据类型：**

```sql
ALTER TABLE table_name ALTER COLUMN column_name TYPE new_data_type;

ALTER Table CStudent ALTER COLUMN SNo TYPE INT;
```

**设置或删除列的默认值**：

```sql
# 设置默认值
ALTER TABLE table_name ALTER COLUMN column_name SET DEFAULT default_value;

# 删除默认值
ALTER TABLE table_name ALTER COLUMN column_name DROP DEFAULT;
```

**改变列是否允许为空：**

```sql
# 允许为空
ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL;

# 不允许为空
ALTER TABLE table_name ALTER COLUMN column_name SET NOT NULL;
```

<aside>
💡 不是所有的数据库系统都支持完全相同的 `ALTER COLUMN` 语法。例如，在 MySQL 中，通常使用 `MODIFY COLUMN` 或 `CHANGE COLUMN` 来完成类似的任务，而在 SQL Server 中则可以直接使用 `ALTER COLUMN`。在执行这类操作之前，务必了解你所使用的数据库系统的特定语法要求，并考虑到修改列属性可能对现有数据造成的影响，特别是当涉及数据类型的更改时，必须确保转换能够成功且有意义。
</aside>

### 练习 3.2.3 

```rust,editable
-- 练习 1. 将 Student 中的 SS 列重命名为 Sno
ALTER TABLE Student RENAME COLUMN SS to Sno;
```

```rust,editable
-- 练习 2. 向 Student 中添加 SName 列
ALTER Table Student Add Column Sname CHAR(10);
```

```rust,editable
-- 练习 3. 将 Student 表中的 Sno 列的类型改为 INT
ALTER Table Student Alter Column Sno type INT;
```

```rust,editable
-- 练习 4：查看修改后的 Student 表
SHOW Student;
```



## 3.2.4 删除表

可以使用`DROP TABLE` 语句来实现删除表，用法如下：

```sql
DROP TABLE table_name;

# 删除 CStudent 表
Drop TABLE CStudent;
```

一旦执行了 `DROP TABLE`，该操作不可逆，所以执行前务必确认你不再需要该表及其数据，并且已经做好了必要的备份工作。

此外，在某些情况下，如果表与其他表之间有关联（例如外键约束），在删除表之前可能需要解除这些关联或者设定适当的级联删除规则。

### 练习 3.2.4

```rust,editable
-- 练习：删除 Student 表
Drop TABLE Student;
```

# 3.3 DML

## 3.3.1 INSERT 语句

`INSERT INTO`语句在SQL中用于向数据库表中添加新的行或记录，它的语法如下：

```sql

INSERT INTO table_name (column1, column2, ..., columnN)
VALUES (value1, value2, ..., valueN);
```

- `table_name` 是你想要插入数据的表的名称。
- `(column1, column2, ..., columnN)` 是你想插入数据的列名列表。这一步可以省略，如果要按表定义的顺序插入所有列的值。
- `(value1, value2, ..., valueN)` 是对应列的值列表。这些值必须与列的数据类型匹配，并且必须满足列的约束条件（如NOT NULL、UNIQUE等）。

例：

```sql
 -- 将一个新学生元组插入到 Student 表中。
INSERT INTO CStudent VALUES (201215121,'李勇','男',20,'CS');
Insert INTO CSC(Sno, CNo, Grade) VALUES (201215124,1,82),
```

### 练习 3.3.1

```rust,editable
-- 练习 1：重新创建表
Create table Student (
    Sno INt Primary key,
    Sname VARCHAR(10),
    Ssex VARCHAR(4),
    Sage Int,
    Sdept VARCHAR(10)
);
```

```rust,editable
-- 练习 2：插入数据
INSERT INTO Student Values(201215121,'LiYong','male',20,'CS');
INSERT INTO Student(Sno, Sname, Ssex, Sdept) Values(201215122,'LiuChen','male','CS');
-- 查看刚刚插入的数据
SELECT * FROM Student;
```

## 3.3.2 UPDATE 语句

`UPDATE`语句用于修改表中已存在的记录。以下是`UPDATE`语句的语法：

```sql
UPDATE table_name SET column1 = value1, column2 = value2, ... WHERE condition;
```

- `table_name`: 要更新的表的名称。
- `column1, column2, ...`: 表中需要修改的列名。
- `value1, value2, ...`: 与列相对应的新值。
- `condition`: 用于指定哪些行应被更新的过滤条件。如果没有提供`WHERE`子句，那么表中的所有行都会被更新（除非有约束阻止这种全局更新，例如主键或唯一约束）。

例如：

```sql
# 将学号为 201215122 的同学的年龄更改为 21
UPDATE CStudent SET Sage=21 WHERE Sno=201215122;
```

### 练习 3.3.2

```rust,editable
-- 练习 1：将学号 201215122 的同学的 Sage 设置为 21
UPDATE Student SET Sage=21 WHERE Sno=201215122;
-- 查看更新的结果
SELECT * FROM Student;
```

## 3.3.3 DELETE 语句

`DELETE`语句用于从数据库表中删除满足特定条件的一条或多条记录。以下是最基本的`DELETE`语句的语法：

```sql
DELETE FROM table_name [WHERE condition];
```

- `table_name`：您要从其中删除记录的表的名称。
- `[WHERE condition]`：可选部分，用于指定删除哪些记录的条件。**如果不指定`WHERE`子句，则会删除表中的所有记录**（除非存在限制性约束，如`TRIGGER`、`CONSTRAINT`等阻止无条件删除所有记录）。

例如：

```sql
DELETE FROM CSC WHERE Sno=201215123;
```

### 练习 3.3.3

```rust,editable
-- 练习 1：删除学号为 201215121 的同学
DELETE FROM Student WHERE Sno=201215121;
-- 查看删除的结果
SELECT * FROM Student;
```

# 3.4 SELECT 语句

SQL 中的 **SELECT** 语句是用于从数据库中检索数据的核心指令。它允许用户根据特定的条件从一个或多个表中选择和返回所需的数据行和列，就像是数据库世界里的探索者或者研究员，其作用是从数据库的大量信息中挑选出你需要的数据。比如，你可以说：“我要从这个庞大的员工数据库中 SELECT（选择）所有来自北京的员工的名字和工资信息。”

简单来说，SELECT 就是用来根据你的条件查询并获取数据库中特定数据的操作，它的基本格式如下：

```sql
SELECT [column1, column2, ...]
FROM table_name;
```

比如，我们可以这么写：

```sql
-- 查询名为"Students"表中的所有列，* 代表所有
SELECT * from CStudent;

-- 只选择特定列
SELECT Sno, Sname from CStudent;
```

SELECT 查询的结果是一个由满足查询条件的数据行组成的集合，这些数据行来源于指定的数据库表或视图，并且仅包含查询语句中所指定的列。这个结果集可以根据查询的具体内容进行排序、筛选、分组、计算以及其他各种操作。

```rust,editable
-- 练习：查询所有课程
SELECT * from CCourse;
```

## 3.4.1 条件查询

我们已经可以使用 SELECT 来查看表里的数据了，但是当数据库中数据很多时，我们该如何筛选出我们想要的数据呢？比如，我们可能需要在全校学生中找出选修《当代数据管理系统》的同学，这个时候我们就可以使用 WHERE 子句来设置检索数据的条件。

它的基本用法如下：

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

例如：

```sql
-- 查询学号为201215121的所有列
SELECT * FROM CStudent
WHERE Sno = 201215121;
```

当然，我们也可以设置多个检索条件，并将它们用 AND 或 OR 关键词连接起来，比如：

```sql
SELECT Sno, Sname, Sdept
FROM CStudent
WHERE Sage >= 18 and Sage <= 19;
```

以下是一些常用的条件表达式：

- 等于：`=`
- 不等于：`<>` 或 `!=`
- 大于：`>`
- 小于：`<`
- 大于等于：`>=`
- 小于等于：`<=`
- BETWEEN：用于指定一个范围，例如`WHERE Price BETWEEN 2 AND 10` 查找价格在 2 到 10 之间的商品
- IN：用于列出一组可能的值，例如 `WHERE ID IN (1, 2, 3)`
- NOT：用于否定条件，如 `NOT IN` 或 `NOT LIKE`
- AND 和 OR：用于组合多个条件，如 `WHERE Age > 18 AND City = 'New York'`

#### 练习 3.4.1

```rust,editable
-- 练习 1：查询 CS 学院的所有学生
SELECT * FROM CStudent WHERE Sdept = 'CS';
```

```rust,editable
-- 练习 2：查询年龄在 18 岁到 19 岁之间的学生，补全 WHERE 子句中的条件
SELECT Sno, Sname, Sdept
FROM CStudent
WHERE ; -- 补全条件
```

```rust,editable
-- 练习3：查询学号为 20121512 的同学的所有成绩

```



## 3.4.2 NULL 关键字

在SQL中，`NULL`关键字表示缺失的或未知的数据值。它不同于零、空字符串或者空格，`NULL`不是一个具体的值，而是一个指示某个列没有有效数据的状态。

由于 NULL 既不等于也不不等于任何值（包括它自己），所以不能直接使用等于 (`=`) 或不等于 (`<>` / `!=`) 运算符来判断 NULL。需使用 `IS NULL` 和 `IS NOT NULL` 来检测 NULL。

```sql
-- 查找 Sage 为 NULL 的所有记录
SELECT Sno, Sname, Sdept
FROM CStudent
WHERE Sage IS NULL;
```

#### 练习 3.4.2

```rust,editable
-- 练习 1：查找 Sage 不为 NULL 的所有学生的学号、姓名和年龄
SELECT Sno, Sname, Sage
FROM CStudent
WHERE Sage IS NOT NULL;
```

```rust,editable
-- 练习 2：查找不需要前置课程的课程名

```



## 3.4.3 条件查询——字符串匹配

在查询中，字符串往往是难以处理的一种类型，因为我们难以通过上一节提到的常用条件表达式来准确声明我们想要筛选什么样的字符串。这时，我们可以通过特殊的表达式和函数来实现检索。

### 模糊搜索 LIKE

`LIKE`表达式主要用于在`WHERE`子句中执行模式匹配，帮助我们根据字符串字段中的某种模式来选择数据行。`LIKE`表达式与通配符一起使用，主要有两种通配符：

1. `%`（百分号）：代表零个、一个或多个任意字符。
2. `_`（下划线）：代表一个任意字符。

例如，你可以这么用：

```sql
-- 找出所有张陈的同学
SELECT Sno, Sname, Sdept
FROM CStudent
WHERE Sname LIKE '张%';

-- 找出所有名字中包含星的同学
SELECT Sno, Sname, Sdept
FROM CStudent
WHERE Sname LIKE '%星%';
```

### 字符串函数

字符串函数有很多，不同的数据库管理系统支持的字符串函数可能不太一样，这里我们列举几个常见的。

```sql
-- TRIM：删除字符串两边的空格或其他指定字符。
SELECT * FROM Contacts
WHERE TRIM(phone_number) = '1234567890';

-- LENGTH：返回字符串长度
SELECT * FROM Users
WHERE LENGTH(password) >= 8;

-- LOWER、UPPER：转换列值为小写或大写，然后进行比较。
SELECT * FROM Users
WHERE LOWER(username) = 'john';

-- REPLACE：替换字符串中的某个字符。
SELECT * FROM Articles
WHERE REPLACE(title, ' ', '') = 'TitleWithoutSpaces';

-- ......
```

<aside>
💡 除了字符串函数外，数据库管理系统还会提供时间函数、编解码函数、数值函数等各种函数供大家使用
</aside>

#### 练习 3.4.3

```rust,editable
-- 练习 1：找出名字以 Zhang 开头的同学的学号与姓名
SELECT Sno, Sname
FROM CStudent
WHERE Sname LIKE 'Zhang%';
```

```rust,editable
-- 练习 2：找出名字中包含 Chen 的同学

```

## 3.4.4 数据排序-ORDER BY

有时候我们希望对查询的结果进行排序，比如将全校学生按照绩点进行排序，这时我们可以使用 ORDER BY 子句，基本语法如下：

```sql
SELECT column1, column2, …
FROM mytable WHERE condition(s)
ORDER BY column ASC/DESC
```

其中，ASC 代表升序排序，DESC 代表降序，比如：

```sql
SELECT * FROM CSC
ORDER BY Grade ; # 默认 ASC

SELECT * FROM CSC
ORDER BY Grade DESC;
```

同时，我们也可以使用 OFFSET 和 LIMIT 子句来筛选我们需要的数据区间，或实现类似分页的效果，它的语法如下：

```sql
SELECT column, another_column, …
FROM mytable WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

#### 练习：3.4.4

```rust,editable
-- 练习1：查询成绩排名 3-4的学生
SELECT * FROM CSC
ORDER BY Grade DESC
LIMIT 2 OFFSET 2;
```

```rust,editable
-- 练习2：将所有同学按照姓名升序排序

```



## 3.4.5 数据去重-DISTINCT

在SQL查询语句中，`DISTINCT` 关键字通常与 `SELECT` 语句结合使用，用于返回唯一的（无重复）列值，它的用法如下：

```sql
SELECT DISTINCT column1, column2
FROM table WHERE condition(s);
```

还记得关系代数中的投影吗？关系投影总是返回不同的元组，因此永远不需要`DISTINCT`。而SQL中的`DISTINCT`操作可以看作是为了达到与关系代数中投影相似的去重效果。

#### 练习 3.4.6

```rust,editable
-- 查询所有学生的名字并去重
SELECT DISTINCT Sname FROM CStudent;
```

```
-- 查询 CSC 中所有的 Cno 并去重
```



## 3.4.6 聚集查询

### 聚合函数

在SQL中，聚合函数是一类特殊的函数，它们的主要作用是对一组值进行某种类型的计算，并返回单个值作为结果。这类函数主要用于处理多行数据，将多行数据“聚合”成一行数据，因此得名。聚合函数在数据分析、报表生成以及复杂查询中非常有用。

常见的聚合函数有：

1. **AVG()** - 计算某一列所有非NULL值的平均值。
2. **COUNT()** - 返回指定列的行数，或者满足条件的行数（COUNT(*) 返回表中的总行数，COUNT(列名) 计算该列非NULL值的数量）。
3. **MAX()** - 返回指定列的最大值。
4. **MIN()** - 返回指定列的最小值。
5. **SUM()** - 计算指定列的所有数值的总和，忽略NULL值。

<aside>
💡 聚合函数往往会配合`GROUP BY`子句一起使用，以便根据一个或多个列的值对数据进行分类后分别进行聚合计算。在没有`GROUP BY`的情况下，聚合函数会对整个表的数据集进行计算。同时，聚合函数在计算过程中会忽略NULL值（除非函数本身特别处理NULL值，如COUNT(*)会计算所有行数，不论该行是否有NULL）。

</aside>

例如，查询学生总人数：

```sql
SELECT COUNT(*) FROM CStudent;
```

### 别名-AS

 在 `SELECT` 语句中，当你想要改变查询结果中列的显示名称时，可以使用 `AS` 来为列指定别名，它的用法如下：

```sql
SELECT column1 AS alias1, column2 AS alias2 FROM table_name;
```

例如，我们可以为聚合函数添加别名：

```sql
SELECT COUNT(*) AS studnet_number FROM CStudent;
```

此外，`AS` 还可以为表、视图、子查询等添加别名。

### 数据分组-Group By

分组查询是指通过使用`GROUP BY`子句将数据表中的记录按照一个或多个字段的值进行分类，将具有相同字段值的记录集合划分为一个组，然后对每个组执行某种形式的聚合计算或统计分析。其用法为：

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE column_name operator value
GROUP BY column_name;
```

例如：

```sql
-- 统计每个学生选了多少门课
SELECT Sno, COUNT(Cno) FROM CSC
Group By Sno;
```

在这个查询中，`GROUP BY Sno` 意味着将数据按`Sno`字段的值进行分组，`COUNT(CNO)`则是对每个学生选的课程进行统计，最后查询结果展示的是每个客户及其对应的总销售额。

你也可以对多列进行分组：

```SQL
-- 查看每个学院男生和女生的数量
SELECT Sdept, Ssex, COUNT(Sno) FROM CStudent
GROUP BY Sdept, Ssex;
```

注意，不在分组条件中的列，只能用聚合函数进行聚合，否则会发生错误，以下就是一个错误的例子：

```rust,editable
SELECT Sno, Cno
FROM CSC 
GROUP BY Sno
```

`GROUP BY`也可以与`WHERE`子句一起使用。此时，会先根据`WHERE`子句中的条件筛选数据，再使用`GROUP BY`进行分组，如：

```rust,editable
-- 超找学生的选课数量，但不包括课程编号为 1 的课程
SELECT CSC.Sno, COUNT(Cno)
FROM CSC 
Where Cno <> 1
GROUP BY CSC.Sno;
```

我们可以使用`EXPLAIN ANALYZE`来查看查询的执行过程。查询执行过程通常可以被表达为一颗算子树，树中的每个节点代表一个特定的操作或算子，这些算子执行数据库中的基础操作，如筛选（Filter）、投影（Project）、连接（JOIN）、聚合（Aggregation）、排序（Sort）等。树的结构定义了这些操作的执行顺序，从根节点到叶节点的遍历过程反映了查询的实际执行流程。

```rust,editable
-- 用 EXPLAIN ANALYZE 来打印算子树
EXPLAIN ANALYZE
SELECT CSC.Sno, COUNT(Cno)
FROM CSC 
Where Cno <> 1
GROUP BY CSC.Sno;
```

执行结果中，每个节点的第一栏表示算子名称。接下来让我们自下而上地简单解释一下算子树上的每个节点的含义：

- SEQ_SCAN：顺序扫描整张表，第二栏为表名，第三栏为扫描的列，第四栏为扫描后产生的临时表
- FILTER：筛选算子，这里实现对`WHERE`子句中的条件的的筛选，第二栏为筛选条件，第三栏为筛选结果
- PROJECTION：投影算子，第二栏为投影的列名，第三栏为投影的结果
- HASH_GROUP_BY：用 Hash 的方法实现的`GROUP BY`算子，这里由于内部处理，用编号代替了列名，但编号仍与上一个算子中的列的次序对应

从算子树可以看出，当`GROUP BY`与`WHERE`子句一起使用时，会先根据`WHERE`子句中的条件筛选数据，再使用`GROUP BY`进行分组。

### HAVING

分组查询还可以结合`HAVING`子句来进一步过滤分组结果，`HAVING`子句可以设置针对分组后的统计结果的条件，这是`WHERE`子句所不能做到的，因为`WHERE`子句只能应用于原始数据行，而不能应用于已分组后的统计值。例如：


```rust,editable
-- 例：查询平均分大于 85 的学生，但不包括学号为 201215121 的同学
SELECT Sno, COUNT(Cno)
FROM CSC
WHERE Sno <> 201215121
Group By Sno
HAVING AVG(Grade)>85;
```

此时，让我再尝试用`EXPLAIN ANALYZE`查看查询执行过程：

```rust,editable
EXPLAIN ANALYZE
SELECT Sno, COUNT(Cno)
FROM CSC
WHERE Sno <> 201215121
Group By Sno
HAVING AVG(Grade)>85;
```

可以看到，`HASH_GROUP_BY`的父亲节点是一个`FILTER`节点，这个节点就是用来实现`HAVING`子句中的过滤条件的。从算子树不难看出，我们首先对`WHERE`子句中的条件进行过滤，然后根据`GROUP BY`子句中的字段进行分组，最后根据`HAVING`子句中的条件对分组后的结果进行进一步过滤。

### 练习 3.4.6

```rust,editable
-- 练习 1：查询学号为 201215121 的同学的平均分
SELECT AVG(Grade) FROM CSC WHERE Sno = 201215121
```

```rust,editable
-- 练习 2：查询各个学院的人数
```



## 3.4.7 连接查询

我们可以通过多个表连接到一起，来查询分散在不同的表里的信息。就好比你在图书馆找书，每本书代表一个数据库表，每本书里的章节代表表中的记录。当你需要了解的信息分散在几本书（几张表）中时，你就需要同时查阅这些书籍才能获得完整的答案。

### 用`WHERE`子句实现连接查询

通过 WHERE 子句，我们就可以实现的简单的多表查询：

```sql
-- 查询每个学生及其选修课程的情况
SELECT CStudent.Sno, Sname, CNo, Grade
FROM CStudent, CSC
WHERE CStudent.Sno=CSC.Sno;
```

由于涉及到了多个表，所以我们需要`table_name.column_name` 的形式来描述我们选择的列。

### `JOIN`关键字

此外，我们还可以通过 `JOIN` 关键字来进行连接：

```sql
-- 查询某个学生的所有课程的成绩
SELECT CStudent.Sno, Sname, CNo, Grade
FROM CStudent join CSC on CStudent.Sno=CSC.Sno;
```

相比起`WHERE`，`JOIN` 有更多的类型，它们可以实现更多功能：

1. **内连接（INNER JOIN 或简称 JOIN）** 内连接只返回两个表中那些在连接列上具有匹配值的行的组合。如果某行在连接的列上没有找到匹配项，则不会出现在结果集中。
   
    ```sql
    SELECT * FROM TableA INNER JOIN TableB ON TableA.Key = TableB.Key;
    ```
    
2. **左外连接（LEFT JOIN 或 LEFT OUTER JOIN）** 左外连接返回左表（TableA）的所有行，即使在右表（TableB）中找不到匹配的记录。对于在右表中未找到匹配的行，在结果集中对应的右表列会被填充为NULL值。
    ```sql
    SELECT * FROM TableA LEFT JOIN TableB ON TableA.Key = TableB.Key;
    ```

3. **右外连接（RIGHT JOIN 或 RIGHT OUTER JOIN）** 右外连接返回右表（TableB）的所有行，即使在左表（TableA）中找不到匹配的记录。对于在左表中未找到匹配的行，在结果集中对应的左表列会被填充为NULL值。
    ```sql
    SELECT * FROM TableA RIGHT JOIN TableB ON TableA.Key = TableB.Key;
    ```

4. **全外连接（FULL OUTER JOIN 或 FULL JOIN）** 全外连接返回左右表中所有匹配的行以及两边表中均不匹配的行，即包含两表所有数据，不匹配部分用NULL填充。
    ```sql
    SELECT * FROM TableA FULL OUTER JOIN TableB ON TableA.Key = TableB.Key;
    ```

5. **交叉连接（CROSS JOIN）** 交叉连接返回两个表的所有行的笛卡尔积，即第一张表中的每一行与第二张表中的每一行进行组合。如果没有指定连接条件，则默认进行交叉连接。
    ```sql
    SELECT * FROM TableA CROSS JOIN TableB;
    ```

为了更深入地理解 `JOIN`，让我们看一下它的执行过程：

```rust,editable
-- 试一试：使用 EXPLAIN ANALYZE 查看查询的执行
EXPLAIN ANALYZE
SELECT CStudent.Sno, Sname, Cno, Grade
FROM CStudent, CSC
WHERE CStudent.Sno = CSC.Sno;
```

这里，`HASH_JOIN`有两个儿子，这意味着它接受两个输入，它会将输入的两个临时表按照连接条件连接起来。`HASH_JOIN`的第二栏分别是 JOIN 的类型和连接条件，我们不难发现，用`WHERE`实现的连接就是内连接。

### 练习 3.4.7

```rust,editable
-- 练习 1：查询 LiYong 的选课情况，并输出课程名字和成绩
SELECT Cname, Grade
FROM CStudent 
JOIN CSC ON CStudent.Sno=CSC.Sno
JOIN CCourse ON CSC.Cno=CCourse.Cno
WHERE Sname = 'LiYong';
```

```rust,editable
-- 练习 2：查询所有同学的选课情况，如果没有选课，也输出学号姓名
SELECT CStudent.Sno, Sname, CNo, Grade
FROM CStudent left join CSC on CStudent.Sno=CSC.Sno;
```



## 3.4.8 子查询

子查询（Correlated Subquery）是SQL查询中的一种特殊形式，它出现在外部查询（主查询）内部，且内部查询（子查询）依赖于外部查询的每一行数据。每次外部查询执行到新的一行时，子查询都会被执行一次，每次执行都会使用外部查询当前行的值作为其查询条件的一部分。

### FROM 子句中的子查询

在`FROM`子句中嵌套子查询，实际上是将一个SELECT查询的结果当作一个临时表，这个临时表由内层查询生成，并且可以作为外层查询的数据基础进行进一步的操作。它的用法如下：

```sql
SELECT column1, column2, …
FROM <表名>，(SELECT XXX) AS <别名>
[WHERE <条件>];
```

为了使用子查询生成的临时表，我们必须为它取一个别名，例如：

```sql

SELECT CStudent.Sname FROM
( SELECT CSC.Sno FROM CSC GROUP BY CSC.Sno HAVING AVG(Grade)>90 ) AS T
JOIN CStudent ON T.Sno=CStudent.Sno;
```

### WHERE 子句嵌套子查询

将一个查询块嵌套在另一个查询块的 WHERE 子句或 HAVING 子句的条件中的查询称为**嵌套查询**，这里我们先介绍 WHERE 子句中嵌套查询。

**标量子查询（scalar subqueries）**

单行子查询是指**子查询的返回结果只有一行数据**。此时主查询语句的 WHERE 子句可直接用比较符（＝, >, <, >=, <=, <>）来进行与子查询结果进行比较，例如：

```sql
SELECT Sno, Cno FROM SC x
WHERE Grade > (
	SELECT AVG(Grade) FROM SC y WHERE y.Sno = x.Sno
);
```

**多行子查询（Multirow subqueries ）**

当子查询返回的结果有多行时，此时我们可以使用 IN、EXISTS、ANY、SOME、ALL 等关键字进行比较。

**IN 谓词**

- **`IN`**：用于检查某个字段的值是否存在于子查询或一组值中。如果字段值等于子查询结果集中的任何一个值或列表中的任何一个值，则条件成立。

    ```sql
    # 查询选修了课程名为“信息系统”的学生学号和姓名
    SELECT Sno,Sname FROM Student
    WHERE Sno  IN(
    	SELECT Sno FROM SC WHERE Cno IN(
    		SELECT Cno FROM Course WHERE Cname= '信息系统'
    	)
    );
    ```

- **`NOT IN`**：与`IN`相反，检查某个字段的值是否不存在于子查询或一组值中。如果字段值与子查询结果集中的任何值都不匹配或不在列表中，则条件成立。

    ```sql
    SELECT *
    FROM table1
    WHERE column1 NOT IN (SELECT column2 FROM table2);
    
    ```


### 嵌套查询求解方法

- 不相关子查询：子查询的查询条件不依赖于父查询
    - 由里向外逐层处理。即每个子查询在上一级查询处理之前求解，子查询的结果用于建立其父查询的查找条件。
- 相关子查询：子查询的查询条件依赖于父查询
    - 首先取外层查询中表的第一个元组，根据它与内层查询相关的属性值处理内层查询，若WHERE子句返回值为真，则取此元组放入结果表
    - 然后再取外层表的下一个元组
    - 重复这一过程，直至外层表全部检查完为止
```rust,editable
-- 查询非计算机科学系中比计算机科学系任意一个学生年龄小的学生姓名和年龄
EXPLAIN ANALYZE
SELECT Sname, Sage
FROM CStudent
WHERE Sdept!='CS' and Sage< ANY (
    SELECT Sage
    FROM CStudent
    WHERE Sdept='CS' 
);
```

### 带有 ANY（SOME）或 ALL 谓词的子查询

使用ANY或ALL谓词时必须同时使用比较运算。

- **`ANY`** 和 **`SOME`** 是同义词，它们用于比较主查询中的单个值与子查询返回的一列值的关系。当主查询值满足与子查询结果集中至少一个值的比较条件时，整个条件为真。

    ```sql
    # 查询非计算机科学系中比计算机科学系任意一个学生年龄小的学生姓名和年龄
    SELECT Sname,Sage FROM CStudent WHERE
    Sdept <> 'CS' AND Sage < ANY(
    	SELECT  Sage FROM CStudent WHERE Sdept= 'CS'
    );
    ```

-  **`ALL`** 用于比较主查询中的单个值与子查询返回的一列值的关系。当主查询值满足与子查询结果集中所有值的比较条件时，整个条件为真。

    ```sql
    # 查询非计算机科学系中比计算机科学系所有学生年龄都小的学生姓名及年龄
    SELECT Sname,Sage FROM CStudent
    WHERE Sdept <> 'CS' AND Sage < ALL(
    	SELECT Sage FROM CStudent WHERE Sdept= 'CS'
    );
    ```


### EXISTS 谓词

- **`EXISTS`**：用于检查是否存在满足特定条件的行。如果子查询返回至少一行数据，则`EXISTS`条件为真，若内层查询结果为空则为假。

    ```sql
    SELECT Sname
    FROM CStudent
    WHERE EXISTS
    	(SELECT *
    	 FROM CSC
    	 WHERE Sno=CStudent.Sno AND Cno= ' 1 ');
    ```

- **`NOT EXISTS`**：与`EXISTS`相反，检查是否不存在满足特定条件的行。如果子查询没有返回任何行，则`NOT EXISTS`条件为真。

    ```sql
    SELECT *
    FROM table1
    WHERE NOT EXISTS (SELECT 1 FROM table2 WHERE table1.column1 = table2.column2);
    ```


### HAVING 子句嵌套子查询

`HAVING`子句主要用于过滤经过`GROUP BY`处理后的分组结果集，它允许基于组的聚合函数（如COUNT、SUM、AVG、MAX、MIN等）的结果来进一步筛选数据。在`HAVING`子句中使用子查询，通常是用来比较分组后的统计值与另一个查询得到的结果。它的用法与 `WHERE` 中的嵌套子查询较为类似，例如：

```rust,editable
-- 查询考试成绩的众数
SELECT Grade FROM CSC
GROUP BY Grade
HAVING COUNT(*) >= ALL(
		SELECT COUNT(*) FROM CSC GROUP BY Grade
);
```

### 练习 3.4.8


```rust,editable
-- 练习 1：查询非计算机科学系中比计算机科学系任意一个学生年龄小的学生姓名和年龄
SELECT Sname, Sage
FROM CStudent
WHERE Sdept!='CS' and Sage< ANY (
    SELECT Sage
    FROM CStudent
    WHERE Sdept='CS'
);
```

```rust,editable
-- 练习 2：查询非计算机科学系中比计算机科学系所有学生年龄都小的学生姓名及年龄
SELECT Sname, Sage
FROM CStudent
WHERE Sdept!='CS' and Sage< ALL (
    SELECT Sage
    FROM CStudent
    WHERE Sdept='CS' 
);
```

```rust,editable
-- 练习 3：查询没有选修1号课程的学生姓名
SELECT Sname
FROM CStudent
WHERE NOT EXISTS
(SELECT *
FROM CSC
WHERE Sno = CStudent.Sno AND Cno='1');
```

# 3.5 习题

之前的例子中，为了使结果更加简洁明了，我们的数据表数据都比较少，所以在习题中我们使用新的数据表，以下是表描述：

- 学生表：**Student(SId, Sname, Sage, Ssex)**
  - **SId 学生编号，Sname 学生姓名，Sage 出生年月，Ssex 学生性别**
- 课程表：**Course(CId, Cname, TId)**
  - **CId 课程编号，Cname 课程名称，TId 教师编号**
- 教师表：**Teacher(TId, Tname)**
  - **TId 教师编号, Tname 教师姓名**
- 成绩表：**SC(SId,CId,score)**
  - **SId 学生编号，CId 课程编号，score 分数**

数据已经初始化，如果不小心删除数据，可以运行以下代码重置：

```rust,editable
IMPORT DATABASE '/app/data/data_3_5.sql';

```

1 查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数

1.1 查询同时存在" 01 "课程和" 02 "课程的情况

1.2 查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )

1.3 查询不存在" 01 "课程但存在" 02 "课程的情况

```rust,editable


```

2 查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩

```rust,editable


```

3 查询在 SC 表存在成绩的学生信息

```rust,editable


```

4 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null )

4.1 查有成绩的学生信息

```rust,editable


```

5 查询「李」姓老师的数量

```rust,editable


```

6 查询学过「张三」老师授课的同学的信息

```rust,editable


```

7 查询没有学全所有课程的同学的信息

```rust,editable


```

8 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息

```rust,editable


```

9 查询和" 01 "号的同学学习的课程完全相同的其他同学的信息

```rust,editable


```

10 查询没学过"张三"老师讲授的任一门课程的学生姓名

```rust,editable


```

