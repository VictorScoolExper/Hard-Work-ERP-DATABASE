<?php

function hw_erp_activate_plugin() {
    
  if(version_compare(get_bloginfo('version'), '6.0', '<')) {
    wp_die(
      __('You must updated WordPress to use this plugin', 'hard-work-erp')
    );
  }

  
}