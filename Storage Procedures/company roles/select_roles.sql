-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_select_company_roles;
CREATE PROCEDURE sp_select_company_roles ()
BEGIN
    SELECT * FROM company_roles;
END;

CALL sp_select_company_roles();

-----------------------------------------------------------------------------
--------- SELECT name using role_id
DROP PROCEDURE IF EXISTS sp_select_company_name;
CREATE PROCEDURE sp_select_company_role_name(
    IN p_role_id int
)
BEGIN
	SELECT name FROM company_roles WHERE role_id = p_role_id;
END;

CALL sp_select_company_name(1);