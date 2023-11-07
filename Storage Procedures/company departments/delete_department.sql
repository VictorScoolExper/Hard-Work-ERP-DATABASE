-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_delete_department_except_admin;
CREATE PROCEDURE sp_delete_department_except_admin(
    IN p_department_id INT
)
BEGIN
    -- Declare a variable to store the department name
    DECLARE department_name VARCHAR(100);

    -- Retrieve the department name associated with the provided ID
    SELECT name INTO department_name FROM company_departments WHERE department_id = p_department_id;

    -- Check if the department name is 'admin'
    IF department_name = 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Delete rejected: Cannot delete department with name "admin"';
    ELSE
        -- Delete all rows in the department except those with the name 'admin'
        DELETE FROM company_departments WHERE department_id = p_department_id AND name <> 'admin';
    END IF;
END

CALL sp_delete_department_except_admin(4);