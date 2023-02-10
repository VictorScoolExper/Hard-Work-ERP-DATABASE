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
        'Hard Work Crew Management',
        'Crew Management',
        'manage_options',
        'hw_erp_crew_management',
        'hw_erp_crew_management_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Client Management',
        'Client Management',
        'manage_options',
        'hw_erp_client_management',
        'hw_erp_client_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Job Management',
        'Job Management',
        'manage_options',
        'hw_erp_job_management',
        'hw_erp_job_page'
    );
    
}