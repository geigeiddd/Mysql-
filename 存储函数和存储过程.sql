-- 创建存储函数前请执行

SET GLOBAL log_bin_trust_function_creators=1;

1.创建一存储函数f_s，学号作为参数，返回该同学的平均成绩。并调用该存储函数。
DESC s;

CREATE FUNCTION f_s(ssnum CHAR(14))
RETURNS DECIMAL(5,1)

BEGIN
	DECLARE avg_score DECIMAL(5,1)
	SELECT AVG(score) INTO avg_score
	FROM sc
	WHERE snum=ssnum 
	RETURN IFNULL(avg_score,0);
END //

SELECT f_s('')
2.创建一个函数f_credit，输入学号，返回该学生已修课程的总学分。
并调用该存储函数。

CREATE FUNCTION f_credit(ssnum CHAR(14))
RETURNS DECIMAL(5,1)

BEGIN
	DECLARE tcredit DECIMAL(5,1)
	SELECT SUM(credit) INTO tcredit 
	FROM sc JOIN c ON sc.cnum=c.cnum 
	WHERE sc.snum=ssnum 
	RETURN IFNULL(tcredit,0);
END //
3.创建一存储过程p_s，学号作为输入参数，显示该同学的平均成绩，并调用该存储过程。
CREATE PROCEDURE p_s(IN ssnum CHAR(14))
BEGIN
	DECLARE avg_score DECIMAL(5,1);
	SELECT AVG(score) INTO avg_score
	FROM sc
	WHERE snum=ssnum ;
	
	SELECT ssnum "学号"
IFNULL(avg_score,0) "平均成绩"
END// 
4.创建一存储过程p_c完成向课程表(c)中插入一条记录，记录值通过输入参数传递到存储过程中，并调用该存储过程,将课程号:c11,课程名:MySQL,学分:3.5添加到数据库中。
DESC c;
CREATE PROCEDURE p_c(
	IN ccnum CHAR(12),
	IN ccname VARCHAR(50),
	IN ccredit DECIMAL(5,1))
BEGIN
	INSERT INTO c(cnum,cname,credit)
	VALUES(ccnum,ccname,ccredit)
END// 

CALL p_c("c11","MySQL",3.5);
5.创建一个存储过程p_a，输入课程号，输出该课程的平均成绩、最高分和最低分。并调用该存储过程。
CREATE PROCEDURE p_a(
	IN ccnum CHAR(12),
	OUT pjcj DECIMAL(5,1),
	OUT zgf DECIMAL(5,1),
	OUT zdf DECIMAL(5,1)
)

BEGIN
	SELECT AVG(score),MAX(score),MIN(score)
	INTO pjcj,zgf,zdf
	FROM sc
	WHERE cnum=ccnum
	
END//

CALL p_a("c01",pjcj,zgf,zdf)