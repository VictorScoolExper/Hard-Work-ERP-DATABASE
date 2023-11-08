-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_insert_company_role;
CREATE PROCEDURE sp_insert_company_role (
    IN p_name varchar(100),
    IN p_description text
)
BEGIN
    INSERT INTO company_roles (name, description)  
    VALUES (p_name, p_description);
END;

CALL sp_insert_company_role('test', 'test blaw blaw, naw naw');