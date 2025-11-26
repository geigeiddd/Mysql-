1.查询至少选修了学生'201305010101'选修的全部课程的学生姓名(两种方法:NOT EXISTS、算数量)
SELECT s.sname
FROM s
WHERE NOT EXISTS (SELECT *   
FROM sc sc1 
WHERE sc1.snum="201305010101" AND NOT EXISTS (SELECT * 
FROM sc sc2 
WHERE sc2.snum=s.snum AND sc2.cnum=sc1.cnum ))

SELECT s.sname
FROM s 
WHERE (SELECT COUNT(DISTINCT sc1.cnum)
FROM sc sc1 
WHERE sc1.snum=s.snum AND sc1.cnum IN (SELECT cnum
FROM sc
WHERE snum="201305010101"))=(SELECT COUNT(DISTINCT cnum)
FROM sc
WHERE snum="201305010101")

2.查询选修了课程'c01'或者选修了课程'c02'的学生的学号和姓名（两种方法：集合、OR）
SELECT s.snum,s.sname
FROM s,sc 
WHERE sc.cnum="c01" AND sc.snum=s.snum 
UNION
SELECT s.snum,s.sname
FROM s,sc
WHERE sc.cnum="c02" AND sc.snum=s.snum ;

SELECT DISTINCT s.snum,s.sname
FROM s,sc 
WHERE (sc.cnum="c01" OR sc.cnum="c02") AND sc.snum=s.snum 
3.查询既选修了课程'c01'又选修了课程'c02'的学生的学号和姓名（四种方法：集合、连接、IN、EXISTS)
SELECT s.snum,s.sname
FROM s,sc 
WHERE sc.cnum="c01" AND sc.snum=s.snum 
INTERSECT 
SELECT s.snum,s.sname
FROM s,sc
WHERE sc.cnum="c02" AND sc.snum=s.snum ;

SELECT s.snum,s.sname
FROM s JOIN sc sc1 ON s.snum=sc1.snum AND sc1.cnum="c01"
JOIN sc sc2 ON s.snum=sc2.snum AND sc2.cnum="c02"

SELECT s.snum,s.sname
FROM s
WHERE s.snum IN (SELECT sc.snum
FROM sc 
WHERE sc.cnum="c01") AND 
s.snum IN (SELECT sc.snum
FROM sc 
WHERE sc.cnum="c02")


SELECT s.snum,sname
FROM s
WHERE EXISTS (SELECT *
FROM sc
WHERE sc.cnum="c01" AND sc.snum=s.snum ) AND EXISTS (SELECT *
FROM sc
WHERE sc.cnum="c02" AND sc.snum=s.snum ) 
4.查询选修了课程'c01'没有选修课程'c02'的学生的学号和姓名（三种方法：集合、NOT IN、NOT EXISTS)
SELECT s.snum,s.sname
FROM s JOIN sc ON  sc.snum=s.snum
WHERE sc.cnum="c01"
EXCEPT 
SELECT s.snum,s.sname
FROM s JOIN sc ON sc.snum=s.snum
WHERE sc.cnum="c02" 

SELECT  s.snum,s.sname
FROM s
WHERE s.snum IN (SELECT snum 
FROM sc
WHERE sc.cnum="c01") AND
s.snum NOT IN (SELECT snum 
FROM sc
WHERE sc.cnum="c02")
111

SELECT   s.snum,s.sname
FROM s JOIN sc ON s.snum=sc.snum
WHERE sc.cnum="c01"
AND NOT EXISTS (SELECT *
FROM sc sc2
WHERE sc2.snum=s.snum AND sc2.cnum="c02 ")
111
5.查询既没有选修'c01'也没有选修'c02'的学生的学号和姓名（两种方法：NOT IN、NOT EXISTS）
SELECT DISTINCT s.snum,s.sname
FROM s
WHERE s.snum NOT IN (SELECT snum
FROM sc
WHERE cnum IN ("c01","c02"))

SELECT DISTINCT s.snum,s.sname
FROM s
WHERE NOT EXISTS (SELECT *
FROM sc
WHERE sc.cnum IN ("c01","c02") AND sc.snum=s.snum )
6.查询学校中所有师生的姓名和性别
SELECT t.tname name,t.tsex sex  
FROM t
UNION ALL
SELECT s.sname name,s.ssex sex 
FROM s 

7.查询学校中所有与教师同名同性别的学生的姓名、性别
SELECT t.tname name,t.tsex sex  
FROM t JOIN s ON t.tname=s.sname AND t.tsex=s.ssex 