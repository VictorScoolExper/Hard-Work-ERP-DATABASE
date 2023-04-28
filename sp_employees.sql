-- Create Employee
CREATE PROCEDURE sp_insert_employee(
    IN p_name VARCHAR(200),
    IN p_last_name VARCHAR(200),
    IN p_cell_number VARCHAR(20),
    IN p_role VARCHAR(20),
    IN p_age INT,
    IN p_job_title VARCHAR(100),
    IN p_department VARCHAR(100),
    IN p_driver_license VARCHAR(250),
    IN p_start_date DATE,
    IN p_wage_per_hour DECIMAL(10, 2),
    IN p_created_by_user BIGINT
)
BEGIN
    DECLARE p_user_id BIGINT;

    -- Insert user record first
    INSERT INTO users (name, last_name, cell_number, role, age, active)
    VALUES (p_name, p_last_name, p_cell_number, p_role, p_age, "true");

    -- Get the user_id of the newly created user
    SET p_user_id = LAST_INSERT_ID();

    -- Insert employee record
    INSERT INTO employees (user_id, created_by, edited_by, job_title, department, driver_license, start_date, wage_per_hour)
    VALUES (p_user_id, p_created_by_user, p_created_by_user, p_job_title, p_department, p_driver_license, p_start_date, p_wage_per_hour);
END

-- Get all Employees
CREATE PROCEDURE sp_get_employee_list()
BEGIN
    SELECT u.name, u.last_name, u.cell_number, u.role, u.age, u.active, e.employee_id, e.user_id, e.job_title, e.department, e.driver_license, e.start_date, e.end_date, e.wage_per_hour
    FROM users u
    INNER JOIN employees e
    ON u.user_id = e.user_id;
END;


-- Get employee by ID
CREATE PROCEDURE sp_get_employee_by_id(
    IN p_employee_id BIGINT,
    OUT p_name VARCHAR(200),
    OUT p_last_name VARCHAR(200),
    OUT p_cell_number VARCHAR(20),
    OUT p_role VARCHAR(20),
    OUT p_age INT,
    OUT p_active VARCHAR(10),
    OUT p_job_title VARCHAR(100),
    OUT p_department VARCHAR(100),
    OUT p_driver_license VARCHAR(250),
    OUT p_start_date DATE,
    OUT p_end_date DATE,
    OUT p_wage_per_hour DECIMAL(10, 2)
)
BEGIN
    SELECT u.name, u.last_name, u.cell_number, u.role, u.age, u.active, e.job_title,
        e.department, e.driver_license, e.start_date, e.end_date, e.wage_per_hour
    INTO p_name, p_last_name, p_cell_number, p_role, p_age, p_active, p_job_title,
        p_department, p_driver_license, p_start_date, p_end_date, p_wage_per_hour
    FROM employees e
    JOIN users u ON e.user_id = u.user_id
    WHERE e.employee_id = p_employee_id;
END 


-- Edit Employee User details // update the created_by in employees
CREATE PROCEDURE sp_update_employee_details(
    IN p_employee_id BIGINT,
    IN p_name VARCHAR(200),
    IN p_last_name VARCHAR(200),
    IN p_cell_number VARCHAR(20),
    IN p_role VARCHAR(20),
    IN p_age INT,
    IN p_active VARCHAR(10),
    IN p_job_title VARCHAR(100),
    IN p_department VARCHAR(100),
    IN p_driver_license VARCHAR(250),
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_wage_per_hour DECIMAL(10, 2),
    IN p_updated_by BIGINT
)
BEGIN
    
    -- Update user record
    UPDATE users
    SET name = p_name,
        last_name = p_last_name,
        cell_number = p_cell_number,
        role = p_role,
        age = p_age,
        active = p_active,
        updated_at = NOW()
    WHERE user_id = (
        SELECT user_id FROM employees WHERE employee_id = p_employee_id
    );
    
    -- Update employee record
    UPDATE employees
    SET edited_by  = p_updated_by,
    	job_title = p_job_title,
        department = p_department,
        driver_license = p_driver_license,
        start_date = p_start_date,
        end_date = p_end_date,
        wage_per_hour = p_wage_per_hour,
        updated_at = NOW()
    WHERE employee_id = p_employee_id;
END 



