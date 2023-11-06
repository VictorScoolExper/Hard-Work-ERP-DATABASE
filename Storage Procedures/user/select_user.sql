-- TODO: delete sp_find_auth
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