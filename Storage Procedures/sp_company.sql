-- create company
CREATE PROCEDURE sp_create_company 
(
	IN p_name VARCHAR(100), 
	IN p_company_type VARCHAR(100)
)
BEGIN
 START TRANSACTION;
  INSERT INTO companies (name, service_type) VALUES (p_name, p_company_type);
 COMMIT;
END

-- get company by company id
CREATE PROCEDURE sp_get_company_by_id(IN companyId INT)
BEGIN
  SELECT name FROM companies WHERE company_id = companyId;
END

-- get all companies
CREATE PROCEDURE sp_get_companies()
BEGIN
  SELECT company_id, name, service_type FROM companies;
END

-- edit company
CREATE PROCEDURE sp_update_company(
    IN p_company_id BIGINT,
    IN p_name VARCHAR(100),
    IN p_service_type VARCHAR(100)
)
BEGIN
	START TRANSACTION;
	    UPDATE companies
	    SET name = p_name,
          service_type = p_service_type
	    WHERE company_id = p_company_id;
  COMMIT;
END

-- returns if company exists in table
CREATE PROCEDURE sp_check_company_exists(IN p_company_id BIGINT)
BEGIN
    SELECT EXISTS(SELECT 1 FROM companies WHERE company_id = p_company_id);
END
