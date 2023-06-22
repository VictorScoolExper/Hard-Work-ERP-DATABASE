-- Insert the client record into the clients table

CREATE PROCEDURE SP_INSERT_VENDOR(IN P_NAME VARCHAR
(100), IN P_LAST_NAME VARCHAR(100), IN P_COMPANY_ID 
BIGINT, IN P_CELL_NUMBER VARCHAR(20), IN P_EMAIL VARCHAR
(255), IN P_STREET VARCHAR(255), IN P_CITY VARCHAR
(100), IN P_STATE VARCHAR(100), IN P_ZIP_CODE VARCHAR
(20), IN P_COUNTRY VARCHAR(10)) BEGIN 
	DECLARE last_id BIGINT DEFAULT 0;
	START TRANSACTION;
	INSERT INTO
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
	INSERT INTO
	    addresses(
	        street,
	        city,
	        state,
	        zip_code,
	        country
	    )
	VALUES (
	        p_street,
	        p_city,
	        p_state,
	        p_zip_code,
	        p_country
	    );
	INSERT INTO
	    vendor_addresses (address_id, vendor_id)
	VALUES (LAST_INSERT_ID(), last_id);
	COMMIT;
END; 

-- Get all clients

CREATE PROCEDURE SP_GET_CLIENTS() BEGIN 
	-- select that fields we will work with
	SELECT
	    client_id,
	    name,
	    last_name,
	    email,
	    cell_number,
	    life_stage
	FROM clients;
END; 

-- get addresses of client by client id

CREATE PROCEDURE SP_GET_CLIENT_ADDRESSES(IN P_CLIENT_ID 
BIGINT) BEGIN 
	SELECT
	    a.address_id,
	    a.street,
	    a.city,
	    a.state,
	    a.zip_code
	FROM addresses AS a
	    INNER JOIN client_addresses AS ca ON a.address_id = ca.address_id
	WHERE
	    ca.client_id = p_client_id
	ORDER BY a.created_at DESC;
END; 

-- get client by client id

CREATE PROCEDURE SP_GET_CLIENT_BY_ID(IN P_CLIENT_ID 
BIGINT) BEGIN 
	SELECT
	    c.client_id,
	    c.name,
	    c.last_name,
	    c.email,
	    c.cell_number,
	    c.life_stage
	FROM clients AS c
	WHERE
	    c.client_id = p_client_id;
END; 

-- Delete address

CREATE PROCEDURE SP_DELETE_ADDRESS(IN P_CLIENT_ID BIGINT
, IN P_ADDRESS_ID BIGINT) BEGIN 
	START TRANSACTION;
	DELETE FROM client_addresses
	WHERE
	    client_id = p_client_id
	    AND address_id = p_address_id;
	DELETE FROM addresses WHERE address_id = p_address_id;
	COMMIT;
END; 

-- update client

CREATE PROCEDURE SP_UPDATE_CLIENT(IN P_CLIENT_ID BIGINT
, IN P_NAME VARCHAR(100), IN P_LAST_NAME VARCHAR(100
), IN P_EMAIL VARCHAR(255), IN P_CELL_NUMBER VARCHAR
(20), IN P_LIFE_STAGE ENUM('CUSTOMER', 'LEAD', 'OPPORTUNITY'
)) BEGIN 
	START TRANSACTION;
	UPDATE clients
	SET
	    name = p_name,
	    last_name = p_last_name,
	    email = p_email,
	    cell_number = p_cell_number,
	    life_stage = p_life_stage
	WHERE
	    client_id = p_client_id;
	COMMIT;
END; 

-- If you are looking for the update address for client checkout the sp_address file