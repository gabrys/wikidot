<?php

chdir(dirname(__FILE__));
require_once('../php/setup.php');

// map errors to exceptions
function errorHandler($errno, $errstr, $errfile, $errline) {
	if (error_reporting()) {
		throw new Exception($errstr); // internal error not to be mapped to fault
	}
	return true;
}
error_reporting(E_ALL & ~E_NOTICE);
set_error_handler('errorHandler', E_ALL & ~E_NOTICE);

// authorize user
if (isset($_GET['key'])) {
	$key = $_GET['key'];
} else {
	$key = "";
}

$m = array();
$user = null;
$md5_hash = null;

if (preg_match('|^([^:]+):([0-9a-f]{32})$|', $key, $m)) {
	$user_name = $m[1];
	$md5_hash = $m[2];
	$c = new Criteria();
	$c->add("unix_name", WDStringUtils::toUnixName($user_name));
	$c->add("password", $md5_hash);
	$user = DB_OzoneUserPeer::instance()->selectOne($c);
}

if (! $user) {
	header('HTTP/1.1 401 Unauthorized');
	header('Content-type: text/plain');
	if ($md5_hash) {
		echo "Login failed";
	} else {
		echo "You need to append ?key=<username>:<hash> to the URL, where\n\n";
		echo " * <username> is your user unix_name (John Smith -> john-smith)\n";
		echo " * <hash> is a md5 sum from your password\n\n";
		echo "The URL for this example would be like: http://$_SERVER[HTTP_HOST]/xml-rpc-api.php?key=john-smith:2304d4770a72d09106045fea654c4188";
	}
	exit();
}

// construct facade objects
$server = new Zend_XmlRpc_Server();
$server->setClass(new Wikidot_Facade_Site($user), 'site');
$server->setClass(new Wikidot_Facade_Page($user), 'page');
$server->setClass(new Wikidot_Facade_Forum($user), 'forum');
$server->setClass(new Wikidot_Facade_User($user), 'user');

// map Wikidot_Facade_Exception to XML-RPC faults
Zend_XmlRpc_Server_Fault::attachFaultException('Wikidot_Facade_Exception');
Zend_XmlRpc_Server_Fault::attachFaultException('WDPermissionException');

// run XML-RPC server
header("Content-type: text/xml");
echo $server->handle();
