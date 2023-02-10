<?php 

function hw_erp_admin_enqueue($hook_suffix){
    if(
        $hook_suffix === "toplevel_page_hwerp-plugins-options"
    ){
        // wp_enqueue_style('hw_erp_admin');
        // wp_enqueue_script('hw_erp_admin');
    };
}