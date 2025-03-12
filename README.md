# java-database-2025
java개발자 과정 database 리포지토리

## 1일차
- Github Desktop 설치
    - https://desktop.github.com/download/ 다운로드
    - 기본 깃허브 계정으로 로그인
    - git 명령어 없이 사용가능
- Database(DB) 개요
    - 데이터를 저장하는 장소, 서비스를 하는 서버
    - 데이터베이스를 관리하는 프로그램 DBMS
    - 가장 유명한 것 Oracle
    - 사용자는 SQL로 요청, DB서버는 처리결과를 테이블로 리턴
    - SQL 배우는 것!
- Oracle 설치 (Docker)
    1. powershell 오픈 # docker pull doctorkirk/oracle-19c
       ```
       > docker pull oracleinanutshell/oracle-xe-11g
       ```
    2. 다운로드 이미지 확인
        ```shell
        ps c:\User\Admin> docker image ls
        REPOSITORY                 TAG       IMAGE ID       CREATED         SIZE
        ```
    3. 도커 컨테이너 실행
        ```shell
        > docker run --name oracle11g -d -p 1521:1521 --restart=always oracleinanutshell/oracle-xe-11g
        ```
        - 1521 - 오라클 기본포트
        - 아이디 system / oracle 

    4. 도커 실행확인
        - Docker Desktop > Containers 확인
    5. powershell 오픈
        ```shell
        > docker exec -it oracle19c bash
        [oracle@7ec8e1146679 ~]$ sqlplus / as sysdba
        SQL > 
        ```
    6. DBeaver 접속
        - DBeaver 툴 설치
            - https://dbeaver.io/download/
        - connection > select your DB > oracle 선택
        - ![alt text](image-1.png)
        <img src="./image/db001.png" width="650">

- DML, DDL, DCL
    - 언어의 특징을 가지고 있음
        - 프로그래밍언어와의 차이 : 어떻게(HOW)
        - SQL : 무엇(WHAT)
    - SQL의 구성요소 3가지
    - DDL(Data control Language) - 데이터베이스 생성, 테이블 생성, 객체 생성, 수정, 삭제
        - CREATE, ALTER, DROP ...
    - DCL(Data control Language) - 사용자 권한 부여, 해제, 트랜잭션 시작, 종료
        - GRANT, REVOKE, BEGIN TRANS, COMMIT, ROLLBACK
    - DML(Data manupulation Language) - 데이터 조작언어, 데이터 삽입, 조회, 수정, 삭제
        - `INSERT`, `SELECT`, `UPDATE`,`DELETE`

- SELECT 기본
    - 데이터 조회 시 사용되는 기본명령어
        ```sql
        --(주석) 한줄 기본주석
        /* 여러줄 주석가능 */
        SELECT [ALL|DISTINCT] [*|컬럼명(리스트들)]
            FROM 테이블명(들)
        [WHERE 검색조건(들)]
        [GROUP BY 속성명(들)]
        [HAVING 집계함수조건(들)]
        [ORDER BY 정렬속성(들) ASC|DESC]
        [WITH ROLLUP]
        ```
    - 기본 쿼리 학습 : [SQL]()
        1. 기본 SELECT
        2. WHERE 조건절
        3. NULL(!)
        4. ORDER BY 정렬
        5. 집합
- 함수(내장함수)
    - 문자함수 : [SQL]C:\source\java-database-2025\DAY01\sql002_함수.sql

## 2일차
- 함수 계속
    - 문자함수 부터: "C:\source\java-database-2025\DAY02\SQL_함수 계속.sql"
    - 숫자함수
    - 날짜함수
    - 형변환함수
- 복수행 함수 :
    - 집계함수:
    - GROUP BY :
    - HAVING :
    - ROLLUP :
    - RANK, DENSE_RANK, ROW_NUMBER :

- 데이터베이스 타입형
    - **CHAR(n)** - 고정형 문자열, 최대 2000바이트
        - **CHAR(20)** 으로 'Hello World' 입력하면 , 'Hello World         ' 로 저장
    - **VARCHAR(n)** - 가변형 문자열, 최대 4000바이트
        - 'Hello World'
        - **VARCHAR(20)** 으로 'Hello World' 입력하면 , 'Hello World' 로 저장
    - **NUMBER(P,S)** - 숫자값, P 전체자리수, S소수점길이. 최대 22byte
    - INTEGER - 모든 데이터의 기준. 4BYTE, 정수를 담는 데이터형
    - float(p) - 실수형 타입, 최대 22byte
    - **DATE** - 날짜타입
    - **LONG(n)** - 가변길이 문자열, 최대 2G바이트
    - LONG RAW(n) -원시이진 데이터, 최대 2G바이트
    - CLOB -대용량 텍스트 데이터타입, 최대 4G
    - BLOB -대용량 바이너리 데이터타입, 최대 4G
    - BFILE -외부파일에 저장된 데이터, 4G

## 3일차
- JOIN
    - 카티션곱
    - 내부조인, 외부조인
- DDL
    - CREATE, ALTER, DROP

    


