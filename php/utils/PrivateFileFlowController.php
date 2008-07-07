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
 * @package Wikidot
 * @version $Id$
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class PrivateFileFlowController extends WebFlowController {

	protected function isUploadDomain($siteHost) {
		
		if (preg_match("/^[^.]*\." . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . "$/", $siteHost)) {
			return true;
		}
		
		return false;
		
	}
	
	protected function siteNotExists() {
		$this->serveFile(WIKIDOT_ROOT."/files/site_not_exists.html", "text/html");
	}
	
	protected function fileNotExists() {
		$this->serveFile(WIKIDOT_ROOT."/files/file_not_exists.html", "text/html");
	}
	
	protected function forbidden() {
		header("HTTP/1.0 401 Unauthorized");
		header("Content-type: text/html; charset=utf-8");
		echo "Not authorized. This is a private site with access restricted to its members.";
	}
	
	/**
	 * Redirects browser to certain URL build from site name, domain and file name
	 *
	 * @param DB_Site $site site to get name from
	 * @param string $domain domain to use
	 * @param string $file file to redirect to
	 * @param string $key optional key to set
	 */
	protected function redirect($site, $domain, $file, $key = null) {
		
		$proto = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 'https' : 'http';
		$host = $site->getUnixName() . "." . $domain;
		
		$url = "${proto}://${host}/local--${file}";
		
		if ($key) {
			$url .= "?ukey=" . urlencode($key);
		}
		
		header('HTTP/1.1 301 Moved Permanently');
		header("Location: $url");
		
	}
	
	protected function getSite($siteHost) {
		
		$memcache = Ozone::$memcache;
		
		$regexp = "/^([a-zA-Z0-9\-]+)\.(" . GlobalProperties::$URL_DOMAIN_PREG . "|" . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . ")$/";
		if (preg_match($regexp, $siteHost, $matches) == 1) {
			// select site based on the unix name
			
			$siteUnixName=$matches[1];
			$mcKey = 'site..'.$siteUnixName;
			$site = $memcache->get($mcKey); 
			if($site == false){
				$c = new Criteria();
				$c->add("unix_name", $siteUnixName);
				$c->add("site.deleted", false);
				$site = DB_SitePeer::instance()->selectOne($c);
				if($site) {$memcache->set($mcKey, $site, 0, 3600);}	
			}
		} else {
			// select site based on the custom domain
			
			$mcKey = 'site_cd..'.$siteHost;
			$site = $memcache->get($mcKey);
			if($site == false){	
				$c = new Criteria();
				$c->add("custom_domain", $siteHost);
				$c->add("site.deleted", false);
				$site = DB_SitePeer::instance()->selectOne($c);
				if ($site) {
					$memcache->set($mcKey, $site, 0, 3600);
				}	
			}
			GlobalProperties::$SESSION_COOKIE_DOMAIN = '.'.$siteHost;		
		}
		
		return $site;
	}
	
	/**
	 * checks whether file is from a public area (public wiki or non-restricted directory)
	 *
	 * @param DB_Site $site
	 * @param string $file
	 * @return boolean
	 */
	protected function publicArea($site, $file) {
		if (! $site) {
			return false;
		}
		
		if (! $site->getPrivate()) { // site is public
			return true;
		}
		
		$dir = array_shift(explode("/", $file));
		if ($dir != "resized-images" && $dir != "files") {
			return true;
		}
		
		return false;
	}
	
	protected function member($user, $site) {
		if (! $site || ! $user) {
			return false;
		}
		
		$c = new Criteria();
		$c->add("site_id", $site->getSiteId());
		$c->add("user_id", $user->getUserId());
		
		if (DB_MemberPeer::instance()->selectOne($c)) { // user is a member of the wiki
			return true;
		}
		
		return false;
	}
	
	protected function userAllowed($user, $site, $file) {
	
		if ($this->publicArea($site, $file)) {
			return true;
		}
		
		if (! $user) {
			return false;
		}
		
		if ($user->getSuperAdmin() || $user->getSuperModerator() || $this->member($user, $site)) {
			return true;
		}
		
		return false;
	}
	
	protected function fileMime($path, $allowHtml = false) {
		
		if (file_exists($path)) {
			
			$finfo = finfo_open(FILEINFO_MIME, WIKIDOT_ROOT.'/lib/magic/magic');
			$mime =  finfo_file($finfo, $path);
			finfo_close($finfo);
		} else {
			$mime = false;
		}
  			
		if (! $mime) {
			$mime = "application/octet-stream";
		}
		
		if (! $allowHtml) {
			if ($mime == "text/html" || $mime == "application/xhtml+xml") {
				$mime = "text/plain";
			}
		}
		
		return $mime;
	}
	
	protected function serveFile($path, $mime) {
		if (file_exists($path)) {
  			if($mime){
				header("Content-Type: ".$mime);
  			}
			$this->readfile($path);
		} else {
			$this->serveFile(WIKIDOT_ROOT."/files/file_not_exists.html", "text/html");
		}
	}
	
	protected function readfile($path) {
		if (GlobalProperties::$XSENDFILE_USE) {
			header(GlobalProperties::$XSENDFILE_HEADER . ": $path");
		} else {
			readfile($path);
		}
	}
	
	protected function buildPath($site, $file) {
		return WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/'.$file;
	}
	
	public function process() {
		global $timeStart;

		// initialize logging service
		$logger = OzoneLogger::instance();
		$loggerFileOutput = new OzoneLoggerFileOutput();
		$loggerFileOutput->setLogFileName(WIKIDOT_ROOT."/logs/ozone.log");
		$logger->addLoggerOutput($loggerFileOutput);
		$logger->setDebugLevel(GlobalProperties::$LOGGER_LEVEL);
		
		$logger->debug("request processing started, logger initialized");

		Ozone ::init();
		
		$runData = new RunData();
		$runData->init();
		Ozone :: setRunData($runData);
		$logger->debug("RunData object created and initialized");

		// check if site (wiki) exists!
		$siteHost = $_SERVER["HTTP_HOST"];
		
		$site = $this->getSite($siteHost);
		
		if($site == null){
			$this->serveFile(WIKIDOT_ROOT."/files/site_not_exists.html", "text/html");
			return;
		} 
		
		$runData->setTemp("site", $site);	
		//nasty global thing...
		$GLOBALS['siteId'] = $site->getSiteId();
		$GLOBALS['site'] = $site;

		// handle session at the begging of procession
		$runData->handleSessionStart();

		$file = "files/" . $_SERVER['QUERY_STRING'];

		if (! $this->userAllowed($runData->getUser(), $site, $file)) {
			header("HTTP/1.0 401 Unauthorized");
			echo "Not authorized. This is a private site with access restricted to its members.";
			exit();
		}
		
		if(!$file){exit();}
		
		
		$path = $this->buildPath($site, "files/" . $file);
		$mime = $this->fileMime($path, false); // no HTML MIME please!
		$this->serveFile($path, $mime);

		return;
	}

}
