CREATE DATABASE hard_work_erp_db;

USE hard_work_erp_db;

CREATE TABLE
    `users` (
        `user_id` bigint NOT NULL AUTO_INCREMENT,
        `name` varchar(200) NOT NULL,
        `last_name` varchar(200) NOT NULL,
        `cell_number` varchar(20) DEFAULT NULL,
        `role` varchar(20) DEFAULT NULL,
        `birth_date` date DEFAULT NULL,
        `active` enum('true', 'false') DEFAULT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`user_id`)
    );

CREATE TABLE
    `auths` (
        `user_id` bigint DEFAULT NULL,
        `email` varchar(200) NOT NULL,
        `password` varchar(200) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        UNIQUE KEY `user_id` (`user_id`),
        CONSTRAINT `auths_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
    );

CREATE TABLE
    `employees` (
        `employee_id` bigint NOT NULL AUTO_INCREMENT,
        `user_id` bigint NOT NULL,
        `created_by` bigint DEFAULT NULL,
        `edited_by` bigint DEFAULT NULL,
        `job_title` varchar(100) NOT NULL,
        `department` varchar(100) NOT NULL,
        `driver_license` varchar(250) DEFAULT NULL,
        `start_date` date NOT NULL,
        `wage_per_hour` decimal(10, 2) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        `image_name` varchar(255) DEFAULT NULL,
        `email` varchar(255) NOT NULL,
        PRIMARY KEY (`employee_id`),
        UNIQUE KEY `user_id` (`user_id`),
        KEY `created_by` (`created_by`),
        KEY `edited_by` (`edited_by`),
        CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
    );

-- TODO: delete if neccesary

CREATE TABLE
    `shifts` (
        `shift_id` bigint NOT NULL AUTO_INCREMENT,
        `employee_id` bigint NOT NULL,
        `shift_date` date NOT NULL,
        `start_time` time NOT NULL,
        `end_time` time NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`shift_id`),
        KEY `employee_id` (`employee_id`),
        CONSTRAINT `shifts_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE
    );

-- TODO: delete if neccesary

CREATE TABLE
    `attendances` (
        `attendance_id` bigint NOT NULL AUTO_INCREMENT,
        `employee_id` bigint NOT NULL,
        `status` enum('present', 'absent') DEFAULT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`attendance_id`),
        KEY `employee_id` (`employee_id`),
        CONSTRAINT `attendances_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE
    );

CREATE TABLE
    `crews` (
        `crew_id` bigint NOT NULL AUTO_INCREMENT,
        `crew_name` varchar(255) NOT NULL,
        `crew_leader` bigint DEFAULT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`crew_id`),
        KEY `crew_leader` (`crew_leader`),
        CONSTRAINT `crews_ibfk_1` FOREIGN KEY (`crew_leader`) REFERENCES `employees` (`employee_id`) ON DELETE
        SET NULL
    )
CREATE TABLE
    `crews_employees` (
        `crew_id` bigint NOT NULL,
        `employee_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        KEY `crew_id` (`crew_id`),
        KEY `employee_id` (`employee_id`),
        CONSTRAINT `crews_employees_ibfk_1` FOREIGN KEY (`crew_id`) REFERENCES `crews` (`crew_id`) ON DELETE CASCADE,
        CONSTRAINT `crews_employees_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`) ON DELETE CASCADE
    ) -- ADD MR or MRS column
CREATE TABLE
    `clients` (
        `client_id` bigint NOT NULL AUTO_INCREMENT,
        `name` varchar(100) NOT NULL,
        `last_name` varchar(100) NOT NULL,
        `email` varchar(255) NOT NULL,
        `cell_number` varchar(20) NOT NULL,
        `life_stage` enum(
            'customer',
            'lead',
            'opportunity'
        ) DEFAULT 'customer',
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`client_id`)
    )
CREATE TABLE
    `addresses` (
        `address_id` bigint NOT NULL AUTO_INCREMENT,
        `street` varchar(255) NOT NULL,
        `city` varchar(255) NOT NULL,
        `state` varchar(255) NOT NULL,
        `zip_code` varchar(255) NOT NULL,
        `country` varchar(255) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`address_id`)
    )
CREATE TABLE
    `client_addresses` (
        `address_id` bigint NOT NULL,
        `client_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        UNIQUE KEY `address_id` (`address_id`),
        KEY `client_id` (`client_id`),
        CONSTRAINT `client_addresses_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE,
        CONSTRAINT `client_addresses_ibfk_2` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`) ON DELETE CASCADE
    );

CREATE TABLE
    `companies` (
        `company_id` bigint NOT NULL AUTO_INCREMENT,
        `name` varchar(100) NOT NULL,
        `service_type` varchar(100) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`company_id`)
    )
CREATE TABLE
    `vendors` (
        `vendor_id` bigint NOT NULL AUTO_INCREMENT,
        `name` varchar(100) NOT NULL,
        `last_name` varchar(100) DEFAULT NULL,
        `company_id` bigint NOT NULL,
        `cell_number` varchar(20) NOT NULL,
        `email` varchar(255) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`vendor_id`),
        KEY `company_id` (`company_id`),
        CONSTRAINT `vendors_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`company_id`) ON DELETE CASCADE
    );

CREATE TABLE
    `vendor_addresses` (
        `address_id` bigint NOT NULL,
        -- TODO change vendor_id to unique so that only one address can be associated with one vendor
        `vendor_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        KEY `address_id` (`address_id`),
        KEY `vendor_id` (`vendor_id`),
        CONSTRAINT `vendor_addresses_ibfk_1` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE,
        CONSTRAINT `vendor_addresses_ibfk_2` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`vendor_id`) ON DELETE CASCADE
    )
CREATE TABLE
    `services` (
        `service_id` bigint NOT NULL AUTO_INCREMENT,
        `service_name` varchar(100) NOT NULL,
        `description` NOT NULL,
        `is_per_hour` VARCHAR(5) NOT NULL,
        `price` decimal(10, 2) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`service_id`) -- TODO: add delete cascade
    )
CREATE TABLE
    `materials` (
        `material_id` bigint NOT NULL AUTO_INCREMENT,
        `material_name` varchar(100) NOT NULL,
        `description` varchar(255) DEFAULT NULL,
        `unit` enum('yard', 'ton', 'piece') NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`material_id`)
    );

-- This is used for associating multiple services with a project

CREATE TABLE
    `service_schedule`(
        `service_schedule_id` bigint AUTO_INCREMENT NOT NULL,
        `client_id` bigint NOT NULL,
        `address_id` bigint NOT NULL,
        `start_time` TIME NOT NULL,
        `end_time` TIME NOT NULL,
        `to_do_date` date NOT NULL,
        `type` enum('single', 'routine') NOT NULL,
        `status` enum(
            'pending',
            'in-progress',
            'done',
            'canceled'
        ) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`service_schedule_id`),
        KEY `client_id`(`client_id`),
        KEY `address_id`(`address_id`),
        CONSTRAINT `service_schedule_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`),
        CONSTRAINT `service_schedule_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`)
    );

CREATE TABLE
    `scheduled_service_services`(
        `scheduled_service_task_id` bigint AUTO_INCREMENT NOT NULL,
        `service_schedule_id` bigint NOT NULL,
        `service_id` bigint NOT NULL,
        `quantity` INT NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`scheduled_service_task_id`),
        KEY `service_schedule_id` (`service_schedule_id`),
        KEY `service_id` (`service_id`),
        CONSTRAINT `scheduled_service_task_ibfk_1` FOREIGN KEY (`service_schedule_id`) REFERENCES `service_schedule` (`service_schedule_id`),
        CONSTRAINT `scheduled_service_task_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
    );

CREATE TABLE
    `employees_at_service_scheduled` (
        `emp_at_service_id` bigint NOT NULL AUTO_INCREMENT,
        `service_schedule_id` bigint NOT NULL,
        `employee_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`emp_at_service_id`),
        KEY `service_schedule_id` (`service_schedule_id`),
        KEY `employee_id` (`employee_id`),
        CONSTRAINT `employees_at_service_scheduled_ibfk_1` FOREIGN KEY (`service_schedule_id`) REFERENCES `service_schedule` (`service_schedule_id`),
        CONSTRAINT `employees_at_service_scheduled_ibfk_2` FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`)
    );

CREATE TABLE
    `scheduled_service_materials`(
        `scheduled_service_material_id` bigint AUTO_INCREMENT NOT NULL,
        `service_schedule_id` bigint NOT NULL,
        `material_id` bigint NOT NULL,
        `quantity` INT NOT NULL,
        `subtotal` decimal(10, 2) NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (
            `scheduled_service_material_id`
        ),
        KEY `service_schedule_id` (`service_schedule_id`),
        KEY `material_id` (`material_id`),
        CONSTRAINT `scheduled_service_materials_ibfk_1` FOREIGN KEY (`service_schedule_id`) REFERENCES `service_schedule` (`service_schedule_id`),
        CONSTRAINT `scheduled_service_materials_ibfk_2` FOREIGN KEY (`material_id`) REFERENCES `materials` (`material_id`)
    );

-- Routine schedule tables
CREATE TABLE `routine_schedules`(
    `routine_schedule_id` bigint AUTO_INCREMENT NOT NULL,
    `days_until_repeat` bigint NOT NULL,
    `months_programmed` bigint NOT NULL,
    `description` TEXT,
    `title` varchar(50) NOT NULL,
    `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`routine_schedule_id`)
);

CREATE TABLE
    `routine_scheduled_services`(
        `routine_schedule_id` bigint NOT NULL,
        `service_schedule_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        UNIQUE KEY `service_schedule_id` (`service_schedule_id`),
        CONSTRAINT `routine_scheduled_services_ibfk_1` FOREIGN KEY (`routine_schedule_id`) REFERENCES `routine_schedules` (`routine_schedule_id`),
        CONSTRAINT `routine_scheduled_services_ibfk_2` FOREIGN KEY (`service_schedule_id`) REFERENCES `service_schedule` (`service_schedule_id`)
    );

-- TODO: add a location registery when the leader registered job finished

-- remember that project must be scheduled a little bit different from rutine schedule

CREATE TABLE
    `projects` (
        `project_id` bigint AUTO_INCREMENT NOT NULL,
        `name` VARCHAR(100) NOT NULL,
        `description` TEXT NOT NULL,
        `client_id` bigint NOT NULL,
        `billing_method` enum(
            'fixed',
            'per_hour',
            'per_service'
        ) NOT NULL,
        `status` enum(
            'pending',
            'in-progress',
            'done',
            'canceled'
        ) NOT NULL,
        `start_day` date NOT NULL,
        `finish_day` date NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`project_id`),
        CONSTRAINT `projects_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`)
    );

CREATE TABLE
    `project_services` (
        `service_id` bigint NOT NULL,
        `project_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT `project_services_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`),
        CONSTRAINT `project_services_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `projects` (`project_id`)
    );

CREATE TABLE
    `service_receipts`(
        `receipt_id` bigint NOT NULL,
        `bucket_file_name` VARCHAR(255),
        `service_schedule_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT `service_receipts_ibfk_1` FOREIGN KEY (`service_schedule_id`) REFERENCES `service_schedule` (`service_schedule_id`)
    );

-- Time Tracking Employee

CREATE TABLE
    `employee_time_tracking` (
        `employee_id` bigint NOT NULL,
        `total_minutes` INT NOT NULL,
        `lunch_minutes` INT NOT NULL,
        `day` date NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    );

-- app settings table

-- Need to add foreign key constraints

CREATE TABLE
    `app_settings`(
        `setting_id` bigint NOT NULL AUTO_INCREMENT,
        `setting_name` VARCHAR(100) NOT NULL UNIQUE,
        `setting_value` VARCHAR(100) NOT NULL,
        `type_value` enum('percent', 'number', 'string'),
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`setting_id`)
    );

-- Invoice related tables

CREATE TABLE
    `invoices`(
        `invoice_id` bigint NOT NULL AUTO_INCREMENT,
        `client_id` bigint NOT NULL,
        `invoice_date` date NOT NULL,
        `due_date` date NOT NULL,
        `invoice_subject` text NOT NULL,
        `sub_total` decimal(10, 2) NOT NULL,
        `sale_tax` decimal(10, 2) NOT NULL,
        `total` decimal(10, 2) NOT NULL,
        `is_paid` TINYINT NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`invoice_id`),
        CONSTRAINT `client_id_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`client_id`)
    );

CREATE TABLE
    `invoice_discount`(
        `invoice_id` bigint NOT NULL,
        `discount_num` decimal NOT NULL,
        `type` enum('percent', 'number') NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT `invoice_id_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`)
    ) -- this table assoicated services already done with invoices
CREATE TABLE
    `invoice_services`(
        `invoice_id` bigint NOT NULL,
        `service_id` bigint NOT NULL,
        `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
        `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        CONSTRAINT `invoice_id_ibfk_1` FOREIGN KEY (`invoice_id`) REFERENCES `invoices` (`invoice_id`),
        CONSTRAINT `service_id_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `services` (`service_id`)
    );

-- TODO: CHART OF ACCOUNTS TABLE