1.在选课表SC上创建触发器，当向该表中插入记录时，若学生选课门数超过5门时，给出提示信息，限选5门。并验证该触发器。
CREATE TRIGGER tr_sc
BEFORE INSERT 
ON sc
FOR EACH ROW
BEGIN
	SELECT COUNT(*) c_count
	FROM sc
	WHERE snum=NEW.snum
	IF c_count>=5 THEN 
		SIGNAL SQLSTATE"45000"
		SET message="学生选课不能超过五门"
	END IF 
END//

INSERT INTO sc(snum,cnum,score)
VALUES ("201305010101","c01",90);
2.在选课表SC上创建触发器，当向该表中插入记录时，学生成绩在[0,100]，成绩小于0时置0，大于100时置100。并验证该触发器。
CREATE TRIGGER tr_score
BEFORE INSERT 
ON sc
FOR EACH ROW
BEGIN
	IF NEW.score<0 THEN
		SET NEW.score=0;
	END IF 
	IF NEW.score>100 THEN
		SET NEW.score=100;
	END IF
END//

INSERT INTO sc(snum,cnum,score)
VALUES ("201305010101","c01",-5);
INSERT INTO sc(snum,cnum,score)
VALUES ("201305010102","c02",110);
INSERT INTO sc(snum,cnum,score)
VALUES ("201305010103","c03",90);
3.当操作者对sc表的score进行update操作时，触发器会在UPDATE 操作之后，将操作记录写入。Logid自动增长，updateby记录修改者，updateon记录修改时间。并验证该触发器。

-- 创建日志表（如果不存在）

CREATE TABLE IF NOT EXISTS audit_log (
    logid INT PRIMARY KEY AUTO_INCREMENT,
    snum CHAR(12),
    cnum CHAR(12),
    old_score SMALLINT UNSIGNED,
    new_score SMALLINT UNSIGNED,
    updateby VARCHAR(50),
    updateon DATETIME
);

CREATE TRIGGER tr_update 
AFTER INSERT 
ON sc
FOR EACH ROW
BEGIN
	IF NEW.score!=OLD.score THEN
		INSERT INTO audit_log(snum,cnum,old_score,new_score,updateby,updateon)
		VALUES (OLD.snum,OLD.cnum,OLD.score,NEW.score,USER(),NOW());
	END IF
END//

INSERT INTO sc(snum,cnum,score)
VALUES ("201305010101","c01",90);
UPDATE sc
SET score=85
WHERE snum="201305010101" AND cnum="c01"

SELECT *
FROM audit_log

4.创建一触发器,在删除某一专业记录的同时删除该专业所有的学生记录,以及该专业学生的所有选课记录。并验证该触发器。
CREATE TRIGGER tr_delete
BEFORE DELETE 
ON d
FOR EACH ROW
BEGIN
	DELETE FROM sc
	WHERE snum IN (
		SELECT snum
		FORM s
		WHERE dnum=OLD.dnum);
	DELETE FROM s
	WHERE dnum=OLD.dnum;
END//

DELETE FROM d
WHERE dnum="0501"