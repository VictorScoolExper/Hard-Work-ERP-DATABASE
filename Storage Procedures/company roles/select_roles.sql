DROP PROCEDURE IF EXISTS sp_select_company_name;
CREATE PROCEDURE sp_select_company_name(
    IN p_role_id int
)
BEGIN
	SELECT name FROM company_roles WHERE role_id = p_role_id;
END;

CALL sp_select_company_name(1);