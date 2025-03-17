/*
 * VIEW
 */
-- sysdba로 실행
GRANT CREATE VIEW TO sampleuser;

--
SELECT * FROM emp2;
 
-- 뷰생성 DDL
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, deptno, tel, POSITION, pempno
	  FROM emp2;
	  
-- 뷰로 select
SELECT *
 FROM v_emp2;
 
 -- 뷰로 INSERT
-- NOT NULL 조건 있으면 데이터 삽입 불가
INSERT INTO v_emp2 VALUES (20000219, 'Tom Holland', 1004, '051)627-9968', 'IT Programmer',19960303);

-- DEPTNO컬럼 not null인데 뷰에는 존재하지않아. INSERT 불가
INSERT INTO v_emp2 VALUES (20000220, 'Zen Daiya', '051)627-9968', 'IT Programmer',19960303);

COMMIT;

--CRUD 중 SELECT만 가능하게 만들려면
CREATE OR REPLACE VIEW V_emp2
AS
	SELECT empno, name, deptno, tel, POSITION, pempno
	  FROM emp2
WITH READ ONLY;

-- 삽입불가
INSERT INTO v_emp2 VALUES (20000221, 'Hugo Sung', 1004, '051)627-9768', 'IT Programmer',19960303);

-- 복합뷰. 조인등으로 여러 테이블을 합쳐서 보여주는 뷰
-- 복합뷰는 ISNERT, UPDATE, DELETE 거의 불가
CREATE OR REPLACE VIEW V_emp3
AS

	SELECT e.empno, e.name, e.deptno, d.dname
	  FROM emp2 e, dept2 d
	 WHERE e.deptno = d.dcode;

-- 조회
SELECT * FROM emp2;

/*
 * 서브쿼리
 */

SELECT * FROM student;
SELECT * FROM department;

--join으로 두 테이블 검색
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = 103;

-- Anthony Hopkins 학생과 같은 학과에 다니는 학생을 모두 조회
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1
					  FROM student 
					 WHERE name = 'Anthony Hopkins'); -- 학생이름따라 학과번호가 변경가능

SELECT deptno1 FROM student WHERE name = 'Anthony Hopkins';

-- where절 서브쿼리에서 = 로 비교할때 주의점
-- where절 서브쿼리는 다중행이 되면 안됨
SELECT s.name, d.dname
  FROM student s, department d
 WHERE s.deptno1 = d.deptno
   AND s.deptno1 = (SELECT deptno1
					  FROM student);

-- 특정교수의 입사일보다 뒤에 입사한 교수들의 정보출력
SELECT *
  FROM professor;

SELECT *
  FROM department;

-- 단일행 서브쿼리 = <> > >= 등

SELECT p.name AS "PROF_NAME"
	  , p.hiredate
	  , d.dname AS "DEPT_NAME"
  FROM professor p, department d
 WHERE p.deptno = d.deptno
	AND p.hiredate > (SELECT hiredate
						FROM professor
					   WHERE name = 'Meg Ryan');

SELECT hiredate
  FROM professor
 WHERE name = 'Meg Ryan';   -- 스칼라값
 
 COMMIT;

-- 다중행 서브쿼리
-- IN 서브쿼리 결과와 같은값. 여러개 (OR과 동일)
-- EXISTS 서브쿼리 값이 있는 경우 메인쿼리 실행
-- >ANY 서브쿼리의 결과 중 최소값을 반환해서 수행
-- <ANY 서브쿼리 결과 중 최대값을 반환
-- <ALL 서브쿼리 결과중 최소값을 반환 
-- >ALL 서브쿼리 결과 중 최대값을 반환
 
 
-- 지역이 Pohang Office인 부서코드 해당하는 직원들의 사번, 이름 ,부서번호를 출력

SELECT dcode
  FROM dept2
 WHERE area = 'Pohang Main Office'; 
 
-- 결과
SELECT empno, name, deptno
  FROM emp2
 WHERE deptno IN (SELECT dcode
  					FROM dept2
 				   WHERE area = 'Pohang Main Office');

-- emp2 에서 'Section head' 직급의 최소 연봉보다 높은 사람의 이름, 직급, 연봉을 출력
-- 단, 연봉은 $75,000,000 식으로 출력할 것
DELETE FROM emp2 
 WHERE empno = '20000219';

COMMIT;

SELECT *
  FROM emp2;

SELECT *
  FROM dept2;


SELECT *
  FROM emp2
 WHERE EXISTS (SELECT *
			 	  FROM emp2
				 WHERE POSITION = 'Section head');

--서브쿼리 Min함수 최소값 스칼라에서 비교연산으로
SELECT name, POSITION
	  , '$' || TO_char(pay, '999,999,999') AS "SALARY"
  FROM emp2
 WHERE pay > (SELECT min(pay)
 			   FROM emp2
			  WHERE POSITION = 'Section head');

-- >ANY로 서브쿼리 다중행에서 최소값
SELECT name, POSITION
	  , TO_char(pay, '999,999,999') AS "SALARY"
  FROM emp2
 WHERE pay > ANY (SELECT pay
 			   FROM emp2
			  WHERE POSITION = 'Section head');

COMMIT;
  
-- 다중 컬럼 서브쿼리, 파이썬 튜플과 동일
SELECT grade, name, height, weight 
  FROM student 
 WHERE (grade, weight) IN (SELECT grade, max(weight)
							 FROM student
                            GROUP BY grade);

SELECT grade, max(weight)
  FROM student 
 GROUP BY grade;


--교수테이블과 학과department 테이블 조회하여 학과별로 입사일이 가장 오래된 교수의 번호, 이름,학과명을 출력
-- 입사일 순으로 오름차순
SELECT p.profno, p.name, d.dname
  FROM professor p, department d
 WHERE p.deptno = d.deptno
	AND (p.deptno, p.hiredate) IN (SELECT deptno, min(hiredate)
                                     FROM professor
                             		WHERE deptno IS NOT null  
                             		GROUP BY deptno);

SELECT deptno, min(hiredate)
  FROM professor
 WHERE deptno IS NOT NULL  
 GROUP BY deptno;
 
SELECT e.empno, e.name, e.deptno
	, (SELECT dname FROM dept2 WHERE dcode = e.deptno) AS "부서명"
	, (SELECT area FROM dept2 WHERE dcode = e.deptno) AS "지역"
  FROM emp2 e;

-- 여기까지 스칼라 서브쿼리
-- from절 서브쿼리
SELECT *
  FROM emp2;

SELECT empno, name, birthday
	 , deptno, emp_type, tel
  FROM emp2;

--from절에 소괄호 내에 서브쿼리를 작성하는 방식
SELECT *
  FROM (SELECT empno, name, birthday
	 , deptno, emp_type, tel 
	 	FROM emp2);

SELECT *
  from(SELECT deptno, sum(pay)
  		 FROM emp2
 		GROUP BY deptno);  


SELECT deptno, sum(pay)
   FROM emp2
 GROUP BY deptno;  


/*
 * 시퀀스, 자동증가값
 */
--시퀀스 사용않는 주문테이블
CREATE TABLE order_noseq(
	  order_idx NUMBER PRIMARY KEY,
	  order_nm varchar(20) NOT NULL,
	  order_prd varchar(100) NOT NULL,
	  qty		  NUMBER DEFAULT 1
);

--시퀀스 사용하는 주문테이블
CREATE TABLE order_seq(
	  order_idx NUMBER PRIMARY KEY,
	  order_nm varchar(20) NOT NULL,
	  order_prd varchar(100) NOT NULL,
	  qty		  NUMBER DEFAULT 1
);

COMMIT;

--시퀀스 생성
CREATE SEQUENCE S_order
INCREMENT BY 1
START WITH 1;

--시퀀스 없는 order_noseq
INSERT INTO order_noseq VALUES (1,'홍길동','망고',20);
INSERT INTO order_noseq VALUES (2,'홍길동','망고',10);
INSERT INTO order_noseq VALUES (3,'홍길순','블루베리',2);

--시퀀스쓰면 order_seq
INSERT INTO order_seq VALUES(S_order.nextval,'홍길동','애플망고',10);
INSERT INTO order_seq VALUES(S_order.nextval,'홍길동','망고',200);

COMMIT;

SELECT * FROM order_seq;

--시퀀스 개체의 현재번호가 얼마인지 확인
SELECT S_order.currval FROM dual;
SELECT S_order.nextval FROM dual;

-- 시퀀스 삭제
DROP SEQUENCE 

/*
 * 사용자 생성, 기존 사용자 사용해제, 권한주기
 */

--HR 계정 잠금해제
ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY 12345;

SELECT *
  FROM employees;

/*
--SCOTT 계정 잠금해제. 계정없음
ALTER USER scott ACCOUNT UNLOCK;

--scott에서 접속권한 부여
GRANT CREATE SESSION TO scott;
flush PRIVILEGES;
*/

SELECT * FROM jobs;

CREATE VIEW JOBS_VIEW
AS
	SELECT *
	  FROM jobs;

--hr계정에 어떤 권한이 있는지 조회
SELECT *
  FROM USER_TAB_PRIVS;

-- HR 테이블생성
CREATE TABLE TEST(
	  id NUMBER PRIMARY KEY,
	  name varchar(20) NOT NULL
);

-- role 관리
-- role 확인
-- CONNECT - DB접속 및 테이블생성 조회 권한
-- resource -pl/sql 사용권한
-- DBA - 모든 시스템 권함
-- EXP_FULL_DATABASE - DB 익스포터 권한
SELECT * FROM user_role_privs;

SELECT * FROM dba_role_privs;

-- HR에게 DBA의 역할 role부여
GRANT DBA TO hr;

SELECT * FROM MEMBER;

--HR에게 DBA권한 해제
REVOKE DBA FROM hr;

COMMIT;










 




