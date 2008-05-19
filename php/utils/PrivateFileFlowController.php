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
		
		$memcache = Ozone::$memcache;
		if(preg_match("/^([a-zA-Z0-9\-]+)\." . GlobalProperties::$URL_DOMAIN_PREG . "$/", $siteHost, $matches)==1){
			$siteUnixName=$matches[1];
			// select site based on the unix name
			
			// check memcached first!
			
			// the memcache block is to avoid database connection if possible
			
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
				if($site) {$memcache->set($mcKey, $site, 0, 3600);}	
			}
			/*
			if($site == null){
				// check for redirects
				$mcKey = 'domain_redirect..'.$siteHost;
				$newUrl = $memcache->get($mcKey);
				if($newUrl){
					header("HTTP/1.1 301 Moved Permanently");
					header("Location: ".$newUrl);
					exit();		
				}
				$c = new Criteria();
				$q = "SELECT site.* FROM site, domain_redirect WHERE domain_redirect.url='".db_escape_string($siteHost)."' " .
						"AND site.site_id = domain_redirect.site_id LIMIT 1";
				$c->setExplicitQuery($q);
				$site = DB_SitePeer::instance()->selectOne($c);
				if($site){
					$newUrl = 'http://'.$site->getDomain();
					$memcache->set($mcKey, $newUrl, 0, 3600);
					header("HTTP/1.1 301 Moved Permanently");
					header("Location: ".$newUrl);
					exit();	
				}
			}
			*/
			GlobalProperties::$SESSION_COOKIE_DOMAIN = '.'.$siteHost;
			
		}

		if($site == null){
			$content = file_get_contents(WIKIDOT_ROOT."/files/site_not_exists.html");
			echo $content;
			return $content;	
		} 
		
		$runData->setTemp("site", $site);	
		//nasty global thing...
		$GLOBALS['siteId'] = $site->getSiteId();
		$GLOBALS['site'] = $site;
		
		// set language
		$lang = $site->getLanguage();
		$runData->setLanguage($lang);
		$GLOBALS['lang'] = $lang;
		
		// and for gettext too:
		
		switch($lang){
			case 'pl':
				$glang="pl_PL";
				break;
			case 'en':
				$glang="en_US";
				break;
		}

		putenv("LANG=$glang"); 
		putenv("LANGUAGE=$glang"); 
		setlocale(LC_ALL, $glang.'.UTF-8');

		// Set the text domain as 'messages'
		$gdomain = 'messages';
		bindtextdomain($gdomain, WIKIDOT_ROOT.'/locale'); 
		textdomain($gdomain);

		// handle session at the begging of procession
		$runData->handleSessionStart();

		if($site->getPrivate() ){
			$user = $runData->getUser();
			if($user && !$user->getSuperAdmin() && !$user->getSuperModerator()){
				// check if member
				$c = new Criteria();
				$c->add("site_id", $site->getSiteId());
				$c->add("user_id", $user->getUserId());
				$mem = DB_MemberPeer::instance()->selectOne($c);
				if(!$mem) { $user = null;}
			}
			if($user == null){
				header("HTTP/1.0 401 Unauthorized");
				echo "Not authorized. This is a private site with access restricted to its members.";
				exit();
			}	
		}

		$file = $_SERVER['QUERY_STRING'];
		if(!$file){exit();}
		$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/files/'.$file;
		if(file_exists($path)){
			
			preg_match(';\.([a-z0-9]+)$;i', $path, $matches);
  			$ext = $matches[1];
  			if($ext){
  				$mimes = mimeTypes('/etc/mime.types');
  				$mime = $mimes[$ext];
  			}
  			if(!$mime){
				$finfo = finfo_open(FILEINFO_MIME, WIKIDOT_ROOT.'/lib/magic/magic');
				$mime =  finfo_file($finfo, $path);
				finfo_close($finfo);
  			}
  			
  			// to disable rendered html
  			if($mime == "text/html" || $mime == "application/xhtml+xml"){
  				$mime = "text/plain";
  			}
  			
  			if($mime){
				header("Content-Type: ".$mime);
  			}
			readfile($path);
		}

		return;
	}

}

function mimeTypes($file) {
       if (!is_file($file) || !is_readable($file)) return false;
       $types = array();
       $fp = fopen($file,"r");
       while (false != ($line = fgets($fp,4096))) {
           if (!preg_match("/^\s*(?!#)\s*(\S+)\s+(?=\S)(.+)/",$line,$match)) continue;
           $tmp = preg_split("/\s/",trim($match[2]));
           foreach($tmp as $type) $types[strtolower($type)] = $match[1];
       }
       fclose ($fp);
      
       return $types;
   }
