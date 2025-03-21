UPDATE MADANG.STUDENTS
	SET std_name = :v_std_name
	  , std_mobile = : v_std_mobile
	  , std_regyear = : v_std_regyear
 WHERE std_id = : v_std_id
 
SELECT * FROM students;

DELETE FROM students WHERE std_id = :v_std_id;

SELECT * FROM students;