1.查询选修了'B3503021'号课程的学生的学号和姓名（两种方法：IN/EXISTS）
SELECT snum,sname
FROM s
WHERE snum IN (SELECT snum
FROM sc
WHERE cnum ="B3503021");

SELECT snum,sname
FROM s
WHERE EXISTS (SELECT*
FROM sc
WHERE s.snum=sc.snum AND cnum="B3503021");

2.查询没有选修'B3503021 '号课程的学生的学号和姓名 （两种方法）
SELECT snum,sname
FROM s
WHERE snum NOT IN (SELECT snum
FROM sc
WHERE cnum ="B3503021");

SELECT snum,sname
FROM s
WHERE NOT  EXISTS (SELECT*
FROM sc
WHERE s.snum=sc.snum AND cnum="B3503021");

3.查询选修了'数据库原理与技术'的学生姓名（两种方法：IN/EXISTS）
SELECT sname
FROM s
WHERE sname IN (SELECT sname 
FROM c,sc
WHERE cname="数据库原理与技术" AND sc.cnum=c.cnum AND sc.snum=s.snum );

SELECT sname
FROM s
WHERE EXISTS (SELECT *
FROM sc
WHERE EXISTS (SELECT *
FROM c
WHERE cname="数据库原理与技术" AND sc.cnum=c.cnum AND sc.snum=s.snum ));

4.查询工资高于'刘小林'的所有教师的姓名、职称和工资。(比较运算符/EXISTS)         
SELECT t1.tname,t1.ttitle,t1.tsalary 
FROM t t1
WHERE t1.tsalary>(SELECT t2.tsalary
FROM t t2
WHERE t2.tname="刘小林")

SELECT t1.tname,t1.ttitle,t1.tsalary
FROM t t1
WHERE EXISTS (SELECT *
FROM t t2
WHERE t2.tname="刘小林" AND t1.tsalary>t2.tsalary )

5.查询与'朱强'在同一个专业学习的学生姓名和性别。(比较运算符/EXISTS)

SELECT s1.sname,s1.ssex
FROM s s1
WHERE s1.dnum=(SELECT s2.dnum
FROM s s2
WHERE s2.sname="朱强")

SELECT s1.sname,s1.ssex
FROM s s1
WHERE EXISTS (SELECT *
FROM s s2
WHERE s2.sname="朱强" AND s1.dnum=s2.dnum )

6.找出每个学生超过他自己选修课程平均成绩的学号、课程号和成绩（两种方法：相关与派生表）
SELECT sc1.snum,sc1.cnum,sc1.score
FROM sc sc1 
WHERE sc1.score>(SELECT AVG(sc2.score)
FROM sc sc2
WHERE sc1.snum=sc2.snum  )

SELECT sc.snum,sc.cnum,sc.score
FROM sc,(SELECT snum,AVG(score) FROM sc GROUP BY snum) A(snum,score) 
WHERE sc.snum=A.snum AND sc.score>A.score 

7.查询各学院工资最高的教师信息。（两种方法：相关与派生表）
SELECT *
FROM t t1 
WHERE t1.tsalary=(SELECT MAX(t2.tsalary)
FROM t t2 
WHERE t1.collnum=t2.collnum)

SELECT *
FROM t,(SELECT collnum,MAX(t.tsalary) max_tsalary FROM t GROUP BY collnum ) A 
WHERE t.collnum=A.collnum AND t.tsalary=A.max_tsalary 

8.查询选修了全部课程的学生姓名(两种方法，NOT EXISTS,算数量)
SELECT sname 
FROM s
WHERE NOT EXISTS (SELECT *
FROM c
WHERE NOT EXISTS(SELECT *
FROM sc 
WHERE sc.snum=s.snum AND sc.cnum=c.cnum ))

SELECT s.sname
FROM s JOIN sc ON sc.snum=s.snum
GROUP BY s.snum 
HAVING COUNT(DISTINCT sc.cnum)=(SELECT COUNT(*) FROM c )

9.查询比'22'号学院所有教师工资都高的其他学院的教师信息。(两种方法ALL/MAX())
SELECT *
FROM t t1 
WHERE t1.collnum!="22" AND t1.tsalary  >ALL (SELECT t2.tsalary 
FROM t t2 
WHERE t2.collnum="22" )

SELECT *
FROM t t1 
WHERE t1.collnum!="22" AND t1.tsalary  > (SELECT MAX(t2.tsalary) 
FROM t t2 
WHERE t2.collnum="22" )


10.查询没有选修任何课程的学生信息。(NOT IN/NOT EXISTS)

SELECT *
FROM s
WHERE snum NOT IN (SELECT snum 
FROM sc)

SELECT *
FROM s s1 
WHERE NOT EXISTS(SELECT *
FROM sc
WHERE sc.snum=s1.snum )
