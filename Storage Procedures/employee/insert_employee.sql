-- Green Works ERP by Victor Martinez

-- Create Employee 
CREATE PROCEDURE `sp_insert_employee`(
    IN p_name VARCHAR(200),
    IN p_last_name VARCHAR(200),
    IN p_cell_number VARCHAR(20),
    IN p_role int,
    IN p_birth_date VARCHAR(255),
    IN p_image_name VARCHAR(255),
    IN p_job_title int,
    IN p_department int,
    IN p_driver_license VARCHAR(250),
    IN p_start_date DATE,
    IN p_wage_per_hour DECIMAL(10, 2),
    IN p_created_by_user BIGINT,
    IN p_email varchar(255)
)
BEGIN
    DECLARE p_user_id BIGINT;

    -- Insert user record first
    INSERT INTO users (name, last_name, cell_number, role_id, birth_date, active)
    VALUES (p_name, p_last_name, p_cell_number, p_role, p_birth_date, "true");

    -- Get the user_id of the newly created user
    SET p_user_id = LAST_INSERT_ID();

    -- Insert employee record
    INSERT INTO employees (user_id, image_name,created_by, edited_by, job_title_id, company_department_id, driver_license, start_date, wage_per_hour, email)
    VALUES (p_user_id, p_image_name, p_created_by_user, p_created_by_user, p_job_title, p_department, p_driver_license, p_start_date, p_wage_per_hour, p_email);
END;
