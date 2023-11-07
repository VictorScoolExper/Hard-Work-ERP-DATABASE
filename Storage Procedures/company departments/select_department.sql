-- Green Work ERP by Victor Martinez
--------------------------------------------------------------------------------
-------- Get All Department ----------------------
DROP PROCEDURE IF EXISTS sp_select_company_departments;
CREATE PROCEDURE sp_select_company_departments()
BEGIN
	SELECT * FROM company_departments;
END;
CALL sp_select_company_departments();

--------------------------------------------------------------------------------
-------- Get Department by Id ----------------------
DROP PROCEDURE IF EXISTS sp_select_company_departments_by_id;
CREATE PROCEDURE sp_select_company_departments_by_id(
	IN p_department_id int
)
BEGIN
	SELECT * FROM company_departments WHERE department_id = p_department_id;
END;

CALL sp_select_company_departments_by_id(1);

--------------------------------------------------------------------------------
-------- Get Department Name ----------------------
DROP PROCEDURE IF EXISTS sp_select_department_name;
CREATE PROCEDURE sp_select_department_name(
    IN p_department_id int
)
BEGIN
	SELECT name FROM company_departments WHERE department_id = p_department_id;
END;
CALL sp_select_department_name(1);