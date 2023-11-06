

-- Get all Employees
CREATE PROCEDURE sp_get_employee_list()
BEGIN
    SELECT u.name, u.last_name, u.cell_number, u.role, u.birth_date, u.active, e.employee_id, e.user_id, e.job_title, e.department, e.driver_license, e.start_date, e.wage_per_hour, e.image_name, e.email
    FROM users u
    INNER JOIN employees e
    ON u.user_id = e.user_id;
END;


-- Get employee by ID
CREATE PROCEDURE sp_get_employee_by_id (
    IN p_employee_id BIGINT,
    OUT p_name VARCHAR(200),
    OUT p_last_name VARCHAR(200),
    OUT p_cell_number VARCHAR(20),
    OUT p_role VARCHAR(20),
    OUT p_birth_date DATE,
    OUT p_active VARCHAR(10),
    OUT p_image_name VARCHAR(255), 
    OUT p_job_title VARCHAR(100),
    OUT p_department VARCHAR(100),
    OUT p_driver_license VARCHAR(250),
    OUT p_start_date DATE,
    OUT p_wage_per_hour DECIMAL(10, 2),
    OUT p_email VARCHAR(255)
)
BEGIN
    SELECT u.name, u.last_name, u.cell_number, u.role, u.birth_date, u.active, e.image_name, e.job_title,
        e.department, e.driver_license, e.start_date, e.wage_per_hour, e.email
    INTO p_name, p_last_name, p_cell_number, p_role, p_birth_date, p_active,  p_image_name, p_job_title,
        p_department, p_driver_license, p_start_date, p_wage_per_hour, p_email
    FROM employees e
    JOIN users u ON e.user_id = u.user_id
    WHERE e.employee_id = p_employee_id;
END;


-- Edit Employee User details // update the created_by in employees
CREATE PROCEDURE sp_update_employee_details(
    IN p_employee_id BIGINT,
    IN p_name VARCHAR(200),
    IN p_last_name VARCHAR(200),
    IN p_cell_number VARCHAR(20),
    IN p_role VARCHAR(20),
    IN p_birth_date DATE,
    IN p_active VARCHAR(10),
    IN p_image_name VARCHAR(255),
    IN p_job_title VARCHAR(100),
    IN p_department VARCHAR(100),
    IN p_driver_license VARCHAR(250),
    IN p_start_date DATE,
    IN p_wage_per_hour DECIMAL(10, 2),
    IN p_updated_by BIGINT,
    IN p_email VARCHAR(255)
)
BEGIN
    
    -- Update user record
    UPDATE users
    SET name = p_name,
        last_name = p_last_name,
        cell_number = p_cell_number,
        role = p_role,
        birth_date = p_birth_date,
        active = p_active,
        updated_at = NOW()
    WHERE user_id = (
        SELECT user_id FROM employees WHERE employee_id = p_employee_id
    );
    
    -- Update employee record
    UPDATE employees
    SET image_name = p_image_name,
        edited_by  = p_updated_by,
    	job_title = p_job_title,
        department = p_department,
        driver_license = p_driver_license,
        start_date = p_start_date,
        wage_per_hour = p_wage_per_hour,
        updated_at = NOW(),
        email = p_email
    WHERE employee_id = p_employee_id;
END 

-- Delete Employee
CREATE PROCEDURE sp_delete_employee_and_user(IN p_employee_id INT)
BEGIN
  -- Get the user_id from the employees table
  DECLARE userId INT;
  SELECT user_id INTO userId FROM employees WHERE employee_id = p_employee_id;

  -- Delete the record from the employees table
  -- DELETE FROM employees WHERE employee_id = p_employee_id;

  -- Delete the corresponding record from the users table
  DELETE FROM users WHERE user_id = userId;
END



