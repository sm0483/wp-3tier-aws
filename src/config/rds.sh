#!/bin/bash


cd wordpress
touch wp-config.php
echo "
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/documentation/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '${db_name}' );

/** Database username */
define( 'DB_USER', '${username}' );

/** Database password */
define( 'DB_PASSWORD', '${password}' );

/** Database hostname */
define( 'DB_HOST', '${endpoint}' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'YO7[ecP v?Iedyjlz IdZ0q2`=VYRq%3p%e+A?}u=GaHaTB/$>>Tex#Hp`0]N_GW');
define('SECURE_AUTH_KEY',  '|4b|xdzmhl@-TH]- ]#fFlMUeTs3l%Ikn~VK]y7/,sq<R4Hi&I~-iBej@0.PTz@*');
define('LOGGED_IN_KEY',    '-mh^0j+I.f-D[Q/xSEKV<+d^D N{K|KX_NJ63HJLM,q]C+og<fh)GmiJ]:0Yd|L?');
define('NONCE_KEY',        '<Ai3~Ph9%<5 f~^u;7un>PC>cLwKv%^8_L-Uc09L2S]?t@3CHHwIk+ws|kyj4FvF');
define('AUTH_SALT',        ';t=x9N dWMqo2XmBVt]LPb.1$dg+|a+xrAX*CGK2+0IF6r6T![{D(,a.tVg_/JfA');
define('SECURE_AUTH_SALT', '+Hm/X}8I{X+~O%;y:qu9C nLeVKf3_;_Ya`p-|W`h5^|d39p{C|`Oso]m`4MCyHg');
define('LOGGED_IN_SALT',   '|e-hTQ!H)A|_~ny}2HPbqIb-`/O5SHW:+f#rjI4p6-s2^nG7M>:(1m6#XkGqy9)K');
define('NONCE_SALT',       '{nw~AT[9T>#mDlKEz/o=NSybXp0p@L0~WZm+dhy)`w`}*hU|flTZD}uN4`qn^@XJ');

define('FS_METHOD', 'direct');


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/documentation/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';

" >> wp-config.php

cd /
sudo cp -r wordpress /var/www/html/
sudo systemctl start httpd

