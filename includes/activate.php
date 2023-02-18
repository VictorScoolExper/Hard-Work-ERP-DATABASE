<?php

function hw_erp_activate_plugin() {
    // 5.0 < 5.9
    if(version_compare(get_bloginfo('version'), '5.9', '<')) {
      wp_die(
        __('You must updated WordPress to use this plugin', 'udemy-plus')
      );
    }

    
}