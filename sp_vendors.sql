-- Add Vendor with address
CREATE PROCEDURE sp_insert_vendor(
  IN p_first_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_company_id BIGINT,
  IN p_cell_number VARCHAR(20),
  IN p_email VARCHAR(255),
  IN p_addresses JSON
)
BEGIN
  DECLARE last_id BIGINT DEFAULT 0;
  DECLARE i INT;
  DECLARE num_addresses INT DEFAULT JSON_LENGTH(p_addresses);
 
 
  INSERT INTO vendors(first_name, last_name, company_id, cell_number, email)
  VALUES (p_first_name, p_last_name, p_company_id, p_cell_number, p_email);
  SET last_id = LAST_INSERT_ID();

  SET i = 0;
  WHILE i < num_addresses DO
    INSERT INTO addresses(street, city, state, zip_code, country)
    VALUES (
      JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].street')),
      JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].city')),
      JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].state')),
      JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].zip_code')),
      JSON_EXTRACT(p_addresses, CONCAT('$[', i, '].country'))
    );
    INSERT INTO vendor_addresses(address_id, vendor_id)
    VALUES (LAST_INSERT_ID(), last_id);
    SET i = i + 1;
  END WHILE;
END;