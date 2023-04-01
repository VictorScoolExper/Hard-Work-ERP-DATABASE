-- Insert the client record into the clients table
CREATE PROCEDURE sp_insert_client(
  IN p_first_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_email VARCHAR(255),
  IN p_cell_number VARCHAR(11),
  IN p_life_stage ENUM('customer', 'lead', 'opportunity'),
  IN p_addresses JSON
)
BEGIN
  DECLARE last_id BIGINT DEFAULT 0;
  DECLARE i INT DEFAULT 0;
  DECLARE num_addresses INT DEFAULT JSON_LENGTH(p_addresses);
  INSERT INTO clients(first_name, last_name, email, cell_number, life_stage)
  VALUES (p_first_name, p_last_name, p_email, p_cell_number, p_life_stage);
  SET last_id = LAST_INSERT_ID();
 
  SET i = 0;
  WHILE i < num_addresses DO
    INSERT INTO addresses(street, city, state, zip_code, country)
    VALUES (
      JSON_UNQUOTE(JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].street'))),
      JSON_UNQUOTE(JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].city'))),
      JSON_UNQUOTE(JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].state'))),
      JSON_UNQUOTE(JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].zip_code'))),
      JSON_UNQUOTE(JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].country')))
    );
    INSERT INTO client_addresses(address_id, client_id)
    VALUES (LAST_INSERT_ID(), last_id);
    SET i = i + 1;
  END WHILE;
END 

-- Get all clients
CREATE PROCEDURE sp_get_all_clients()
BEGIN
  SELECT * FROM clients;
END;

-- get addresses of client by client id
CREATE PROCEDURE sp_get_client_addresses(
  IN p_client_id BIGINT
)
BEGIN
  SELECT a.*
  FROM addresses a
  INNER JOIN client_addresses ca ON a.address_id = ca.address_id
  WHERE ca.client_id = p_client_id;
END;

-- get client by client id
CREATE PROCEDURE sp_get_client_info (
  IN p_client_id BIGINT
)
BEGIN
  SELECT *
  FROM clients
  WHERE client_id = p_client_id;
END;

-- Delete address
CREATE PROCEDURE sp_delete_address(
  IN p_client_id BIGINT,
  IN p_address_id BIGINT
)
BEGIN
  DELETE FROM client_addresses 
  WHERE client_id = p_client_id AND address_id = p_address_id;

  DELETE FROM addresses 
  WHERE address_id = p_address_id;
END;

-- update client
CREATE PROCEDURE sp_update_client (
  IN p_client_id BIGINT,
  IN p_first_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_email VARCHAR(255),
  IN p_cell_number VARCHAR(11),
  IN p_life_stage ENUM('Customer', 'Lead', 'Opportunity')
)
BEGIN
  UPDATE clients
  SET first_name = p_first_name,
      last_name = p_last_name,
      email = p_email,
      cell_number = p_cell_number,
      life_stage = p_life_stage
  WHERE client_id = p_client_id;
END;



