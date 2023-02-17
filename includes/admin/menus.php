<?php

function hw_erp_admin_menus(){

    add_menu_page(
        'Hard Work ERP',
        'Hard Work ERP',
        'manage_options',
        'hw_erp',
        'hw_erp_dashboard_page',
        'dashicons-businessman',
        3
    );
    
    add_submenu_page(
        'hw_erp',
        'Hard Work Dashboard',
        'Dashboard',
        'manage_options',
        'hw_erp',// do not change line
        'hw_erp_dashboard_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work CRM',
        'CRM',
        'manage_options',
        'hw_erp_crm',
        'hw_erp_crm_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Accounting',
        'Accounting',
        'manage_options',
        'hw_erp_accounting',
        'hw_erp_accounting_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Crew Management',
        'Crew Management',
        'manage_options',
        'hw_erp_crew_management',
        'hw_erp_crew_management_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Job Management',
        'Job Management',
        'manage_options',
        'hw_erp_job_management',
        'hw_erp_job_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Fleet Management',
        'Fleet Management',
        'manage_options',
        'hw_erp_fleet_management',
        'hw_erp_fleet_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Project Management',
        'Project Management',
        'manage_options',
        'hw_erp_project_management',
        'hw_erp_project_page'
    );
    
    add_submenu_page(
        'hw_erp',
        'Hard Work Inventory Management',
        'Inventory Management',
        'manage_options',
        'hw_erp_inventory_management',
        'hw_erp_inventory_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Settings',
        'Settings',
        'manage_options',
        'hw_erp_settings',
        'hw_erp_settings_page'
    );
}