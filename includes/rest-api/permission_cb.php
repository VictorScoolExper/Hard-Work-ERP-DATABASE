<?php

function hw_admin_permission_callback () {
    return current_user_can( 'administrator' );
}