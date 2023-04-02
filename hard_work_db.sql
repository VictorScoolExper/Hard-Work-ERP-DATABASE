CREATE DATABASE hard_work_erp_db;
USE hard_work_erp_db;

CREATE TABLE users(
  user_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  last_name VARCHAR(200) NOT NULL,
  cell_number VARCHAR(20),
  role VARCHAR(20),
  age INT,
  active ENUM("true", "false"),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE auths(
  user_id BIGINT UNIQUE,
  email VARCHAR(200) NOT NULL,
  password VARCHAR(200) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- CRM TABLES, shoudl handle Customer, vendors, etc
CREATE TABLE clients (
  client_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  cell_number VARCHAR(11) NOT NULL,
  life_stage ENUM('customer', 'lead', 'opportunity') DEFAULT 'customer',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE addresses (
  address_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  zip_code VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE client_addresses(
  address_id BIGINT NOT NULL UNIQUE,
  client_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (address_id) REFERENCES addresses(address_id),
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE TABLE companies(
  company_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE vendors(
  vendor_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100),
  company_id BIGINT NOT NULL,
  cell_number VARCHAR(11) NOT NULL,
  email VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

CREATE TABLE vendor_addresses(
  address_id BIGINT NOT NULL UNIQUE,
  vendor_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (address_id) REFERENCES addresses(address_id),
  FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id)
);

DROP TABLE IF EXISTS category_service;
CREATE TABLE category_service(
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS services;
CREATE TABLE services (
  service_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  is_per_hour TINYINT NOT NULL,
  price DECIMAL(15,2) NOT NULL,
  category_id  BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS jobs;
CREATE TABLE jobs (
  job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT NOT NULL,
  address_id BIGINT NOT NULL,
  schedule_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

DROP TABLE IF EXISTS job_tasks;
CREATE TABLE job_tasks (
  job_task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  job_id BIGINT NOT NULL,
  service_id BIGINT NOT NULL,
  hours_todo INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (job_id) REFERENCES jobs(job_id),
  FOREIGN KEY (service_id) REFERENCES services(service_id)
);

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employee_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNIQUE NOT NULL,
    created_by BIGINT NOT NULL,
    edited_by BIGINT NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    driver_license VARCHAR(250) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT NULL,
    wage_per_hour DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (created_by) REFERENCES users(user_id),
    FOREIGN KEY (edited_by) REFERENCES users(user_id),
);

-- Crews can also be individual
CREATE TABLE crews (
  crew_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  crew_name VARCHAR(255) NOT NULL,
  crew_leader BIGINT DEFAULT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (crew_leader) REFERENCES employees(employee_id)
);

CREATE TABLE crews_employees(
	crew_id BIGINT NOT NULL,
	employee_id BIGINT NOT NULL, 
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
	FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE attendances (
  attendance_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  employee_id BIGINT NOT NULL,
  status ENUM('present', 'absent'),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE shifts (
	shift_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  employee_id BIGINT NOT NULL,
  shift_date  DATE NOT NULL,
	start_time TIME NOT NULL,
	end_time TIME NOT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

CREATE TABLE

DROP TABLE IF EXISTS crew_jobs;
-- this table associates jobs to crews and allows a crew to have multiple jobs a day
--  with the corresponding tasks
CREATE TABLE crew_jobs(
    crew_job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    crew_id BIGINT NOT NULL,
    address_id BIGINT NOT NULL,
    client_id BIGINT NOT NULL,
    job_id BIGINT NOT NULL,
    work_description TEXT NOT NULL,
    description TEXT NOT NULL,
    status ENUM('TO DO', 'IN PROGRESS', 'DONE', 'Canceled') DEFAULT 'TO DO',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
    FOREIGN KEY (address_id) REFERENCES client_addresses(address_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

DROP TABLE IF EXISTS job_reports;
CREATE TABLE job_reports(
  job_report_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  crew_job_id BIGINT NOT NULL,
  comments TEXT,
  inconveniences TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (crew_job_id) REFERENCES crew_jobs(crew_job_id)
);

DROP TABLE IF EXISTS brands;
CREATE TABLE brands(
    brand_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(200) NOT NULL,
    brand_img VARCHAR(500), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS equipment_categories;
CREATE TABLE equipment_categories(
    equipment_category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    main_category VARCHAR(200) NOT NULL,
    sub_category VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS equipment_stocks;
CREATE TABLE equipment_stocks (
  equip_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  vendor_id BIGINT NOT NULL,
  brand_id BIGINT NOT NULL,
  equip_category_id BIGINT NOT NULL,
  last_maintenance_date date NOT NULL,
  status ENUM('AVAILABLE', 'IN_USE', 'MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
  total DECIMAL(10,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (vendor_id) REFERENCES vendors(vendor_id),
  FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
  FOREIGN KEY (equip_category_id) REFERENCES equipment_categories(equipment_category_id)
);

DROP TABLE IF EXISTS equipment_use_reports;
CREATE TABLE equipment_use_reports (
    equip_report_id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    employee_id BIGINT NOT NULL,
    equip_id BIGINT NOT NULL,
    taken_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    return_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES employees (employee_id),
    FOREIGN KEY (equip_id) REFERENCES equipment_stocks (equip_id)
);

DROP TABLE IF EXISTS fleet;
CREATE TABLE fleet(
    vehicle_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand_id BIGINT NOT NULL,
    model VARCHAR(200) NOT NULL,
    motor VARCHAR(200) NOT NULL,
    year BIGINT NOT NULL,
    trans_type ENUM('AUTOMATIC', 'MANUAL') NOT NULL,
    vin_number VARCHAR(20) NOT NULL,
    type ENUM('Car', 'Truck', 'Van') NOT NULL,
    status ENUM('Available', 'In Use', 'Maintenance') NOT NULL,
    last_maintenance_date DATE,
    current_miles BIGINT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    taxes DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS maintenance_fleet;
CREATE TABLE maintenance_fleet(
    maintenance_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    vehicle_id BIGINT NOT NULL,
    mile_count BIGINT NOT NULL,
    description TEXT, 
    img_receipt VARCHAR(250) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    taxes DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES fleet(vehicle_id)
);

DROP TABLE IF EXISTS vehicle_crew;
Create TABLE vehicle_crew(
    vehicle_crew BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id BIGINT NOT NULL,
    crew_id BIGINT NOT NULL,
    driver_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES fleet(vehicle_id),
    FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
    FOREIGN KEY (driver_id) REFERENCES employees(employee_id)
);

DROP TABLE IF EXISTS invoices;
CREATE TABLE invoices (
    invoice_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    sent_date DATE NOT NULL,
    due_date DATE NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

DROP TABLE IF EXISTS invoice_summaries;
-- this will require a complex query when creating the total of the invoice since the invoice 
--  can have various jobs in the invoice
CREATE TABLE invoice_summaries(
  invoice_job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  invoice_id BIGINT NOT NULL,
  job_id BIGINT NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
  FOREIGN KEY (job_id) REFERENCES jobs(job_id)
);

DROP TABLE IF EXISTS estimates;
CREATE TABLE estimates (
  estimate_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT NOT NULL,
  estimate_tasks BIGINT NOT NULL,
  description TEXT NOT NULL,
  estimate_date DATE NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  taxes DECIMAL(10,2) NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status ENUM('Pending', 'Accepted', 'Declined') NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

DROP TABLE IF EXISTS task_estimates;
CREATE TABLE task_estimates (
  task_est_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  estimate_id BIGINT NOT NULL,
  service_id BIGINT NOT NULL,
  hours INT,
  total DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (estimate_id) REFERENCES estimates(estimate_id),
  FOREIGN KEY (service_id) REFERENCES services(service_id)
);

DROP TABLE IF EXISTS expenses;
CREATE TABLE expenses (
  expense_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  tax DECIMAL(10,2) NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  notes VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

DROP TABLE IF EXISTS expense_reciepts;
CREATE TABLE expense_reciepts(
  exp_reciept_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  expense_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (expense_id) REFERENCES expenses(expense_id)
);

DROP TABLE IF EXISTS expense_items;
-- this table can be used to reference items for easier future purchase
CREATE TABLE expense_items(
  item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  expense_id BIGINT NOT NULL,
  name VARCHAR(100) NOT NULL,
  qty INT NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (expense_id) REFERENCES expenses(expense_id)
);

DROP TABLE IF EXISTS equipment_expenses;
CREATE TABLE equipment_expenses (
  equip_expense_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  equip_id BIGINT NOT NULL,
  invoice_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (equip_id) REFERENCES equipment_stocks(equip_id),
  FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
);

DROP TABLE IF EXISTS projects;
-- Need to add projects tables
CREATE TABLE projects(
  project_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT NOT NULL,
  invoice_id BIGINT NOT NULL,
  name VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id)
);

DROP TABLE IF EXISTS project_tasks;
CREATE TABLE project_tasks(
  project_task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  project_id BIGINT NOT NULL,
  service_id BIGINT NOT NULL,
  hours_approx INT NOT NULL,
  total DECIMAL(10,2) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (project_id) REFERENCES projects(project_id),
  FOREIGN KEY (service_id) REFERENCES services(service_id)
);

DROP TABLE IF EXISTS crew_projects;
CREATE TABLE crew_projects(
    crew_job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    crew_id BIGINT NOT NULL,
    address_id BIGINT NOT NULL,
    client_id BIGINT NOT NULL,
    project_id BIGINT NOT NULL,
    short_description TEXT NOT NULL,
    description TEXT NOT NULL,
    status ENUM('TO DO', 'IN PROGRESS', 'DONE', 'Canceled') NOT NULL DEFAULT 'TO DO',
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_id) REFERENCES crews(crew_id),
    FOREIGN KEY (address_id) REFERENCES client_addresses(address_id),
    FOREIGN KEY (client_id) REFERENCES clients(client_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

