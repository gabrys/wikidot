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
error_reporting(E_ALL | E_STRICT);
set_error_handler('errorHandler', E_ALL | E_STRICT);

// authorize user
if (! isset($_GET['key'])) {
	header('HTTP/1.1 401 Unauthorized');
	exit();
}

if ($_GET["key"] != "thusaustuesnthao") {
	header('HTTP/1.1 401 Unauthorized');
	exit();
}

$user = DB_OzoneUser::instance()->selectByPrimaryKey("2");

// construct facade objects
$server = new Zend_XmlRpc_Server();
$server->setClass(new Wikidot_Facade_Site($user), 'site');
$server->setClass(new Wikidot_Facade_Page($user), 'page');
$server->setClass(new Wikidot_Facade_Forum($user), 'forum');
$server->setClass(new Wikidot_Facade_User($user), 'user');

// map Wikidot_Facade_Exception to XML-RPC faults
Zend_XmlRpc_Server_Fault::attachFaultException('Wikidot_Facade_Exception');
Zend_XmlRpc_Server_Fault::attachFaultException('WDPermissionManager');

// run XML-RPC server
echo $server->handle();
