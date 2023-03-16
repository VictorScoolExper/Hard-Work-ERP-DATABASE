<?php

function hw_erp_admin_menus(){

    add_menu_page(
        'Hard Work ERP',
        'Hard Work ERP',
        'manage_options',
        'hw_erp',
        'hw_erp_general_dash',
        'dashicons-businessman',
        3
    );
    
    add_submenu_page(
        'hw_erp',
        'Hard Work Dashboard',
        'Dashboard',
        'manage_options',
        'hw_erp',// do not change line
        'hw_erp_general_dash'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work CRM',
        'CRM',
        'manage_options',
        'hw_erp_crm',
        'hw_erp_crm'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Accounting',
        'Accounting',
        'manage_options',
        'hw_erp_accounting',
        'hw_erp_accounting'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Crew Management',
        'Crews',
        'manage_options',
        'hw_erp_crew_management',
        'hw_erp_crew'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Job Management',
        'Jobs',
        'manage_options',
        'hw_erp_job_management',
        'hw_erp_job'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Fleet Management',
        'Fleet',
        'manage_options',
        'hw_erp_fleet_management',
        'hw_erp_fleet'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Project Management',
        'Projects',
        'manage_options',
        'hw_erp_project_management',
        'hw_erp_project'
    );
    
    add_submenu_page(
        'hw_erp',
        'Hard Work Inventory Management',
        'Inventory',
        'manage_options',
        'hw_erp_inventory_management',
        'hw_erp_inventory'
    );
    // Might be removed but is better to be on the server side
    add_submenu_page(
        'hw_erp',
        'Hard Work Settings',
        'Settings',
        'manage_options',
        'hw_erp_settings',
        'hw_erp_settings_page'
    );
}

function hw_erp_dashboard_page(){
    echo '<div id="general-dashboard-page"></div>';

    wp_enqueue_script('hw_erp_general-dashboard-page', plugin_dir_url(__FILE__) . '../../dist/general_dashboard.js', array(), '1.0.0', true );
}
