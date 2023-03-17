<?php

function hw_rest_api_signin_handler(WP_REST_Request $request)
{
  $username = $request->get_param('username');
  $password = $request->get_param('password');

  // Check if the required parameters are present
  if (empty($username) || empty($password)) {
    return new WP_Error('signin_error', 'Please provide a username and password.');
  }

  $user = wp_authenticate($username, $password);

  if (is_wp_error($user)) {
    //return $user;
    return new WP_Error('signin_error', 'Please provide a username and password.');
  }

  // Generate a cookie, this is also the same function as wp_set_auth_cookies
  // $expiration = time() + apply_filters('auth_cookie_expiration', 1209600, $user->ID, false);
  // $cookie = wp_generate_auth_cookie($user->ID, $expiration, 'logged_in');
  wp_set_current_user( $user->ID );
  wp_set_auth_cookie($user -> ID, true);

  // Return the cookie
  return array(
    'success' => true,
    'message' => 'You have successfully signed in!',
  );
}