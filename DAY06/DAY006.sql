/*
 * PL/SQL
 */
-- SET SERVEROUTPUT ON; --콘솔에서만 사용
DECLARE --선언부. 여기에 사용할 모든 변수를 선언해야
	v_empno	emp.empno%TYPE; --number(4,0);를 대체해서 특정테이블의 컬럼과 같은 데이터타입을 선언
	v_ename	varchar2(10); --emp.ename%TYPE; 와 동일
BEGIN --PL/SQL 은 시작
	SELECT empno, ename INTO v_empno, v_ename  --변수값을 할당
  	  FROM emp
 	 WHERE empno = :empno; --DYNAMIC 변수

	DBMS_OUTPUT.PUT_LINE(v_empno || '- 이 멤버의 이름은' || v_ename);
EXCEPTION	 -- 예외처리 부분
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('멤버가 없음!');
	WHEN TOO_MANY_ROWS THEN
		DBMS_OUTPUT.PUT_LINE('멤버가 너무많음!');
END; --PL/SQL 끝을 지정
/

COMMIT;

CALL up_sal(7900);

SELECT * FROM emp WHERE empno = 7900;


SELECT max_sal(10) FROM dual;

SELECT * FROM emp
 WHERE deptno = 10;


SELECT e.empno, e.name, e.deptno
     , (SELECT dname FROM dept2 WHERE dcode = e.deptno) AS "부서명"
     , (SELECT area FROM dept2 WHERE dcode = e.deptno) AS "지역"
  FROM emp2 e;


SELECT e.empno, e.name, e.deptno
     , get_dname(e.deptno) AS "부서명"
     , (SELECT area FROM dept2 WHERE dcode = e.deptno) AS "지역"
  FROM emp2 e;

-- 조인으로
SELECT e.empno, e.name, e.deptno, d.dname, d.area
  FROM emp2 e, dept2 d
 WHERE e.deptno = d.dcode;

COMMIT;








