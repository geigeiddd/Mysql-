1.将新生（学号:202301010101;姓名:伍俊;性别:男;出生日期:2005-08-08;系编号:0501）的记录插入学生表,并为其选:c01、c02与c03三门课程。
INSERT INTO s(snum,sname,ssex,sbirth,dnum)
VALUES("20230101010101","伍俊","男","2005-08-08","0501");
INSERT INTO sc(snum,cnum,score)
VALUES("20230101010101","c01","50"),
("20230101010101","c02","50"),
("20230101010101","c03","50");
2.建立课程号、课程名、平均成绩与选课人数表 cc。并将数据存入到该表中。
CREATE TABLE cc
AS 
SELECT c.cnum 课程号, c.cname 课程名, AVG(sc.score) 平均成绩, COUNT(sc.snum) 选课人数
FROM c LEFT JOIN sc ON c.cnum=sc.cnum
GROUP BY c.cnum,c.cname  
3.事后发现'雷吉平'考试作弊，将其所有成绩改为0分。
UPDATE sc
SET score=0
WHERE snum IN (SELECT snum
FROM s
WHERE sname="雷吉平");
4.将所有教授的工资上调10%（不超过30000，LEAST()）。
UPDATE t
SET tsalary =LEAST(tsalary*1.1,30000)
WHERE ttitle="教授";
5.将'计算机科学与技术'专业全体学生的成绩置零。
UPDATE sc
SET score=0
WHERE snum IN (SELECT s.snum
FROM s,d 
WHERE s.dnum=d.dnum AND d.dname="计算机科学与技术");
6.将'朱超'任命为‘信息工程学院’院长。
UPDATE coll 
SET tnum=(SELECT tnum
FROM t
WHERE tname="朱超")
WHERE collname="信息工程学院";
7.将'信息工程学院'院长的工资降为该学院的平均工资。
CREATE VIEW v_t(avgt)
AS
SELECT AVG(tsalary)
FROM t t2,coll 
WHERE t2.collnum=coll.collnum AND coll.collname="信息工程学院"

UPDATE t
SET tsalary=(SELECT avgt FROM v_t)
WHERE t.tnum IN (SELECT tnum 
FROM coll
WHERE collname="信息工程学院")
8.在学生表中增加flag标志列，如果该同学选课，则flag置1,如果未选课，则flag置0。
DESC s;
SELECT *
FROM s;
ALTER TABLE s ADD flag TINYINT UNSIGNED;

UPDATE s
SET flag=1
WHERE snum IN (SELECT DISTINCT snum FROM sc);

UPDATE s
SET flag=0
WHERE snum NOT IN (SELECT DISTINCT snum FROM sc);
9.'雷吉平'由于考试作弊被退学，删除该学生记录及其选课记录。
DELETE FROM sc
WHERE snum IN (SELECT snum
FROM s
WHERE sname="雷吉平")
DELETE FROM s
WHERE sname="雷吉平"
10.删除低于平均工资的老师记录以及任课记录。
DELETE FROM tc
WHERE tnum IN (SELECT tnum
FROM t
WHERE tsalary <(SELECT AVG(tsalary)
FROM t))
11.删除'计算机科学与技术'专业全体学生的选课记录。
DELETE FROM sc
WHERE snum IN (SELECT snum
FROM s,d 
WHERE s.dnum=d.dnum AND d.dname="计算机科学与技术")
12.删除没有选课的学生信息。
DELETE FROM s
WHERE snum NOT IN (SELECT DISTINCT snum
FROM sc)