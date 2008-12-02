<?php
/**
 * Wikidot - free wiki collaboration software
 * Copyright (c) 2008, Wikidot Inc.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * For more information about licensing visit:
 * http://www.wikidot.org/license
 * 
 * @category Wikidot
 * @package Wikidot_Web
 * @version $Id$
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class GlobalPropertiesException extends Exception {
	
}

/**
 * The Wikidot GlobalProperties class is used to parse
 * the ini file and access any settings and properties
 *
 */
class GlobalProperties {
	
	// main settings
	public static $SERVICE_NAME;
	public static $URL_DOMAIN;
	public static $URL_HOST;
	
	// security settings
	public static $USE_SSL;
	public static $SECRET;
	public static $SECRET_DOMAIN_LOGIN;
	public static $USE_UPLOAD_DOMAIN;
	public static $URL_UPLOAD_DOMAIN;
	public static $RESTRICT_HTML;
	
	// database settings
	public static $DATABASE_SERVER;
	public static $DATABASE_PORT;
	public static $DATABASE_USER;
	public static $DATABASE_PASSWORD;
	public static $DATABASE_NAME;
	
	// mail settings
	public static $DEFAULT_SMTP_HOST;
	public static $DEFAULT_SMTP_PORT;
	public static $DEFAULT_SMTP_USER;
	public static $DEFAULT_SMTP_PASSWORD;
	public static $DEFAULT_SMTP_SECURE;
	public static $DEFAULT_SMTP_AUTH;
	public static $DEFAULT_SMTP_HOSTNAME;
	public static $DEFAULT_SMTP_FROM_EMAIL;
	public static $DEFAULT_SMTP_FROM_NAME;
	public static $DEFAULT_SMTP_REPLY_TO;
	public static $DEFAULT_SMTP_SENDER;
	public static $SUPPORT_EMAIL;
	
	// memcache settings
	public static $USE_MEMCACHE;
	public static $MEMCACHE_HOST;
	public static $MEMCACHE_PORT;
	
	// session settings
	public static $SESSION_TIMEOUT;
	public static $SESSION_COOKIE_NAME;
	public static $SESSION_COOKIE_SECURE;
	public static $SESSION_COOKIE_NAME_IE;
	
	// ui settings
	public static $UI_SLEEP;
	public static $DEFAULT_LANGUAGE;
	
	// log settings
	public static $LOGGER_LEVEL;
	public static $LOGGER_FILE;
	
	// other settings
	public static $URL_DOCS;
	public static $IP_HOST;
	public static $USE_CUSTOM_DOMAINS;
	public static $MODULES_JS_PATH;
	public static $MODULES_JS_URL;
	public static $MODULES_CSS_PATH;
	public static $MODULES_CSS_URL;
	public static $XSENDFILE_USE;
	public static $XSENDFILE_HEADER;
	
	// non-configurable properties
	public static $DATABASE_TYPE;
	public static $DATABASE_USE_PERSISTENT_CONNECTIONS;
	public static $SESSION_COOKIE_DOMAIN;
	public static $DEFAULT_SKIN;
	public static $URL_HOST_PREG;
	public static $URL_DOMAIN_PREG;
	public static $URL_UPLOAD_DOMAIN_PREG;
	
	/**
	 * array with ini options processesed
	 *
	 * @var array
	 */
	protected static $iniConfig;
	
	/**
	 * get a configuration option from ini file
	 * return a default one if none found
	 * throw an exception if there is none found and no default supplied
	 *
	 * @param string $section
	 * @param string $key
	 * @param string $default
	 * @return string
	 */
	protected static function fromIni($section, $key, $default = null) {
		if (isset(self::$iniConfig[$section]) && isset(self::$iniConfig[$section][$key])) {
			$value = self::$iniConfig[$section][$key];
		} else {
			if ($default === null) {
				throw new GlobalPropertiesException("You should set '$key' value in '$section' section in wikidot.ini file.");
			} else {
				$value = $default;
			}
		}
		return $value;
	}
	
	/**
	 * read wikidot.ini file
	 * set some default values
	 * calculate other values 
	 */
	public static function init() {
		
		self::$iniConfig = parse_ini_file(WIKIDOT_ROOT . "/conf/wikidot.ini", true);
		
		// main settings
		self::$SERVICE_NAME				= self::fromIni("main",		"service");			// no default!
		self::$URL_DOMAIN				= self::fromIni("main",		"domain");			// no default!
		self::$URL_HOST					= self::fromIni("main",		"main_wiki",		"www." . self::$URL_DOMAIN);
		
		// security settings
		self::$SECRET					= self::fromIni("security",	"secret");					// no default!
		self::$USE_SSL					= self::fromIni("security",	"ssl",						false);
		self::$SECRET_DOMAIN_LOGIN		= self::fromIni("security",	"secret_login",				self::$SECRET . "_custom_domain_login");
		self::$USE_UPLOAD_DOMAIN		= self::fromIni("security",	"upload_separate_domain",	false);
		self::$URL_UPLOAD_DOMAIN		= self::fromIni("security",	"upload_domain",			"wd.files." . self::$URL_DOMAIN);
		self::$RESTRICT_HTML			= self::fromIni("security",	"upload_restrict_html",		true);
		
		// database settings
		self::$DATABASE_USER			= self::fromIni("db",		"user");			// no default!
		self::$DATABASE_PASSWORD		= self::fromIni("db",		"password");		// no default!
		self::$DATABASE_NAME			= self::fromIni("db",		"database");		// no default!
		self::$DATABASE_SERVER			= self::fromIni("db",		"host",				"127.0.0.1");
		self::$DATABASE_PORT			= self::fromIni("db",		"port",				"5432");
		
		// mail settings
		self::$DEFAULT_SMTP_HOST		= self::fromIni("mail",		"host",				"127.0.0.1");
		self::$DEFAULT_SMTP_PORT		= self::fromIni("mail",		"port",				25);
		self::$DEFAULT_SMTP_USER		= self::fromIni("mail",		"user",				null);
		self::$DEFAULT_SMTP_PASSWORD	= self::fromIni("mail",		"password",			null);
		self::$DEFAULT_SMTP_SECURE		= self::fromIni("mail",		"ssl",				false) ? "ssl" : "";
		self::$DEFAULT_SMTP_AUTH		= self::fromIni("mail",		"auth",				false);
		self::$DEFAULT_SMTP_HOSTNAME	= self::fromIni("mail",		"hostname",			self::$DEFAULT_SMTP_HOST);
		self::$DEFAULT_SMTP_FROM_EMAIL	= self::fromIni("mail",		"from_mail",		(strstr(self::$DATABASE_USER, "@")) ? self::$DATABASE_USER : self::$DATABASE_USER . "@" . self::$DEFAULT_SMTP_HOSTNAME);
		self::$DEFAULT_SMTP_FROM_NAME	= self::fromIni("mail",		"from_name",		self::$SERVICE_NAME . " Mailer");
		self::$DEFAULT_SMTP_REPLY_TO	= self::fromIni("mail",		"reply_to",			"no-reply@" . self::$DEFAULT_SMTP_HOSTNAME);
		self::$DEFAULT_SMTP_SENDER		= self::fromIni("mail",		"sender",			self::$DEFAULT_SMTP_FROM_EMAIL);
		self::$SUPPORT_EMAIL			= self::fromIni("mail",		"support",			self::$DEFAULT_SMTP_FROM_EMAIL);
		
		// memcache settings
		self::$USE_MEMCACHE				= self::fromIni("memcached","enable",			false);
		self::$MEMCACHE_HOST			= self::fromIni("memcached","host",				"127.0.0.1");
		self::$MEMCACHE_PORT			= self::fromIni("memcached","port",				11211);
		
		// session settings
		self::$SESSION_TIMEOUT 			= self::fromIni("session",	"timeout",			3600);
		self::$SESSION_COOKIE_NAME		= self::fromIni("session",	"cookie_name", 		"WIKIDOT_SESSION_ID");
		self::$SESSION_COOKIE_SECURE	= self::fromIni("session",	"cookie_ssl",		false);
		self::$SESSION_COOKIE_NAME_IE	= self::fromIni("session",	"ie_cookie_name",	self::$SESSION_COOKIE_NAME . "_IE");
		
		// ui settings
		self::$UI_SLEEP 				= self::fromIni("ui",		"sleep",			true);
		self::$DEFAULT_LANGUAGE			= self::fromIni("ui",		"language",			"en");
		
		// log settings
		self::$LOGGER_LEVEL				= self::fromIni("log",		"level",			"fatal");
		self::$LOGGER_FILE				= self::fromIni("log",		"file",				"wikidot.log"); // TODO: use this setting
		
		// other settings
		self::$URL_DOCS					= self::fromIni("misc",		"doc_url",			"http://www.wikidot.org/doc");
		self::$IP_HOST					= self::fromIni("misc",		"ip",				"127.0.0.1");
		self::$USE_CUSTOM_DOMAINS		= self::fromIni("misc",		"custom_domains",	false);
		self::$MODULES_JS_PATH			= self::fromIni("misc",		"modules_js_path",	"web/files--common/modules/js");
		self::$MODULES_JS_URL			= self::fromIni("misc",		"modules_js_url",	"/common--modules/js");
		self::$MODULES_CSS_PATH			= self::fromIni("misc",		"modules_css_path",	"web/files--common/modules/css");
		self::$MODULES_CSS_URL			= self::fromIni("misc",		"modules_css_url",	"/common--modules/css");
		self::$XSENDFILE_USE			= self::fromIni("misc",		"xsendfile",		false);
		self::$XSENDFILE_HEADER			= self::fromIni("misc",		"xsendfile_header",	"X-LIGHTTPD-send-file");
		
		// non-configurable properties
		self::$DATABASE_TYPE			= "pgsql";
		self::$DATABASE_USE_PERSISTENT_CONNECTIONS = false;
		self::$SESSION_COOKIE_DOMAIN	= "." . self::$URL_DOMAIN;
		self::$DEFAULT_SKIN				= "default";
		self::$URL_HOST_PREG			= preg_quote(self::$URL_HOST);
		self::$URL_DOMAIN_PREG			= preg_quote(self::$URL_DOMAIN);
		self::$URL_UPLOAD_DOMAIN_PREG	= preg_quote(self::$URL_UPLOAD_DOMAIN);
	}
}

GlobalProperties::init();