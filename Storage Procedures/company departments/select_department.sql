-- Green Work ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_select_department_name;
CREATE PROCEDURE sp_select_department_name(
    IN p_department_id int
)
BEGIN
	SELECT name FROM company_departments WHERE department_id = p_department_id;
END;

CALL sp_select_department_name(1);