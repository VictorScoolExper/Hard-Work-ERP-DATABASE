-- add attend
CREATE PROCEDURE insert_attendance(IN emp_id BIGINT, IN att_status ENUM('present', 'absent'))
BEGIN
  INSERT INTO attendances(employee_id, status)
  VALUES(emp_id, att_status);
END 


