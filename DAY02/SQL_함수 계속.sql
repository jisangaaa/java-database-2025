/* 단일행함수 */
-- 한행한열만 출력되는 값을 = 스칼라(Scalar)값

SELECT CONCAT('Hello','Oracle')    
  FROM dual;

-- 인덱스가 1부터 시작함 / 파이썬은 0부터
--SUBSTR(변환할 값, 인덱스, 길이 ) - 파이썬 substring() 함수와 동일, 
-- 인덱스 -뒤에서부터 위치

SELECT substr(email,1,2)
 	 , substr(email,1,2)
 	 , email
  FROM employees;

-- 전화번호자를때, 주민번호 자를때 SUBSTR()활용

-- INSTR(체크할문자열, 찾는글자, 시작위치, 몇번째)
SELECT '010-9999-8888'
	 , instr('010-9999-8888','-',1,2)
  FROM dual;


-- LPAD(문자열, 자리수, 채울문자), RPAD(문자열, 자리수, 채울문자)
-- 2025-3-12 -> 2025-03-12
SELECT LPAD('100',7,'0')
	 , RPAD('ABC',7,'-')
  FROM dual;

--TRIM() 함수 트리플. -- 파이썬 strip() 함수와 동일.
--LTRIM(), RTRIM(), TRIM() -- 진짜 많이씀
SELECT '<<<' || '     Hello Oracle     ' || '>>>'
	 , '<<<' || ltrim('     Hello Oracle     ') || '>>>'
	 , '<<<' || rtrim('     Hello Oracle     ') || '>>>'
	 , '<<<' || trim('     Hello Oracle     ') || '>>>'      
  FROM dual;

-- REPLACE(), 파이썬에도 동일하게 존재 -- 많이씀
SELECT phone_number
	 , replace(phone_number, '123', '786') 
  FROM employees;

/*
 * 숫자함수, 집계함수와 같이 사용 많이됨.
 */
--ROUND() 반올림함수
-- CEIL() 올림함수, FLOOR() 내림함수, TRUNC() 내림함수 소수점
-- MOD() 나누기의 나머지값 - 파이썬 mode(), % 연산자와 동일
-- POWER() 파이썬 math.pow(), power(), 2^10 승수와 계산 동일
SELECT 786.5427 AS res1
	 , round(786.5427) AS round0     --소수점없이
	 , round(786.5427, 1) AS round1    --소수점1
	 , round(786.5427, 2) AS round2    -- 소수점2
	 , ceil(786.5427) AS ceilRes
	 , floor(786.5427) AS floorRes
	 , trunc(786.5427, 3) AS truncRes
	 , mod(10,3) AS "나머지"
	 , power(2,10) AS "2의 10승"
  FROM dual;

/*
 * 날짜함수, 나라마다 표현방식 다름
 * 한국아시아 : 2025-03-12
 * 미국캐나다 : March/12/2025
 * 영국유럽멕시코베트남 : 12/March/2025
 * 포맷팅을 많이함.
 */
-- 오늘날짜
SELECT sysdate AS 오늘날짜-- GMT기준, +09필요
	-- 날짜 포맷팅에 사용되는 YYYY
	-- AM/PM, HH, HH24, MI, SS, W, Q(분기)
	 , TO_CHAR(sysdate, 'YYYY-MM-DD DAY') AS 한국식
	 , TO_CHAR(sysdate, 'AM HH24:MI:SS') AS 시간
	 , TO_CHAR(sysdate, 'MON/DD/YYYY') AS "미국식"
	 , TO_CHAR(sysdate, 'DD/MM/YYYY') AS "영국식"
  FROM dual;

-- ADD_MONTHS() 월 추가 함수
SELECT hire_date
	 , to_char(hire_date, ' yyyy-mm-dd') AS 입사일자
	 , add_months(hire_date,3) AS 정규직일자
	 , next_day(hire_date, '월') AS 다음주월요일  -- 'MON''TUE''WED''TUR''FRI''SAT''SUN'
	 , last_day('2025-02-05') AS 달마지막날
  FROM employees;

-- GMT + 9HOUR
-- 인터벌 숫자뒤 HOUR,DAY,MONTH,YEAR
SELECT to_char(sysdate + INTERVAL '9' HOUR, 'YYYY-MM-DD HH24:MI:SS') AS 서울시간
  FROM dual;


/*
 * 형 변환 함수
 */
-- TO_CHAR()
-- 숫자형을 문자형으로 변경
SELECT 12345 AS 원본
	 , to_char(12345,'9999999') AS "원본+두자리빈자리"
	 , to_char(12345,'0999999') AS "원본+두자리0"	
	 , to_char(12345,'$99999') AS "통화단위+원본"
	 , to_char(12345,'99999.99') AS "소수점"
	 , to_char(12345,'99,999') AS "천단위 쉼표"       --ㅈㄴ많이씀
  FROM dual;

-- TO_NUMBER() 문자형된 데이터를 숫자로
SELECT '5.0' * 5
	 , to_number('5.0') AS 숫자형변환
  FROM dual;

-- TO_DATE() 날짜형태를 문자형으로
SELECT '2025-03-12'
	 , TO_date('2025-03-12') + 10  -- 날짜형으로 바꾸면 연산가능
  FROM dual;

/*
 * 일반함수
 */
-- NVL(컬럼|데이터, 바꿀값) 널값을 다른값으로 치환
SELECT commission_pct
	 , nvl(commission_pct, 0.0 )    -- 꽤 쓰임
  FROM employees;

SELECT nvl(hire_date, sysdate)   -- 입사일자가 비어있으면 오늘날짜로 대체
  FROM employees;

-- NVL2(컬럼|데이터, 널이 아닐때 처리, 널일때 처리할 부분)
SELECT commission_pct
	 , salary
	 , nvl2(commission_pct, salary + (salary*commission_pct), salary ) AS 커미션급여
  FROM employees;

-- decode(a, b, '1', '2') A가 B일경우 1 아니면 2
-- 오라클에만 있는 함수
SELECT email, phone_number, job_id
	 , DECODE(job_id, 'IT_PROG', '개발자만세!!', '나머진 다 죽어') AS 캐치프레이즈
  FROM employees;
-- WHERE job_id = 'IT_PROG';

/*
 * CASE 구문, 정말중요!
 * IF,ELIF의 중복된 구문과 유사
 */



























 