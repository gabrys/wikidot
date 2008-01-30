<?php

/**
 * this file creates configuration files that is needed to run Wikidot
 */

$files = array("/web/.htaccess", "/files/apache.vhost.wikidot.conf", "/files/crontab");

chdir(dirname(__FILE__));
if(!file_exists('../conf/GlobalProperties.php')){
    $r = dirname(dirname(__FILE__));
    echo <<<EOF
File /conf/GlobalProperties.php cannot be found. Please use
the original /conf/GlobalProperties.php.orig to create your 
own configuration.

If you are lazy, simply do (copy and paste to your terminal):

cd $r/conf
cp GlobalProperties.php.orig GlobalProperties.php
nano GlobalProperties.php

make changes, save the file and run this configuration script
again.

EOF;
    exit(0);
}
require("../php/setup.php");

chdir(WIKIDOT_ROOT);

foreach ($files as $file) {
	$src = WIKIDOT_ROOT."$file.orig";
	$dst = WIKIDOT_ROOT.$file;
	echo "Processing $file .";
	$s = file_get_contents($src);
	echo ".";
	$s = sed($s);
	echo ".";
	file_put_contents($dst, $s);
	echo ".\n";
}

// generate RSA key

echo "Generating RSA keys ..\n";
exec('sh bin/generate_keys.sh');

echo "Done!!!\n";

echo <<<EOT

Now please use the following files:

files/apache.vhost.wikidot.conf - append to your Apache configuration,
files/crontab - append to your Crontab configuration

You might also get a Flickr API key from http://flickr.com and
put it to files/flickr-api-key.txt


EOT;


function sed($s) {
	$s = preg_replace('/%{WIKIDOT:WIKIDOT_ROOT}/', WIKIDOT_ROOT, $s);
	$s = preg_replace('/%{WIKIDOT:URL_HOST}/', GlobalProperties::$URL_HOST, $s);
	$s = preg_replace('/%{WIKIDOT:URL_HOST_PREG}/', GlobalProperties::$URL_HOST_PREG, $s);
	$s = preg_replace('/%{WIKIDOT:URL_DOMAIN}/', GlobalProperties::$URL_DOMAIN, $s);
	$s = preg_replace('/%{WIKIDOT:URL_DOMAIN_PREG}/', GlobalProperties::$URL_DOMAIN_PREG, $s);
	$s = preg_replace('/%{WIKIDOT:SUPPORT_EMAIL}/', GlobalProperties::$SUPPORT_EMAIL, $s);
	return $s;
}
