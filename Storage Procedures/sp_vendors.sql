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
	vendors(
        name,
        last_name,
        company_id,
        cell_number,
        email
    )
    VALUES (
        p_name,
        p_last_name,
        p_company_id,
        p_cell_number,
        p_email
    );
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
    SELECT v.vendor_id, v.name, v.last_name, v.cell_number, v.email, v.company_id,
        a.address_id, a.street, a.city, a.state, a.zip_code, a.country
    FROM vendors v
    -- The LEFT JOIN includes all rows from the vendors table, even if there is no 
    -- match in the vendor_addresses or addresses tables. This ensures that all vendors 
    -- are returned, regardless of whether they have associated addresses or not.
    LEFT JOIN vendor_addresses va ON v.vendor_id = va.vendor_id
    LEFT JOIN addresses a ON va.address_id = a.address_id;
END

-- get single vendor by vendor id
CREATE PROCEDURE sp_get_single_vendor(
  IN p_id BIGINT
)
BEGIN 
    SELECT v.vendor_id, v.name, v.last_name, v.cell_number, v.email, v.company_id,
        a.address_id, a.street, a.city, a.state, a.zip_code, a.country
    FROM vendors v
    JOIN vendor_addresses va ON v.vendor_id = va.vendor_id
    JOIN addresses a ON va.address_id = a.address_id
    WHERE v.vendor_id = p_id; 
END

-- get vendor address by vendor id
CREATE PROCEDURE sp_get_vendor_addresses(IN p_vendor_id BIGINT)
BEGIN
    SELECT a.address_id, a.street, a.city, a.state, a.zip_code, a.country
    FROM addresses a
    INNER JOIN vendor_addresses va ON a.address_id = va.address_id
    WHERE va.vendor_id = p_vendor_id;
END 

-- update vendor and address if neccesary
DROP PROCEDURE IF EXISTS sp_update_vendor;
CREATE PROCEDURE sp_update_vendor(
    IN p_vendor_id BIGINT, 
    IN p_name VARCHAR(100), 
    IN p_last_name VARCHAR(100),
    IN p_company_id BIGINT,
    IN p_cell_number VARCHAR(20),
    IN p_email VARCHAR(255),
    IN p_addressId INT,
    IN p_street VARCHAR(255),
    IN p_city VARCHAR(100),
    IN p_state VARCHAR(100),
    IN p_zip_code VARCHAR(15),
    IN p_country VARCHAR(5),
    IN p_include_address VARCHAR(5)
)
BEGIN
	START TRANSACTION;
	UPDATE vendors
	SET 
	        name = p_name, 
	        last_name = p_last_name, 
	        company_id = p_company_id, 
	        cell_number = p_cell_number,
	        email = p_email
	WHERE
	vendor_id = p_vendor_id;
	   
	IF p_include_address = true THEN
		 IF p_addressId IS NULL THEN
		 	INSERT INTO addresses(street, city, state, zip_code, country)
		    VALUES (p_street, p_city, p_state, p_zip_code, p_country);
		   
		    INSERT INTO vendor_addresses (address_id, vendor_id)
		    VALUES (LAST_INSERT_ID(), p_vendor_id);
		 ELSE 
		 	UPDATE addresses
		    SET street = p_street, city = p_city, state = p_state, zip_code = p_zip_code, country = p_country
		    WHERE address_id = p_addressId;
		 END IF; 
    END IF;
   COMMIT;
END;

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


