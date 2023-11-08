-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_update_company_role;
CREATE PROCEDURE sp_update_company_role (
	IN p_role_id int,
	IN p_name varchar(100),
	IN p_description text
)
BEGIN
	-- Declare a variable to store the role name
    DECLARE role_name varchar(100);
   
   -- Retrieve the role name associated with the provided ID
   	SELECT name into role_name FROM company_roles WHERE role_id = p_role_id;
   
   -- Check of the role name is 'admin'
   IF role_name = 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Delete rejected: Cannot update role with name "admin"';
    ELSE
        UPDATE company_roles
        SET name = p_name, description = p_description
        WHERE role_id = p_role_id AND name <> 'admin';
    END IF;
END;
CALL sp_update_company_role(4, 'MEOW', 'naw naw naw roar again');