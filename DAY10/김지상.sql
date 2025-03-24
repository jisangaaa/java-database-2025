-- 1번
SELECT email
	 , mobile
	 , names
	 , addr
  FROM membertbl;


-- 2번
SELECT names AS 도서명
	 , author AS 저자
	 , isbn
	 , price AS 정가
  FROM bookstbl
 order BY isbn ASC;

COMMIT;





