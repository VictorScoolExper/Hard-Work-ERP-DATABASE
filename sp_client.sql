-- add client and list of address
CREATE PROCEDURE sp_insert_client (
  IN p_first_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_email VARCHAR(255),
  IN p_cell_number VARCHAR(11),
  IN p_life_stage ENUM('Customer', 'Lead', 'Opportunity'),
  IN p_address_list TEXT
)
BEGIN
  DECLARE v_client_id BIGINT;
  DECLARE v_address_id BIGINT;
  DECLARE v_street VARCHAR(255);
  DECLARE v_city VARCHAR(255);
  DECLARE v_state VARCHAR(255);
  DECLARE v_zip_code VARCHAR(255);
  DECLARE v_country VARCHAR(255);
  DECLARE v_address_list_length INT DEFAULT 0;
  DECLARE i INT DEFAULT 1;
  
  -- Insert the client record into the clients table
CREATE PROCEDURE sp_insert_client (
  IN p_first_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_email VARCHAR(255),
  IN p_cell_number VARCHAR(11),
  IN p_life_stage ENUM('customer', 'lead', 'opportunity'),
  IN p_addresses JSON
)
BEGIN
  DECLARE last_id BIGINT DEFAULT 0;

  INSERT INTO clients (first_name, last_name, email, cell_number, life_stage)
  VALUES (p_first_name, p_last_name, p_email, p_cell_number, p_life_stage);

  SET last_id = LAST_INSERT_ID();

  INSERT INTO addresses (street, city, state, zip_code, country)
  SELECT JSON_EXTRACT(a, '$.street'), JSON_EXTRACT(a, '$.city'), JSON_EXTRACT(a, '$.state'), JSON_EXTRACT(a, '$.zip_code'), JSON_EXTRACT(a, '$.country')
  FROM JSON_TABLE(p_addresses, '$[*]' COLUMNS (
    a JSON PATH '$'
  )) AS j;

  INSERT INTO client_addresses (client_id, address_id)
  SELECT last_id, address_id
  FROM addresses
  WHERE address_id >= LAST_INSERT_ID() - JSON_LENGTH(p_addresses);
END;

-- Get all clients
CREATE PROCEDURE sp_get_all_clients()
BEGIN
  SELECT * FROM clients;
END;

-- get addresses of client by id
CREATE PROCEDURE sp_get_client_addresses(
  IN p_client_id BIGINT
)
BEGIN
  SELECT addresses.*
  FROM client_addresses
  JOIN addresses ON client_addresses.address_id = addresses.address_id
  WHERE client_addresses.client_id = p_client_id;
END;



