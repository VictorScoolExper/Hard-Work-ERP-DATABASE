-- create company
CREATE PROCEDURE sp_add_company (IN company_name VARCHAR(255))
BEGIN
  INSERT INTO companies (name) VALUES (company_name);
END

-- get company by company id
CREATE PROCEDURE sp_getCompanyById(IN companyId INT)
BEGIN
  SELECT * FROM companies WHERE company_id = companyId;
END

-- get all companies
CREATE PROCEDURE sp_get_all_companies()
BEGIN
  SELECT * FROM companies;
END

-- edit company
CREATE PROCEDURE sp_update_company(
    IN p_company_id BIGINT,
    IN p_name VARCHAR(100)
)
BEGIN
    UPDATE companies
    SET name = p_name
    WHERE company_id = p_company_id;
END
