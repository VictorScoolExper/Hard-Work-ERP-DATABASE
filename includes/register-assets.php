<?php

function hw_erp_register_assets(){
 
    $adminAssets = include(HW_ERP_PLUGIN_DIR . 'build/admin/index.asset.php');

    wp_register_script( 
        'hw_erp_admin',
        plugins_url('/build/admin/index.js', HW_ERP_PLUGIN_FILE),
        $adminAssets['dependencies'],
        $adminAssets['version'], 
        true
    );
}