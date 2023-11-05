CREATE TABLE role (
    role_id int AUTO_INCREMENT,
    name varchar(100) NOT NULL UNIQUE,
    description text NOT NULL,
    created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (role_id)
);

CREATE TABLE job_title (
    job_title_id int AUTO_INCREMENT,
    name varchar(100) NOT NULL UNIQUE,
    description text NOT NULL,
    created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (job_title_id)
);

CREATE TABLE department (
    department_id int AUTO_INCREMENT,
    name varchar(100) NOT NULL UNIQUE,
    description text NOT NULL,
    created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (department_id)
);