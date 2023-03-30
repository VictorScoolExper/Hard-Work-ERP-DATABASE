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

-- get attendances of employee 
CREATE PROCEDURE sp_get_attendances_by_date_range_and_employee(
  IN start_date DATE,
  IN end_date DATE,
  IN employee_id BIGINT
)
BEGIN
  SELECT a.attendance_id, e.employee_id, u.name, u.last_name, a.status, a.created_at
  FROM attendances a
  JOIN employees e ON e.employee_id = a.employee_id
  JOIN users u ON u.user_id = e.user_id
  WHERE e.employee_id = employee_id
  AND DATE(a.created_at) BETWEEN start_date AND end_date;
END

-- Modify attendances 
CREATE PROCEDURE sp_modify_attendance_status(
  IN p_attendance_id BIGINT,
  IN p_new_status ENUM('present', 'absent')
)
BEGIN
  UPDATE attendances SET status = p_new_status WHERE attendance_id = p_attendance_id;
END;

-- Delete attendance entry
CREATE PROCEDURE sp_delete_attendance(
  IN p_attendance_id BIGINT
)
BEGIN
  DELETE FROM attendances WHERE attendance_id = p_attendance_id;
END;



