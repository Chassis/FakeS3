<?php
/**
 * Fake S3 configuration for S3 Uploads.
 */

$fakes3_scheme = empty($_SERVER['HTTPS']) ? 'http' : 'https';

defined( 'AWS_S3_ENDPOINT' ) or define( 'AWS_S3_ENDPOINT', $fakes3_scheme . '://' . $_SERVER['HTTP_HOST'] . ':' . $_ENV['FAKE_S3_PORT']. '/' );

defined( 'S3_UPLOADS_BUCKET_URL' ) or define( 'S3_UPLOADS_BUCKET_URL', AWS_S3_ENDPOINT . 'chassis' );
defined( 'S3_UPLOADS_BUCKET' ) or define( 'S3_UPLOADS_BUCKET', 'chassis' );

// These can be any non falsy value
defined( 'S3_UPLOADS_KEY' ) or define( 'S3_UPLOADS_KEY', 'missing' );
defined( 'S3_UPLOADS_SECRET' ) or define( 'S3_UPLOADS_SECRET', 'missing' );
defined( 'S3_UPLOADS_REGION' ) or define( 'S3_UPLOADS_REGION', 'eu-west-1' );
