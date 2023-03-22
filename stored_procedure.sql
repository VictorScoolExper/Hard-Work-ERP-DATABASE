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
  IN cell_number VARCHAR(8),
  IN role VARCHAR(20),
  IN age INT,
  IN email VARCHAR(200),
  IN password VARCHAR(200)
)
BEGIN
   -- procedure logic
   INSERT INTO users (name, last_name, cell_number, role, age, active)
   VALUES (name, last_name, cell_number, role, age, 1);

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
