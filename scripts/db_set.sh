#!/bin/bash

execsql() {
    local sql="$1"
    local url='http://106.75.231.3:8080/exec'
    local data="sql=\"$sql\""
    local response=$(curl -s -X POST -F "$data" "$url")
    echo "$response"
}

# 主程序开始
execsql "Drop TABLE IF EXISTS CCourse;"
execsql "Drop TABLE IF EXISTS CSC;"
execsql "Drop TABLE IF EXISTS CStudent;"

execsql "CREATE TABLE CCourse (
    Cno INT Primary key,
    Cname VARCHAR(20),
    Cpno INT,
    Ccredit INT
);"

execsql "Create table CSC(
    Sno INT,
    Cno INT,
    Grade INT,
    Primary key(Sno,Cno)
);"

execsql "Create table CStudent (
    Sno INT Primary key,
    Sname VARCHAR(10),
    Ssex VARCHAR(4),
    Sage Int,
    Sdept VARCHAR(10)
);"

execsql "INSERT into CStudent Values
(201215121,'LiYong','male',20,'CS'),
(201215122,'LiuChen','male',NULL,'CS'),
(201215123,'WangMin','female',18,'MA'),
(201215124,'ZhangLi','female',19,'IS');"

execsql "Insert into CSC(Sno, CNo, Grade) VALUES
(201215121,1,92),
(201215121,2,85),
(201215121,3,88),
(201215122,2,90),
(201215122,3,80);"

execsql "Insert into CCourse(Cno, Cname,Cpno, Ccredit) VALUES
(1,'Database',5,4),
(2,'Math',NULL,2),
(3,'Information System',1,4),
(4,'Operating System',6,3),
(5,'Data Structure',7,4),
(6,'Data Processing',NULL,2),
(7,'C Language',6,4);"

execsql "select count(*) from Cstudent;"