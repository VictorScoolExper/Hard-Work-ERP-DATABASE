-- create company
CREATE PROCEDURE sp_create_company (IN company_name VARCHAR(255))
BEGIN
 START TRANSACTION;
  INSERT INTO companies (name) VALUES (company_name);
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
  SELECT company_id, name FROM companies;
END

-- edit company
CREATE PROCEDURE sp_update_company(
    IN p_company_id BIGINT,
    IN p_name VARCHAR(100)
)
BEGIN
	START TRANSACTION;
	    UPDATE companies
	    SET name = p_name
	    WHERE company_id = p_company_id;
    COMMIT;
END

-- returns if company exists in table
CREATE PROCEDURE sp_check_company_exists(IN p_company_id BIGINT)
BEGIN
    SELECT EXISTS(SELECT 1 FROM companies WHERE company_id = p_company_id);
END
