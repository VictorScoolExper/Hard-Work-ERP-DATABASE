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
        'Crews',
        'manage_options',
        'hw_erp_crew_management',
        'hw_erp_crew_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Job Management',
        'Jobs',
        'manage_options',
        'hw_erp_job_management',
        'hw_erp_job_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Fleet Management',
        'Fleet',
        'manage_options',
        'hw_erp_fleet_management',
        'hw_erp_fleet_page'
    );

    add_submenu_page(
        'hw_erp',
        'Hard Work Project Management',
        'Projects',
        'manage_options',
        'hw_erp_project_management',
        'hw_erp_project_page'
    );
    
    add_submenu_page(
        'hw_erp',
        'Hard Work Inventory Management',
        'Inventory',
        'manage_options',
        'hw_erp_inventory_management',
        'hw_erp_inventory_page'
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

function hw_erp_crm_page(){
    echo'<div id="crm-page"></div>';

    wp_enqueue_script('hw_erp_crm-page', plugin_dir_url(__FILE__) . '../../dist/crm.js', array(), '1.0.0', true );
}

function hw_erp_accounting_page() {
    echo '<div id="accounting-page"></div>';
  
    wp_enqueue_script('hw_erp_accounting-page', plugin_dir_url(__FILE__) . '../../dist/accounting.js', array(), '1.0.0', true);
    //wp_enqueue_style('my-plugin', plugin_dir_url(__FILE__) . 'dist/index.css', array(), '1.0.0');
}

function hw_erp_crew_page(){
    echo '<div id="crew-page"></div>';

    wp_enqueue_script('hw_erp_crew_page', plugin_dir_url(__FILE__) . '../../dist/crew.js', array(), '1.0.0', true);
}

function hw_erp_job_page(){
    echo '<div id="job-page"></div>';

    wp_enqueue_script('hw_erp_job_page', plugin_dir_url(__FILE__) . '../../dist/job.js', array(), '1.0.0', true);
}

function hw_erp_fleet_page(){
    echo '<div id="fleet-page"></div>';

    wp_enqueue_script('hw_erp_fleet_page', plugin_dir_url(__FILE__) . '../../dist/fleet.js', array(), '1.0.0', true);
}

function hw_erp_project_page(){
    echo '<div id="project-page"></div>';

    wp_enqueue_script('hw_erp_project_page', plugin_dir_url(__FILE__) . '../../dist/project.js', array(), '1.0.0', true);
}

function hw_erp_inventory_page(){
    echo '<div id="inventory-page"></div>';

    wp_enqueue_script('hw_erp_inventory_page', plugin_dir_url(__FILE__) . '../../dist/inventory.js', array(), '1.0.0', true);
}

