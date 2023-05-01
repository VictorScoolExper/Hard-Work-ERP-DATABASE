-- add shift
CREATE PROCEDURE sp_add_shifts(
    IN shifts_array JSON
)
BEGIN
  DECLARE i INT DEFAULT 0;
  DECLARE shift_count INT;
  SELECT JSON_LENGTH(shifts_array) INTO shift_count;
  
  WHILE i < shift_count DO
    INSERT INTO shifts (employee_id, shift_date, start_time, end_time)
    SELECT 
      JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].employee_id')),
      STR_TO_DATE(REPLACE(JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].shift_date')), '"', ''), '%Y-%m-%d'),
      STR_TO_DATE(REPLACE(JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].start_time')), '"', ''), '%H:%i:%s'),
      STR_TO_DATE(REPLACE(JSON_EXTRACT(shifts_array, CONCAT('$[', i, '].end_time')), '"', ''), '%H:%i:%s');
    SET i = i + 1;
  END WHILE;
END;

-- get all shifts by date
CREATE PROCEDURE sp_get_shifts_by_date_range(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT s.shift_id, e.employee_id, u.name, u.last_name, s.shift_date, s.start_time, s.end_time
    FROM shifts s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN users u ON e.user_id = u.user_id
    WHERE s.shift_date BETWEEN start_date AND end_date;
END 

-- get shift ranged by date and employee id
CREATE PROCEDURE sp_get_shifts_employee_by_date_range(
    IN emp_id BIGINT,
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT s.shift_id, s.shift_date, s.start_time, s.end_time, 
           u.name, u.last_name, u.role, u.age, u.active
    FROM shifts s
    JOIN employees e ON s.employee_id = e.employee_id
    JOIN users u ON e.user_id = u.user_id
    WHERE s.employee_id = emp_id AND s.shift_date BETWEEN start_date AND end_date;
END;

-- get shift by id
CREATE PROCEDURE sp_get_shift_by_id(IN shift_id_param BIGINT)
BEGIN
    SELECT s.employee_id, u.name, u.last_name, u.role, s.start_time, s.end_time
    FROM shifts s
    INNER JOIN employees e ON s.employee_id = e.employee_id
    INNER JOIN users u ON e.user_id = u.user_id
    WHERE s.shift_id = shift_id_param;
END

-- Update by id
CREATE PROCEDURE sp_update_shift(
    IN p_shift_id BIGINT,
    IN p_start_time TIME,
    IN p_end_time TIME
)
BEGIN
    UPDATE shifts
    SET start_time = p_start_time, end_time = p_end_time
    WHERE shift_id = p_shift_id;
END 

-- Delete by ID
CREATE PROCEDURE sp_delete_shift_by_id(
  IN p_shift_id BIGINT
)
BEGIN
  DELETE FROM shifts WHERE shift_id = p_shift_id;
END








