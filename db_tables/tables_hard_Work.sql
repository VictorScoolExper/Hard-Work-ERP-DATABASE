CREATE TABLE hh_erp_clients (
  client_id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  company_name VARCHAR(255) DEFAULT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

CREATE TABLE hh_erp_client_addresses (
  address_id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  street VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  state VARCHAR(255) NOT NULL,
  zip_code VARCHAR(255) NOT NULL,
  country VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients (client_id)
);

CREATE TABLE hh_erp_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    driver_license VARCHAR(250) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    crew_assigned INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_assigned) REFERENCES hh_erp_crews(crew_id)
);

CREATE TABLE hh_erp_crews (
  crew_id INT AUTO_INCREMENT PRIMARY KEY,
  crew_name VARCHAR(255) NOT NULL,
  schedule_check_time DATETIME NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
);

CREATE TABLE hh_erp_work_schedule(
    work_id INT AUTO_INCREMENT PRIMARY KEY,
    crew_id INT NOT NULL,
    address_id INT NOT NULL,
    client_id INT NOT NULL,
    work_description TEXT NOT NULL,
    notes TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_id) REFERENCES hh_erp_crews(crew_id)
);

CREATE TABLE hh_erp_list_work_activities(
    work_activity_id INT AUTO_INCREMENT PRIMARY KEY,
    work_id INT NOT NULL,
    description TEXT NOT NULL,
    status ENUM('TO DO', 'IN PROGRESS', 'DONE') NOT NULL DEFAULT 'TO DO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (work_id) REFERENCES hh_erp_work_schedule(work_id)
);

CREATE TABLE hh_erp_equipment_brands(
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(200) NOT NULL,
    brand_img VARCHAR(500), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hh_erp_equipment_categories(
    equipment_category_id INT AUTO_INCREMENT PRIMARY KEY,
    main_category VARCHAR(200),
    sub_category VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hh_erp_equipment_info (
  equipment_id INT AUTO_INCREMENT PRIMARY KEY,
  equipment_name VARCHAR(255) NOT NULL,
  equipment_description TEXT NOT NULL,
  equipment_brand INT NOT NULL,
  equipment_price DECIMAL(10,2)
  equipment_category_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (equipment_brand) REFERENCES hh_erp_equipment_brands(brand_id),
  FOREIGN KEY (equipment_category_id) REFERENCES hh_erp_equipment_categories(equipment_category_id)
);

CREATE TABLE hh_erp_equipment_stock(
    equipment_stock_id INT AUTO_INCREMENT PRIMARY KEY,
    equipment_id INT NOT NULL,
    last_maintenance_date date NOT NULL,
    equipment_status ENUM('AVAILABLE', 'IN_USE', 'MAINTENANCE') NOT NULL DEFAULT 'AVAILABLE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (equipment_id) REFERENCES hh_erp_equipment(equipment_id)
);

CREATE TABLE hh_erp_work_equipment_needed(
    work_equipment_id INT AUTO_INCREMENT PRIMARY KEY,
    work_id INT NOT NULL,
    equipment_stock_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (work_id) REFERENCES hh_erp_work_schedule(work_id),
    FOREIGN KEY (equipment_stock_id) REFERENCES hh_erp_equipment_stock(equipment_stock_id)
);


CREATE TABLE hh_erp_fleets(
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    brand VARCHAR(200) NOT NULL,
    model VARCHAR(200) NOT NULL,
    motor VARCHAR(200) NOT NULL,
    year INT NOT NULL,
    trans_type ENUM('AUTOMATIC', 'MANUAL') NOT NULL,
    license_plate VARCHAR(20) NOT NULL,
    type ENUM('Car', 'Truck', 'Van') NOT NULL,
    status ENUM('Available', 'In Use', 'Maintenance') NOT NULL,
    last_maintenance_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE hh_erp_maintence_fleet(
    maintance_id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    vehicle_id INT NOT NULL,
    mile_count INT NOT NULL,
    description TEXT, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES hh_erp_fleets(vehicle_id)
);

Create TABLE hh_erp_vehicle_crew(
    vehicle_crew INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id INT NOT NULL,
    crew_id INT NOT NULL,
    driver INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES hh_erp_fleets(vehicle_id),
    FOREIGN KEY (crew_id) REFERENCES hh_erp_crews(crew_id),
    FOREIGN KEY (driver_id) REFERENCES hh_erp_employees(employee_id)
);

CREATE TABLE hh_erp_employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    job_title VARCHAR(100) NOT NULL,
    department VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE DEFAULT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    crew_assigned INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_assigned) REFERENCES crew_management(crew_id)
);

CREATE TABLE hh_erp_invoices (
    invoice_id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    date_created DATE NOT NULL,
    date_due DATE NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES hh_erp_clients(client_id)
);

CREATE TABLE hh_erp_estimates (
  estimate_id INT AUTO_INCREMENT PRIMARY KEY,
  client_id INT NOT NULL,
  job_id INT NOT NULL,
  description TEXT NOT NULL,
  estimate_date DATE NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status ENUM('Pending', 'Accepted', 'Declined') NOT NULL,
  notes TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (client_id) REFERENCES clients(client_id),
  FOREIGN KEY (job_id) REFERENCES hh_erp_work_schedule(job_id)
);

CREATE TABLE hh_erp_expenses (
  expense_id INT AUTO_INCREMENT PRIMARY KEY,
  crew_id INT NOT NULL,
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
  FOREIGN KEY (crew_id) REFERENCES hh_erp_crews(crew_id)
);

