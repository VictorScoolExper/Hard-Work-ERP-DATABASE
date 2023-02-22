<?php

function hw_erp_example_post_type(){

	$labels = array(
		'name'                  => _x( 'Examples', 'Post type general name', 'hard-work-erp' ),
		'singular_name'         => _x( 'Example', 'Post type singular name', 'hard-work-erp' ),
		'menu_name'             => _x( 'Examples  Post Type', 'Admin Menu text', 'hard-work-erp' ),
		'name_admin_bar'        => _x( 'Example', 'Add New on Toolbar', 'hard-work-erp' ),
		'add_new'               => __( 'Add New', 'hard-work-erp' ),
		'add_new_item'          => __( 'Add New Example', 'hard-work-erp' ),
		'new_item'              => __( 'New Example', 'hard-work-erp' ),
		'edit_item'             => __( 'Edit Example', 'hard-work-erp' ),
		'view_item'             => __( 'View Example', 'hard-work-erp' ),
		'all_items'             => __( 'All Examples', 'hard-work-erp' ),
		'search_items'          => __( 'Search Examples', 'hard-work-erp' ),
		'parent_item_colon'     => __( 'Parent Examples:', 'hard-work-erp' ),
		'not_found'             => __( 'No Examples found.', 'hard-work-erp' ),
		'not_found_in_trash'    => __( 'No Examples found in Trash.', 'hard-work-erp' ),
		'featured_image'        => _x( 'Example Cover Image', 'Overrides the “Featured Image” phrase for this post type. Added in 4.3', 'hard-work-erp' ),
		'set_featured_image'    => _x( 'Set cover image', 'Overrides the “Set featured image” phrase for this post type. Added in 4.3', 'hard-work-erp' ),
		'remove_featured_image' => _x( 'Remove cover image', 'Overrides the “Remove featured image” phrase for this post type. Added in 4.3', 'hard-work-erp' ),
		'use_featured_image'    => _x( 'Use as cover image', 'Overrides the “Use as featured image” phrase for this post type. Added in 4.3', 'hard-work-erp' ),
		'archives'              => _x( 'Example archives', 'The post type archive label used in nav menus. Default “Post Archives”. Added in 4.4', 'hard-work-erp' ),
		'insert_into_item'      => _x( 'Insert into Example', 'Overrides the “Insert into post”/”Insert into page” phrase (used when inserting media into a post). Added in 4.4', 'hard-work-erp' ),
		'uploaded_to_this_item' => _x( 'Uploaded to this Example', 'Overrides the “Uploaded to this post”/”Uploaded to this page” phrase (used when viewing media attached to a post). Added in 4.4', 'hard-work-erp' ),
		'filter_items_list'     => _x( 'Filter Examples list', 'Screen reader text for the filter links heading on the post type listing screen. Default “Filter posts list”/”Filter pages list”. Added in 4.4', 'hard-work-erp' ),
		'items_list_navigation' => _x( 'Examples list navigation', 'Screen reader text for the pagination heading on the post type listing screen. Default “Posts list navigation”/”Pages list navigation”. Added in 4.4', 'hard-work-erp' ),
		'items_list'            => _x( 'Examples list', 'Screen reader text for the items list heading on the post type listing screen. Default “Posts list”/”Pages list”. Added in 4.4', 'hard-work-erp' ),
	);

	$args = array(
		'labels'             => $labels, 
		'public'             => true, // if it is public
		'publicly_queryable' => true, // if the public front end can access it
		'show_ui'            => true, // show in admin dash
		'show_in_menu'       => true, // show in admin?
		'query_var'          => true, // ?recipe=pizza
		'rewrite'            => array( 'slug' => 'recipe' ), // /recipe/pizza
		'capability_type'    => 'post', // this is permissions
		'has_archive'        => true, // this action allow users to view older posts
		'hierarchical'       => false, // in this example a recibe has no hierachical
		'menu_position'      => 20, // where it will show in wp admin dash
		'supports'           => array( 'title', 'editor', 'author', 'thumbnail', 'excerpt' ), // features we can enable
        'show_in_rest' => true, // switches to guttenberg
        'description' => __('A custom post types for recipes', 'hard-work-erp'),
        'taxonomies' => ['category', 'post_tag'], // post type will support what in the array
	);

    // 1st arg: name of our post type
    // 2nd arg: array of options 
    register_post_type( 'recipe', $args ); 
    
	
    /**
    * 1st arg: name of taxonomie

    **/
    register_taxonomy( 'cuisine', 'recipe', [
        'label' => __('Cuisine', 'hard-work-erp'),
        'rewrite' => ['slug' => 'cuisine'],
        'show_in_rest' => true //this is the most important, look it up
    ]);
}

