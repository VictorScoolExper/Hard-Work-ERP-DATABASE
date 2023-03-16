<?php

function hw_rest_api_signin_handler(WP_REST_Request $request) {
  $username = $request->get_param('username');
  $password = $request->get_param('password');

  // Check if the required parameters are present
  if ( empty( $username ) || empty( $password ) ) {
    return new WP_Error( 'signin_error', 'Please provide a username and password.' );
  }

  // Check if the user's credentials are correct
  if (wp_authenticate($username, $password)) {
    // If the credentials are correct, create a new session
    wp_set_current_user(get_user_by('login', $username)->ID);
    wp_set_auth_cookie(get_current_user_id());

    // Return a response to the client
    return new WP_REST_Response(array(
      'success' => true,
    ), 200);
  } else {
    // If the credentials are incorrect, return an error response
    return new WP_Error('invalid_credentials', 'Invalid credentials', array(
      'status' => 401,
    ));
  }
}