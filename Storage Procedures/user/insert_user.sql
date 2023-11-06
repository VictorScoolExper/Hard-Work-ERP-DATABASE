-- Insert function
CREATE PROCEDURE `sp_insert_user`(
  IN name VARCHAR(200),
  IN last_name VARCHAR(200),
  IN cell_number VARCHAR(20),
  IN role_id int,
  IN birth_date DATE,
  IN email VARCHAR(200),
  IN password VARCHAR(200)
)
BEGIN
   -- procedure logic
   INSERT INTO users (name, last_name, cell_number, role_id, birth_date, active)
   VALUES (name, last_name, cell_number, role_id, birth_date, "true");

   SET @user_id = LAST_INSERT_ID();

   INSERT INTO auths (user_id, email, password)
   VALUES (@user_id, email, password);
END;
