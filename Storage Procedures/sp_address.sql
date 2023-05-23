-- Edit address by address_id
CREATE PROCEDURE sp_update_address (
  IN p_address_id INT,
  IN p_street VARCHAR(255),
  IN p_city VARCHAR(255),
  IN p_state VARCHAR(255),
  IN p_zip_code VARCHAR(10),
  IN p_country VARCHAR(255)
)
BEGIN
  START TRANSACTION;
    UPDATE addresses
    SET street = p_street, city = p_city, state = p_state, zip_code = p_zip_code, country = p_country
    WHERE address_id = p_address_id;
  COMMIT;
END;