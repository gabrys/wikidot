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

	protected function getSite($siteHost) {
		
		$memcache = Ozone::$memcache;
		
		if(preg_match("/^([a-zA-Z0-9\-]+)\." . GlobalProperties::$URL_DOMAIN_PREG . "$/", $siteHost, $matches)==1){
			$siteUnixName=$matches[1];
			// select site based on the unix name
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
	
	protected function userAllowed($user, $site) {
	
		if (! $site) {
			return false; 
		}
		
		if (! $site->getPrivate()) { // site is public
			return true;
		}
	
		if (! $user) {
			return false; 
		}
		
		if ($user->getSuperAdmin() || $user->getSuperModerator()) { // user is a superuser
			return true;
		}
		
		// check if member
		$c = new Criteria();
		$c->add("site_id", $site->getSiteId());
		$c->add("user_id", $user->getUserId());
		
		if (DB_MemberPeer::instance()->selectOne($c)) { // user is a member of the wiki
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
		if(file_exists($path)){
  			if($mime){
				header("Content-Type: ".$mime);
  			}
			$this->readfile($path);
		}
	}
	
	protected function readfile($path) {
		if (GlobalProperties::$XSENDFILE_USE) {
			header(GlobalProperties::$XSENDFILE_HEADER . ": $path");
		} else {
			readfile($path);
		}
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
			$content = file_get_contents(WIKIDOT_ROOT."/files/site_not_exists.html");
			echo $content;
			return $content;
		} 
		
		$runData->setTemp("site", $site);	
		//nasty global thing...
		$GLOBALS['siteId'] = $site->getSiteId();
		$GLOBALS['site'] = $site;

		// handle session at the begging of procession
		$runData->handleSessionStart();

		if (! $this->userAllowed($runData->getUser(), $site)) {
			header("HTTP/1.0 401 Unauthorized");
			echo "Not authorized. This is a private site with access restricted to its members.";
			exit();
		}

		$file = $_SERVER['QUERY_STRING'];
		
		if(!$file){exit();}
		
		$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/files/'.$file;
		
		$mime = $this->fileMime($path);
		
		$this->serveFile($path, $mime);

		return;
	}

}
