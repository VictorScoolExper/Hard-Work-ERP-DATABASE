<?php
/*
    Plugin Name: Work Hard ERP
    Description: This is an ERP and CRM focused to aid small business that 
    focus on landscaping, home maintance, etc.
    Version: 0.1.0
    Require at least: 5.9
    Requires PHP: 7.2
    Author: The North Tech Solutions Team
    Author URI: thenorthtechsolutions.com
    Text Domain: hard-work-erp
    Domain Path: /languages
    License: Copyright 2019-2023 wherp.thenorthtechsolutions.com. All rights reserved.
*/

if (!function_exists('add_action')) {
    echo 'Seems like you stumbled here by accident. 😛';
    exit;
}

// Setup
define('HW_ERP_PLUGIN_DIR', plugin_dir_path(__FILE__));
define('HW_ERP_PLUGIN_FILE', __FILE__);

// Includes
$rootFiles = glob(HW_ERP_PLUGIN_DIR . 'includes/*.php');
$subdirectoryFiles = glob(HW_ERP_PLUGIN_DIR . 'includes/**/*.php');
$allFiles = array_merge($rootFiles, $subdirectoryFiles);

foreach ($allFiles as $filename) {
    include_once($filename);
}

// Hooks
add_action('rest_api_init', 'hw_rest_api_init');
