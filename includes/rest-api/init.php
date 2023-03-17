<?php

function hw_rest_api_init(){
    register_rest_route('hw/v1', '/signin', [
        'methods' => 'POST',
        'callback' => 'hw_rest_api_signin_handler',
        'permission_callback' => '__return_true'
    ]);

    register_rest_route('hw/v1', '/employee', [
        'methods' => 'POST',
        'callback' => 'hw_rest_api_add_employee_handler',
        'permission_callback' => 'hw_admin_permission_callback'
    ]);
}

