1.创建一个视图view_s，显示成绩等于100分的学生的学号、姓名、课程名和成绩。
CREATE VIEW view_s AS 
SELECT s.snum"学号",s.sname"姓名",c.cname"课程名",sc.score"成绩"
FROM s JOIN sc ON s.snum=sc.snum JOIN c ON sc.cnum=c.cnum
WHERE sc.score=100;

SELECT *
FROM view_s;
2.建立'计算机科学与技术'专业选修了'数据库原理与技术'这门课程的学生视图view_cs。（学号，姓名，成绩）
CREATE VIEW view_cs AS 
SELECT s.snum"学号",s.sname"姓名",sc.score"成绩"
FROM s JOIN d ON s.dnum=d.dnum JOIN sc ON s.snum=sc.snum JOIN c ON sc.cnum=c.cnum
WHERE d.dname="计算机科学与技术" and c.cname='数据库原理与技术';

SELECT *
FROM view_cs;
3.(要求创建基于视图的视图)建立'计算机科学与技术'专业选修了'数据库原理与技术'这门课程且成绩在90分以上的学生视图view_cs90。（学号，姓名，成绩）
删除视图view_cs并观察view_cs90是否可用。
CREATE VIEW view_cs90 AS 
SELECT *
FROM view_cs
WHERE 成绩>90;

DROP VIEW view_cs;

SELECT *
FROM view_cs90;
4.建立'计算机科学与技术'专业的学生的学号，姓名和平均成绩的视图。
CREATE VIEW view_cs_avg AS 
SELECT s.snum"学号",s.sname"姓名",AVG(sc.score)"平均成绩"
FROM s JOIN d ON s.dnum=d.dnum LEFT JOIN sc ON s.snum=sc.snum 
WHERE d.dname="计算机科学与技术" 
GROUP BY s.snum,s.sname;

SELECT *
FROM view_cs_avg;
5.将学院名称及该学院教师的平均工资定义为一个视图。
CREATE VIEW view_coll_avg AS 
SELECT coll.collname"学院名称",AVG(t.tsalary)"平均工资"
FROM coll JOIN t ON coll.collnum=t.collnum  
GROUP BY coll.collname;

SELECT *
FROM view_coll_avg;
6.建立一视图显示教师的工号，姓名和年龄。
CREATE VIEW view_t_age AS 
SELECT t.tnum"工号",t.tname"姓名",YEAR(CURDATE())-YEAR(t.tbirth)"年龄"
FROM t ;

SELECT *
FROM view_t_age;
7.建立'0501'（专业编号）专业学生的视图view_0501（学号、姓名、性别专业编号），并要求进行修改和插入操作时仍需保证该视图只有'0501'专业的学生。利用视图view_0501分别插入专业编号为'0501'和'0502'的学生,查询能否加入。
CREATE VIEW view_0501 AS
SELECT s.snum"学号",s.sname"姓名",s.ssex"性别",s.dnum"专业编号"
FROM s
WHERE s.dnum="0501"
WITH CHECK OPTION;

SELECT*
FROM view_0501;

INSERT INTO view_0501(学号, 姓名, 性别, 专业编号) 
VALUES ('202301010102', '老六', '男', '0501');

INSERT INTO view_0501(学号, 姓名, 性别, 专业编号) 
VALUES ('202301010103', '唐嘉祺', '女', '0502');
8.对每个学生找出其获得最高成绩的课程的课程号,学号和成绩。
先定义一个视图view_maxs求出每个同学的最高成绩，然后用查询语句完成。
CREATE VIEW view_maxs AS
SELECT sc.snum"学号", MAX(sc.score) "最高成绩"
FROM sc
GROUP BY snum;

SELECT * 
FROM view_maxs;


SELECT sc.snum "学号", sc.cnum "课程号", sc.score "成绩"
FROM sc
JOIN view_maxs vm ON sc.snum = vm.学号 AND sc.score = vm.最高成绩;
