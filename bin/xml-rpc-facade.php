#!/usr/bin/env php
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

// fake classes
class Wikidot_FacadeFake_Site extends Wikidot_Facade_Base {
	public function pages($args) {
		if (! isset($args["performer"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('performer needed');
		}
		if (! isset($args["site"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('site needed');
		}
		return array(
			array(
				"site" => "www",
    			"category" => "_default",
				"name" => "start",
				"full_name" => "start",
				"title_shown" => "Welcome on this page",
				"title" => "Welcome on this page",
				"title_or_unix_name" => "Welcome on this page",
				"tag_string" => "rocks welcome wikidot",
				"tag_array" => array('rocks', 'welcome', 'wikidot'),
				"parent_page" => null,
			),
		);
	}
	public function categories($args) {
		if (! isset($args["performer"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('performer needed');
		}
		if (! isset($args["site"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('site needed');
		}
		return array(
			array("name" => "_default"),
			array("name" => "system"),
			array("name" => "admin"),
			array("name" => "search"),
			array("name" => "nav"),
		);
	}
}

class Wikidot_FacadeFake_User extends Wikidot_Facade_Base {
	public function sites($args) {
		if (! isset($args["performer"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('performer needed');
		}
		if (! isset($args["user"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('user needed');
		}
		return array(
			array("name" => "community", "title" => "Community Portal", "private" => false),
			array("name" => "other-site", "title" => "My notes", "private" => true),
		);
	}
	public function dummy($args) {
		if (! isset($args["performer"])) {
			throw new Wikidot_Facade_Exception_WrongArguments('performer needed');
		}
	}
}

// construct facade objects
$server = new Zend_XmlRpc_Server();
if (!Zend_XmlRpc_Server_Cache::get('/tmp/xmlrpcapi.cache', $server)) {
	$server->setClass(new Wikidot_Facade_User(), 'user');
	$server->setClass(new Wikidot_Facade_Site(), 'site');
	$server->setClass(new Wikidot_Facade_Page(), 'page');
	$server->setClass(new Wikidot_Facade_Forum(), 'forum');
	Zend_XmlRpc_Server_Cache::save('/tmp/xmlrpcapi.cache', $server);
}

// map Wikidot_Facade_Exception to XML-RPC faults
Zend_XmlRpc_Server_Fault::attachFaultException('Wikidot_Facade_Exception');
Zend_XmlRpc_Server_Fault::attachFaultException('WDPermissionException');

// run XML-RPC server
echo $server->handle(new Zend_XmlRpc_Request_Stdin());
