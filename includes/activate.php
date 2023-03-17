<?php

function hw_erp_activate_plugin()
{

  if (version_compare(get_bloginfo('version'), '6.0', '<')) {
    wp_die(
      __('You must updated WordPress to use this plugin', 'hard-work-erp')
    );
  }


  global $wpdb;
  $prefix = $wpdb->prefix;
  $charsetCollate = $wpdb->get_charset_collate();

  $sqlClient = "Create TABLE {$prefix}Clients (
    client_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cell_number VARCHAR(11) NOT NULL,
    life_stage ENUM('Customer', 'Lead', 'Opportunity') DEFAULT 'Customer',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlClientAddress = "Create TABLE {$prefix}Client_Addresses(
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
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlVendor = "Create TABLE {$prefix}vendors(
    vendor_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100),
    company BIGINT NOT NULL,
    cell_number VARCHAR(11) NOT NULL,
    email VARCHAR(255) NOT NULL,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(255),
    country VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlCategoryService = "Create TABLE {$prefix}category_service(
    category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlServices = "Create TABLE {$prefix}services(
    service_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    is_per_hour TINYINT NOT NULL,
    price DECIMAL(15,2) NOT NULL,
    category_id  BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlJobs = "Create TABLE {$prefix}jobs(
    job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    address_id BIGINT NOT NULL,
    schedule_date DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlJobTask = "Create TABLE {$prefix}job_tasks(
    job_task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    job_id BIGINT NOT NULL,
    service_id BIGINT NOT NULL,
    hours_todo INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES hw_erp_jobs(job_id),
    FOREIGN KEY (service_id) REFERENCES hw_erp_services(service_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlCrew = "Create TABLE {$prefix}crews(
    crew_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    crew_name VARCHAR(255) NOT NULL,
    indivdual TINYINT(1) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlSchedules = "Create TABLE {$prefix}schedules(
    schedule_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    shift_begin DATETIME NOT NULL,
    shift_end DATETIME NOT NULL,
    crew_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlEmployees = "Create TABLE {$prefix}employees (
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
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlCrewJobs = "Create TABLE {$prefix}crew_jobs(
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
    FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id),
    FOREIGN KEY (address_id) REFERENCES hw_erp_client_addresses(address_id),
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id),
    FOREIGN KEY (job_id) REFERENCES hw_erp_jobs(job_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlJobReport = "Create TABLE {$prefix}job_reports(
    job_report_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    crew_job_id BIGINT NOT NULL,
    comments TEXT,
    inconveniences TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (crew_job_id) REFERENCES hw_erp_crew_jobs(crew_job_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlBrands = "Create TABLE {$prefix}brands(
    brand_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(200) NOT NULL,
    brand_img VARCHAR(500), 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlEquipmentCategories = "Create TABLE {$prefix}equipment_categories(
    equipment_category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    main_category VARCHAR(200) NOT NULL,
    sub_category VARCHAR(200),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";
  
  $sqlEquipmentStock = "Create TABLE {$prefix}equipment_stock (
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
    FOREIGN KEY (vendor_id) REFERENCES hw_erp_vendor(vendor_id),
    FOREIGN KEY (brand_id) REFERENCES hw_erp_brands(brand_id),
    FOREIGN KEY (equip_category_id) REFERENCES hw_erp_equipment_categories(equipment_category_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlEquipmentUse = "Create TABLE {$prefix}equipment_use_report (
    equip_report_id BIGINT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    employee_id BIGINT NOT NULL,
    equip_id BIGINT NOT NULL,
    taken_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    return_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (employee_id) REFERENCES hw_erp_employees (employee_id),
    FOREIGN KEY (equip_id) REFERENCES hw_erp_equipment_stock (equip_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlFleet = "Create TABLE {$prefix}fleet(
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
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlMainFleet = "Create TABLE {$prefix}maintenance_fleet(
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
    FOREIGN KEY (vehicle_id) REFERENCES hw_erp_fleet(vehicle_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlVehicleEmployee = "Create TABLE {$prefix}vehicle_employee(
    vehicle_crew BIGINT AUTO_INCREMENT PRIMARY KEY,
    vehicle_id BIGINT NOT NULL,
    crew_id BIGINT NOT NULL,
    driver_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (vehicle_id) REFERENCES hw_erp_fleet(vehicle_id),
    FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id),
    FOREIGN KEY (driver_id) REFERENCES hw_erp_employees(employee_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlInvoice = "Create TABLE {$prefix}jinvoices (
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
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlInvoiceSum = "Create TABLE {$prefix}invoice_summary(
    invoice_job_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    invoice_id BIGINT NOT NULL,
    job_id BIGINT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (invoice_id) REFERENCES hw_erp_invoices(invoice_id),
    FOREIGN KEY (job_id) REFERENCES hw_erp_jobs(job_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlEstimates = "Create TABLE {$prefix}estimates (
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
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlTaskEstim = "Create TABLE {$prefix}task_estimate (
    task_est_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    estimate_id BIGINT NOT NULL,
    service_id BIGINT NOT NULL,
    hours INT,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (estimate_id) REFERENCES hw_erp_estimates(estimate_id),
    FOREIGN KEY (service_id) REFERENCES hw_erp_services(service_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlExpenses = "Create TABLE {$prefix}expenses (
    expense_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    tax DECIMAL(10,2) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    notes VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlExpenseReciepts = "Create TABLE {$prefix}expense_reciepts(
    exp_reciept_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    expense_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (expense_id) REFERENCES hw_erp_expenses(expense_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";
  $ExpenseItems = "Create TABLE {$prefix}expense_items(
    item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    expense_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    qty INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (expense_id) REFERENCES hw_erp_expenses(expense_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";
  $sqlEquipmentExpense = "Create TABLE {$prefix}equipment_expenses (
    equip_expense_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    equip_id BIGINT NOT NULL,
    invoice_id BIGINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (equip_id) REFERENCES hw_erp_equipment_stock(equip_id),
    FOREIGN KEY (invoice_id) REFERENCES hw_erp_invoices(invoice_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";
  $sqlProjects = "Create TABLE {$prefix}projects(
    project_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    client_id BIGINT NOT NULL,
    invoice_id BIGINT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id),
    FOREIGN KEY (invoice_id) REFERENCES hw_erp_invoices(invoice_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";
  
  $sqlProjectTask = "Create TABLE {$prefix}project_tasks(
    project_task_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    project_id BIGINT NOT NULL,
    service_id BIGINT NOT NULL,
    hours_approx INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES hw_erp_projects(project_id),
    FOREIGN KEY (service_id) REFERENCES hw_erp_services(service_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";

  $sqlCrewProjects = "Create TABLE {$prefix}crew_projects(
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
    FOREIGN KEY (crew_id) REFERENCES hw_erp_crews(crew_id),
    FOREIGN KEY (address_id) REFERENCES hw_erp_client_addresses(address_id),
    FOREIGN KEY (client_id) REFERENCES hw_erp_clients(client_id),
    FOREIGN KEY (project_id) REFERENCES hw_erp_projects(project_id)
  ) ENGINE='InnoDB' $charsetCollate;
  ";
  
}