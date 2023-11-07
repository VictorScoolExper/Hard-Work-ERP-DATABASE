-- Green Works ERP by Victor Martinez

DROP PROCEDURE IF EXISTS sp_update_company_department;
CREATE PROCEDURE sp_update_company_department(
    IN p_department_id INT,
    IN p_name VARCHAR(100),
    IN p_description TEXT
)
BEGIN
    IF p_name = 'admin' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Update rejected: Cannot update department with name "admin"';
    ELSE
        UPDATE company_departments
        SET name = p_name, description = p_description
        WHERE department_id = p_department_id;
    END IF;
END;

CALL sp_update_company_department(3, 'edited department', 'edited description, naw naw naw! naw!');
