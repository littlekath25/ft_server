<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'kfu' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'iU_&/EZY%-Ly{W$o<t$A*%nyMoC~d_d:iqo|b G6I5E:]u^A_|k,6|/#SlA>>h%;');
define('SECURE_AUTH_KEY',  'H*y<C+[^x-p)O*rc.@[9O,P6HI>YeSh,RQaf!Sp`!=XkYO=1G=}C;|CJ]?9uBLz+');
define('LOGGED_IN_KEY',    'c8K{ZH|E1_w)-FldM]>ySsPwRF v-(-e=U<WF[4~kT[0%Ly9^PAN8Q}+S;xu8[X2');
define('NONCE_KEY',        'g,`j?PtMQQp-S:*<[t6)20)@HchrsMO1U4y7Bs%u+o+rl`oSgRS(~C@|zk}#nR u');
define('AUTH_SALT',        'sYpd&cDNFO[]}EKOCfEHS`6|PNYBZTx|b6#6v9&2$T3QyG;`fR6()P>T0m1B*~F7');
define('SECURE_AUTH_SALT', 'R2c[>#}QW677yMGR$asPn:Y-OoO03:Oerowf_y4KbNBE([^&0r/PJ+P<ar_^qWcg');
define('LOGGED_IN_SALT',   '{7-JE?i+.gexG$ci%g_C+40+=W_{[RT|?Q#Td`yP7cTNepJOL2/!u5}25yL)S?RG');
define('NONCE_SALT',       '3ef2W3r4:SEnXiznY:{Kfff>_iR`e,KWi@%l4T+?w^u5A8fti|?j149R%-qz|Gc#');

/**#@-*/

/**
 * WordPress Database Table prefix.
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
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
