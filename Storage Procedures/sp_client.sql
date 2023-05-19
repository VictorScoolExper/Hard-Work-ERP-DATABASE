-- Insert the client record into the clients table
CREATE PROCEDURE sp_insert_client(
  IN p_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_email VARCHAR(255),
  IN p_cell_number VARCHAR(15),
  IN p_life_stage ENUM('customer', 'lead', 'opportunity'),
  IN p_street VARCHAR(255),
  IN p_city VARCHAR(255),
  IN p_state VARCHAR(255),
  IN p_zip_code VARCHAR(255),
  IN p_country VARCHAR(255)
)
BEGIN
  DECLARE last_id BIGINT DEFAULT 0;

  INSERT INTO clients(name, last_name, email, cell_number, life_stage)
  VALUES (p_name, p_last_name, p_email, p_cell_number, p_life_stage);
  SET last_id = LAST_INSERT_ID();

  INSERT INTO addresses(street, city, state, zip_code, country)
  VALUES (p_street, p_city, p_state, p_zip_code, p_country);
 
  INSERT INTO client_addresses(address_id, client_id)
  VALUES (LAST_INSERT_ID(), last_id);
  
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
  IN p_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_email VARCHAR(255),
  IN p_cell_number VARCHAR(11),
  IN p_life_stage ENUM('Customer', 'Lead', 'Opportunity')
)
BEGIN
  UPDATE clients
  SET name = p_name,
      last_name = p_last_name,
      email = p_email,
      cell_number = p_cell_number,
      life_stage = p_life_stage
  WHERE client_id = p_client_id;
END;

-- Edit address by address_id
CREATE PROCEDURE sp_modify_address (
  IN p_address_id INT,
  IN p_street VARCHAR(255),
  IN p_city VARCHAR(255),
  IN p_state VARCHAR(255),
  IN p_zip_code VARCHAR(10),
  IN p_country VARCHAR(255)
)
BEGIN
  UPDATE addresses
  SET street = p_street, city = p_city, state = p_state, zip_code = p_zip_code, country = p_country
  WHERE address_id = p_address_id;
END;



