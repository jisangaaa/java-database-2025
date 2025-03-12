/*
 * 내장함수
 * 문자(열) 함수
 */

-- INITCAP() 단어 첫글자 대문자로
SELECT INITCAP('hello oracle') AS "result" 
  FROM dual;  -- 실제하지 않는 테이블(oracl만!)

-- LOWER() 모든글자 소문자, UPPER() 모든글자 대문자로
SELECT LOWER(first_name) AS "first_name"
	 , UPPER(last_name) AS "last_name"
  FROM employees;

-- LENGTH() / LENGTHB()함수
SELECT LENGTH('hello oracle') -- 영어는 글자길이 12
     , LENGTHB('hello oracle') -- 12bytes
     , LENGTH('반가워요 오라클') -- 한글 글자길이는 8
     , LENGTHB('반가워요 오라클') -- 22bytes , 글자당 3~4 bytes
     , ASCII('A')
     , ASCII('a')
     , ASCII('가')
  FROM dual;

-- CONCAT() == || 와 동일기능
SELECT CONCAT(CONCAT(first_name, ' '), last_name) AS "full_name"
  FROM employees;




  

  

  
  
