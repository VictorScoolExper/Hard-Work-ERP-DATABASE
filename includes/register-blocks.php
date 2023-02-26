<?php

function hw_erp_register_blocks(){
    $blocks = [
        ['name' => 'recipe-summary', 'options' => [
            'render_callback' => 'hw_erp_recipe_summary_render_cb'
        ]]
    ];
}