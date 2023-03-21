CREATE PROCEDURE sp_find_auth(
    IN email VARCHAR(200)
)
BEGIN
    SELECT * FROM auths WHERE email = email;
END


CREATE PROCEDURE sp_insert_user(
  IN name VARCHAR(200),
  IN last_name VARCHAR(200),
  IN cell_number VARCHAR(8),
  IN age INT,
  IN email VARCHAR(200),
  IN password VARCHAR(200)
)
BEGIN
   -- procedure logic
   INSERT INTO users (name, last_name, cell_number, age, activo)
   VALUES (name, last_name, cell_number, age, 1);

   SET @user_id = LAST_INSERT_ID();

   INSERT INTO auths (user_id, email, password)
   VALUES (@user_id, email, password);
END;

CALL InsertUser('John', 'Doe', '12345678', 30, 'johndoe@email.com', 'password');
