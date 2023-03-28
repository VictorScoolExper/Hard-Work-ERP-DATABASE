-- add shift
CREATE PROCEDURE sp_add_shift(
    IN p_employee_id  BIGINT,
    IN p_attendance_date DATE, 
    IN p_shift_date DATE,
    IN p_start_time TIME,
    IN p_end_time TIME
)
BEGIN

    INSERT INTO shifts(employee_id, attendance_date, )