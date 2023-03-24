-- Returns user by email
CREATE PROCEDURE sp_find_auth(
    IN email VARCHAR(200)
)
BEGIN
    SELECT * FROM auths WHERE email = email;
END

-- returns if true or false
CREATE PROCEDURE sp_bool_email_auth (
  IN email_to_check VARCHAR(255), 
  OUT email_exists BOOLEAN
)
BEGIN
    SELECT EXISTS(SELECT 1 FROM `auths` WHERE email = email_to_check) INTO email_exists;
END

CALL sp_bool_email_auth('example@email.com', @email_exists);
SELECT @email_exists;

-- Insert function
CREATE PROCEDURE sp_insert_user(
  IN name VARCHAR(200),
  IN last_name VARCHAR(200),
  IN cell_number VARCHAR(20),
  IN role VARCHAR(20),
  IN age INT,
  IN email VARCHAR(200),
  IN password VARCHAR(200)
)
BEGIN
   -- procedure logic
   INSERT INTO users (name, last_name, cell_number, role, age)
   VALUES (name, last_name, cell_number, role, age);

   SET @user_id = LAST_INSERT_ID();

   INSERT INTO auths (user_id, email, password)
   VALUES (@user_id, email, password);
END;

CALL sp_insert_user('John', 'Doe', '12345678', 'admin', 30, 'johndoe@email.com', 'password');

-- This can be transformed to be used dynamically
CREATE PROCEDURE sp_check_auth_empty (IN table_name VARCHAR(255), OUT is_empty BOOLEAN)
BEGIN
    DECLARE num_rows INT;
    
    SELECT COUNT(*) INTO num_rows FROM auths;
    
    IF num_rows = 0 THEN
        SET is_empty = TRUE;
    ELSE
        SET is_empty = FALSE;
    END IF;
END

CALL sp_check_auth_empty('my_table', @is_empty);
SELECT @is_empty AS is_empty;

CREATE PROCEDURE sp_get_user_auth(IN email_in VARCHAR(200))
BEGIN
  SELECT users.user_id, auths.password, users.name, users.last_name, users.role 
  FROM users 
  JOIN auths ON users.user_id = auths.user_id 
  WHERE auths.email = email_in;
END 

CALL sp_get_user_auth('example@example.com');

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
    VALUES (p_name, p_last_name, p_cell_number, p_role, p_age, 1);

    -- Get the user_id of the newly created user
    SET p_user_id = LAST_INSERT_ID();

    -- Insert employee record
    INSERT INTO employees (user_id, created_by_user, job_title, department, driver_license, start_date, wage_per_hour)
    VALUES (p_user_id, p_created_by_user, p_job_title, p_department, p_driver_license, p_start_date, p_wage_per_hour);
END

-- Get all Employees active or inactive
CREATE PROCEDURE get_employee_list(IN is_active)
BEGIN
    SELECT u.name, u.last_name, u.cell_number, u.role, u.age, e.job_title, e.department, e.driver_license, e.start_date, e.end_date, e.wage_per_hour
    FROM users u
    INNER JOIN employees e
    ON u.user_id = e.user_id
    WHERE u.active = is_active;
END;