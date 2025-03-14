/*
 * DML중 SELECT 외에
 * UPDATE, DELETE
 */
-- 삭제 
DELETE FROM (칼럼이름)
 WHERE profno = 1001;
 
DELETE FROM 칼럼이름 ;

CREATE TABLE 이름 (
	 idx NUMBER PRIMARY KEY,
	 name varchar2(20) NOT NULL,
	 jumin varchar2(14) NOT NULL UNIQUE,
	 loc_code number(1) CHECK (loc_code > 0 AND loc_code <5),
	 dcode varchar2(6) REFERENCES dept2(dcode)
);

-- 이름에 UNIQUE 제약조건을 추가로 걸때
ALTER TABLE new_emp
	ADD CONSTRAINT uk_name UNIQUE(name);

CREATE INDEX idx_date1 ON sample_t(date1);

SELECT *
  FROM sample_t
 WHERE test3 = 'A678';

-- auto 끄고나면 필히 commit
	 
	 
	 
	 
	 
	 
/*
 * 트랜잭션, COMMIT, ROLLBACK
 /*

-- SET TRANSACTION READ WRITE;  -- 안써도 무방

-- 테이블 복사
CREATE TABLE REGIONS_NEW
AS
 SELECT * FROM REGIONS;

-- 커밋
COMMIT;

-- 데이터 조회
SELECT * FROM REGIONS_NEW;

-- 실수로 전부삭제
DELETE FROM REGIONS_NEW;

ROLLBACK; -- 원상복귀, 트랜잭션은 종료안됨
COMMIT; -- 확정짓고 트랜잭션이 종료!

-- 실수로 모두 동일값으로 변경
UPDATE REGIONS_NEW SET
  REGION_NAME = 'North America';

-- 데이터 조회
SELECT * FROM REGIONS_NEW;

ROLLBACK; -- 원상복귀, 트랜잭션은 종료안됨
COMMIT; -- 확정짓고 트랜잭션이 종료!

-