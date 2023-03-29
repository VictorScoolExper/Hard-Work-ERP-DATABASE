-- add attend
CREATE PROCEDURE insert_attendance(IN emp_id BIGINT, IN att_status ENUM('present', 'absent'))
BEGIN
  INSERT INTO attendances(employee_id, status)
  VALUES(emp_id, att_status);
END 

-- get all attend by range of date
CREATE PROCEDURE sp_get_attended_users_by_date(IN start_date DATE, IN end_date DATE)
BEGIN
  SELECT a.attendance_id, a.status, a.employee_id, u.name, u.last_name, a.created_at AS punch_in_time
  FROM attendances a
  JOIN employees e ON a.employee_id = e.employee_id
  JOIN users u ON e.user_id = u.user_id
  WHERE a.status = 'present' AND DATE(a.created_at) BETWEEN start_date AND end_date;
END 

-- get attendance by id
CREATE PROCEDURE sp_get_attendance_record_by_id(IN attendance_id BIGINT)
BEGIN
  SELECT a.employee_id, u.name, u.last_name, a.status, DATE_FORMAT(a.created_at, '%Y-%m-%d %H:%i:%s') AS created_at
  FROM attendances a
  JOIN employees e ON a.employee_id = e.employee_id
  JOIN users u ON e.user_id = u.user_id
  WHERE a.attendance_id = attendance_id;
END


