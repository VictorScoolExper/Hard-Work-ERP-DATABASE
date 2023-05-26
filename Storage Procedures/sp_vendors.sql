-- Add Vendor with address
CREATE PROCEDURE sp_insert_vendor(
  IN p_name VARCHAR(100),
  IN p_last_name VARCHAR(100),
  IN p_company_id BIGINT,
  IN p_cell_number VARCHAR(20),
  IN p_email VARCHAR(255),
  IN p_street VARCHAR(255),
  IN p_city VARCHAR(100),
  IN p_state VARCHAR(100),
  IN p_zip_code VARCHAR(20),
  IN p_country VARCHAR(10),
  IN p_include_address VARCHAR(5)
)
BEGIN
  DECLARE last_id BIGINT DEFAULT 0;
  START TRANSACTION;
    INSERT
	INTO
	vendors(name,
	last_name,
	company_id,
	cell_number,
	email)
VALUES (p_name,
p_last_name,
p_company_id,
p_cell_number,
p_email);
--    save for vendor_address insert
    SET last_id = LAST_INSERT_ID();
   
IF p_include_address = true THEN
    INSERT INTO addresses(street, city, state, zip_code, country)
    VALUES (p_street, p_city, p_state, p_zip_code, p_country);
   
    INSERT INTO vendor_addresses (address_id, vendor_id)
    VALUES (LAST_INSERT_ID(), last_id);
 
END IF;
  COMMIT;
END;


-- get all vendors 
CREATE PROCEDURE sp_get_all_vendor()
BEGIN 
  SELECT * FROM vendors;
END

-- get single vendor by vendor id
CREATE PROCEDURE sp_get_single_vendor(
  IN p_id BIGINT
)
BEGIN 
  SELECT * FROM vendors WHERE vendor_id = p_id;
END

-- get vendor address by vendor id
CREATE PROCEDURE sp_get_vendor_addresses(IN v_vendor_id BIGINT)
BEGIN
    SELECT a.*
    FROM addresses a
    INNER JOIN vendor_addresses va ON a.address_id = va.address_id
    WHERE va.vendor_id = v_vendor_id;
END 

-- modify vendor 
CREATE PROCEDURE sp_modify_vendor(
    IN v_vendor_id BIGINT, 
    IN v_first_name VARCHAR(100), 
    IN v_last_name VARCHAR(100),
    IN v_company_id BIGINT,
    IN v_cell_number VARCHAR(20),
    IN v_email VARCHAR(255)
)
BEGIN
    UPDATE vendors
    SET 
        first_name = v_first_name, 
        last_name = v_last_name, 
        company_id = v_company_id, 
        cell_number = v_cell_number,
        email = v_email
    WHERE vendor_id = v_vendor_id;
END 

-- Delete address by recieving vendor_id and address_id
CREATE PROCEDURE sp_delete_vendor_address(
    IN v_vendor_id BIGINT, 
    IN v_address_id BIGINT
)
BEGIN
    -- Delete the record from vendor_addresses table
    DELETE FROM vendor_addresses WHERE vendor_id = v_vendor_id AND address_id = v_address_id;

    -- Check if the address is no longer used in vendor_addresses table
    IF NOT EXISTS (SELECT * FROM vendor_addresses WHERE address_id = v_address_id) THEN
        -- If the address is not used, delete the record from addresses table
        DELETE FROM addresses WHERE address_id = v_address_id;
    END IF;
END 

-- Update Vendor Address 
CREATE PROCEDURE sp_update_address(
    IN v_vendor_id BIGINT,
    IN v_address_id BIGINT,
    IN v_street VARCHAR(255),
    IN v_city VARCHAR(255),
    IN v_state VARCHAR(255),
    IN v_zip_code VARCHAR(255),
    IN v_country VARCHAR(255)
)
BEGIN
    -- Check if the vendor and address are associated with each other
    IF EXISTS (SELECT * FROM vendor_addresses WHERE vendor_id = v_vendor_id AND address_id = v_address_id) THEN
        -- If the vendor and address are associated with each other, update the record in addresses table
        UPDATE addresses SET
            street = v_street,
            city = v_city,
            state = v_state,
            zip_code = v_zip_code,
            country = v_country
        WHERE address_id = v_address_id;
    END IF;
END;

