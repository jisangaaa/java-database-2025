
    -- sys(sysdba)로 작업
    -- madang 스키마, 사용자 생성
    CREATE USER madang IDENTIFIED BY madang;

    -- 권한 설정
    GRANT CONNECT, resource TO madang;

    -- madang으로 사용 스키마 변경
    -- 테이블 Student 생성
    CREATE TABLE Students (
        std_id       NUMBER          PRIMARY KEY,
        std_name    varchar2(100)    NOT NULL,
        std_mobile    varchar2(15)    NULL,
        std_regyear   number(4, 0)   NOT NULL   
    );

    -- Students용 시퀀스 생성
    CREATE SEQUENCE SEQ_STUDENT
        INCREMENT BY 1      -- 숫자를 1씩 증가
        START WITH 1;      -- 1부터 숫자가 증가됨

    
    -- madang 로그인
    -- 조회
    SELECT * FROM Students;

    -- 더미데이터 삽입
    INSERT INTO Students (std_id, std_name, std_mobile, std_regyear)
    VALUES (SEQ_STUDENT.nextval, '홍길동', '010-9999-8888', 1997);
    INSERT INTO Students (std_id, std_name, std_mobile, std_regyear)
    VALUES (SEQ_STUDENT.nextval, '홍길순', '010-9999-8877', 2000);

    COMMIT;
   