-- CRM TABLES, shoudl handle Customer, vendors, etc
CREATE TABLE hw_erp_clients (
  client_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  cell_number VARCHAR(255) NOT NULL,
  life_stage ENUM('Customer', 'Lead', 'Opportunity') NOT NULL DEFAULT 'Customer',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

CREATE TABLE hw_erp_client_addresses (
  address_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  zip_code VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES hw_erp_clients (client_id)
);

CREATE TABLE hw_erp_vendor(
  vendor_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(200) NOT NULL,
  last_name VARCHAR(200),
  company BIGINT NOT NULL,
  cell_number VARCHAR(200) NOT NULL,
  email VARCHAR(200) NOT NULL,
  street VARCHAR(255),
  city VARCHAR(255),
  state VARCHAR(255),
  zip_code VARCHAR(255),
  country VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE hw_erp_category_service(
  category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hw_erp_services (
  service_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  per_hour TINYINT NOT NULL,
  price DECIMAL(15,2) NOT NULL,
  category_id  BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hw_erp_jobs (
  job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT NOT NULL,
  address_id BIGINT NOT NULL,
  schedule_date DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id)
);

CREATE TABLE hw_erp_job_tasks (
  job_task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  job_id BIGINT NOT NULL,
  service_id BIGINT NOT NULL,
  hours_todo INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (job_id) REFERENCES hw_erp_jobs(job_id),
  FOREIGN KEY (service_id) REFERENCES hw_erp_services(service_id)
);

CREATE TABLE hw_erp_crews (
  crew_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  crew_name VARCHAR(255) NOT NULL,
  schedule_check_time DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);


CREATE TABLE hw_erp_employees (
    employee_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cell_number VARCHAR(100) UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    driver_license VARCHAR(250) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    crew_assigned BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_assigned) REFERENCES hw_erp_crews(crew_id)
);

-- this table associates jobs to crews and allows a crew to have multiple jobs a day
--  with the corresponding tasks
CREATE TABLE hw_erp_crew_jobs(
    work_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    crew_id BIGINT NOT NULL,
    address_id BIGINT NOT NULL,
    client_id BIGINT NOT NULL,
    job_id BIGINT NOT NULL,
    work_description TEXT NOT NULL,
    notes TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id),
    FOREIGN KEY (address_id) REFERENCES hw_erp_client_addresses(address_id),
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id),
    FOREIGN KEY (job_id) REFERENCES hw_erp_jobs(job_id)
);

CREATE TABLE hw_erp_list_work_activities(
    work_activity_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    work_id BIGINT NOT NULL,
    description TEXT NOT NULL,
    status ENUM('TO DO', 'IN PROGRESS', 'DONE') NOT NULL DEFAULT 'TO DO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (work_id) REFERENCES hw_erp_work_schedule(work_id)
);

CREATE TABLE hw_erp_equipment_brands(
    brand_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(200) NOT NULL,
    brand_img VARCHAR(500), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hw_erp_equipment_categories(
    equipment_category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    main_category VARCHAR(200),
    sub_category VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hw_erp_equipment_info (
  equipment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  equipment_name VARCHAR(255) NOT NULL,
  equipment_description TEXT NOT NULL,
  equipment_brand BIGINT NOT NULL,
  equipment_price DECIMAL(10,2)
  equipment_category_id BIGINT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (equipment_brand) REFERENCES hw_erp_equipment_brands(brand_id),
  FOREIGN KEY (equipment_category_id) REFERENCES hw_erp_equipment_categories(equipment_category_id)
);

CREATE TABLE hw_erp_equipment_stock(
    equipment_stock_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    equipment_id BIGINT NOT NULL,
    last_maBIGINTenance_date date NOT NULL,
    equipment_status ENUM('AVAILABLE', 'IN_USE', 'MABIGINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (equipment_id) REFERENCES hw_erp_equipment(equipment_id)
);

CREATE TABLE hw_erp_work_equipment_needed(
    work_equipment_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    work_id BIGINT NOT NULL,
    equipment_stock_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (work_id) REFERENCES hw_erp_work_schedule(work_id),
    FOREIGN KEY (equipment_stock_id) REFERENCES hw_erp_equipment_stock(equipment_stock_id)
);


CREATE TABLE hw_erp_fleets(
    vehicle_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(200) NOT NULL,
    model VARCHAR(200) NOT NULL,
    motor VARCHAR(200) NOT NULL,
    year BIGINT NOT NULL,
    trans_type ENUM('AUTOMATIC', 'MANUAL') NOT NULL,
    license_plate VARCHAR(20) NOT NULL,
    type ENUM('Car', 'Truck', 'Van') NOT NULL,
    status ENUM('Available', 'In Use', 'MaBIGINTenance') NOT NULL,
    last_maBIGINTenance_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hw_erp_maintenance_fleet(
    maintenance_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    vehicle_id BIGINT NOT NULL,
    mile_count BIGINT NOT NULL,
    description TEXT, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES hw_erp_fleets(vehicle_id)
);

Create TABLE hw_erp_vehicle_crew(
    vehicle_crew BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id BIGINT NOT NULL,
    crew_id BIGINT NOT NULL,
    driver BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES hw_erp_fleets(vehicle_id),
    FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id),
    FOREIGN KEY (driver_id) REFERENCES hw_erp_employees(employee_id)
);

CREATE TABLE hw_erp_invoices (
    invoice_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    date_created DATE NOT NULL,
    date_due DATE NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id)
);

CREATE TABLE hw_erp_estimates (
  estimate_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  client_id BIGINT NOT NULL,
  job_id BIGINT NOT NULL,
  description TEXT NOT NULL,
  estimate_date DATE NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status ENUM('Pending', 'Accepted', 'Declined') NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (job_id) REFERENCES hw_erp_work_schedule(job_id)
);

CREATE TABLE hw_erp_expenses (
  expense_id BIGINT AUTO_INCREMENT PRIMARY KEY,
  crew_id BIGINT NOT NULL,
  expense_date DATE NOT NULL,
  expense_description VARCHAR(255) NOT NULL,
  type VARCHAR(200) NOT NULL,
  subtotal DECIMAL(10,2) NOT NULL,
  tax DECIMAL(10,2) NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  category VARCHAR(255) NOT NULL,
  notes VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id)
);

