-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_create_company_department;
CREATE PROCEDURE sp_create_company_department(
    IN p_name varchar(100),
    IN p_description text
)
BEGIN
	INSERT INTO company_departments (name, description)
	VALUES (p_name, p_description);
END;

CALL sp_create_company_department('example department', 'random text, blaw, blaw');