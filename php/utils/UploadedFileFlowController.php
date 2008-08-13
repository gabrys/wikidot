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
 * @version $Id: UploadedFileFlowController.php,v 1.5 2008/08/01 14:00:27 quake Exp $
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class UploadedFileFlowController extends WebFlowController {

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
		$this->setContentTypeHeader("text/html");
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
	
	/**
	 * Gets a site from given hostname. Works for sites inside URL_DOMAIN, URL_UPLOAD_DOMAIN and custom domains
	 *
	 * @param string $siteHost
	 * @return DB_Site
	 */
	protected function getSite($siteHost) {
		
		$memcache = Ozone::$memcache;
		
		$regexp = "/^([a-zA-Z0-9\-]+)\.(" . GlobalProperties::$URL_DOMAIN_PREG . "|" . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . ")$/";
		if (preg_match($regexp, $siteHost, $matches) == 1) {
			// select site based on the unix name
			
			$siteUnixName = $matches[1];
			$mcKey = 'site..'.$siteUnixName;
			$site = $memcache->get($mcKey); 
			if($site == false){
				$c = new Criteria();
				$c->add("unix_name", $siteUnixName);
				$c->add("site.deleted", false);
				$site = DB_SitePeer::instance()->selectOne($c);
				if($site) {
					$memcache->set($mcKey, $site, 0, 3600);
				}	
			}
		} else {
			// select site based on the custom domain
			
			$mcKey = 'site_cd..'.$siteHost;
			$site = $memcache->get($mcKey);
			if ($site == false) {	
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
		if ($dir != "resized-images" && $dir != "files" && $dir != "code" && $dir != "auth") {
			return true;
		}
		
		return false;
	}
	
	/**
	 * checks if the user is a member of a site
	 *
	 * @param DB_OzoneUser $user
	 * @param DB_Site $site
	 * @return boolean
	 */
	public function member($user, $site) {
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
	
	public function userAllowed($user, $site, $file = "auth/") {
	
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
			$mime =  FileMime::mime($path);
		} else {
			$mime = false;
		}
  			
		if (! $mime || $mime == "application/msword") {
			$mime = "application/octet-stream";
		}
		
		if (! $allowHtml) {
			if ($mime == "text/html" || $mime == "application/xhtml+xml") {
				$mime = "text/plain";
			}
		}
		
		return $mime;
	}
	
	/**
	 * sets the Expires header
	 *
	 * @param int $expires time in seconds
	 */
	protected function setExpiresHeader($expires) {
		$expires = (int) $expires;
		
		if ($expires) {
			if ($expires > 0) {
				$date = gmdate("D, d M Y H:i:s", time() + $expires) . " GMT";
				header("Expires: " . $date);
			} else {
				header("Cache-Control: no-cache, must-revalidate");
				header("Expires: Mon, 26 Jul 1997 05:00:00 GMT");
			}
		}
	}
	
	/**
	 * sets the Content-type header
	 *
	 * @param string $mime
	 */
	protected function setContentTypeHeader($mime) {
		if ($mime) {
			header("Content-type: $mime; charset=utf-8");
		}
	}
	
	/**
	 * serves the file using file path, mime type and expire offset
	 *
	 * @param string $path the file to serve
	 * @param string $mime the mime to set
	 * @param int $expires time in seconds to expire
	 */
	protected function serveFile($path, $mime = null, $expires = null) {
		if (file_exists($path)) {
  			$this->setContentTypeHeader($mime);
  			$this->setExpiresHeader($expires);
			$this->readfile($path);
		} else {
			$this->serveFile(WIKIDOT_ROOT."/files/file_not_exists.html", "text/html");
		}
	}
	
	/**
	 * sends the file to the browser using PHP's readfile or X-Sendfile header
	 *
	 * @param unknown_type $path
	 */
	protected function readfile($path) {
		if (GlobalProperties::$XSENDFILE_USE) {
			header(GlobalProperties::$XSENDFILE_HEADER . ": $path");
		} else {
			readfile($path);
		}
	}
	
	/**
	 * builds the path to local file
	 *
	 * @param DB_Site $site
	 * @param string $file
	 * @return string
	 */
	protected function buildPath($site, $file) {
		return $site->getLocalFilesPath().'/'.$file;
	}
	
	/**
	 * serves a file of given path with autodetected MIME type and given expires (if any)
	 *
	 * @param string $path
	 * @param int $expires time in seconds
	 */
	protected function serveFileWithMime($path, $expires = null) {
		
		/* guess/set the mime type for the file */
		if ($dir == "theme" || preg_match("/\.css$/", $path)) {
			$mime = "text/css";
		} else if (preg_match("/\.js$/", $path)) {
			$mime = "text/javascript";
		}
		
		if (! isset($mime)) {
			$mime = $this->fileMime($path, true);
		}
		
		$this->serveFile($path, $mime, $expires);
	}
	
	/**
	 * detects from "file" if this is code request
	 * 
	 * @param string $file
	 * @return bool
	 */ 
	protected function isCodeRequest($file) {
		if (preg_match(";^code/;", $file)) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * detects from "file" if this is auth request
	 *
	 * @param string $file
	 * @return bool
	 */
	protected function isAuthRequest($file) {
		if (preg_match(";^auth/;", $file)) {
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * Serves a code extracted from the page
	 *
	 * @param DB_Site $site
	 * @param string $fileName code/pagename/number
	 * @param int $expires timeout in seconds
	 */
	protected function serveCode($site, $fileName, $expires = 0) {
		$m = array();
		
		if (preg_match(";^code/([^/]+)(?:/([0-9]+))?$;", $fileName, $m)) {
			$pageName = $m[1];
			$number = 1;
			if (isset($m[2])) {
				$number = (int) $m[2];	
			}
			
			$ext = new CodeblockExtractor($site, $pageName, $number);
			
			$this->setExpiresHeader($expires);
			$this->setContentTypeHeader($ext->getMimeType());
			echo $ext->getContents();
			
		} else {
			$this->fileNotExists();
		}
	}
	
	/**
	 * Serves an auth response which is a redirect back to the supplied URL
	 *
	 * @param string $fileName auth/url
	 */
	protected function serveAuthResponse($fileName) {
		
		if (preg_match(";^auth/(.*)$;", $fileName, $m)) {
			
			$url = urldecode($m[1]);
			header('HTTP/1.1 301 Moved Permanently');
			header("Location: $url");
			
		} else {
			$this->fileNotExists();
		}
	}
	
	/**
	 * validates the ucookie
	 *
	 * @param DB_UCookie $ucookie
	 * @param DB_Site $site
	 * @return bool is the ucookie valid
	 */
	protected function validateUCookie($ucookie, $site) {
		if (! $ucookie || ! $ucookie->getOzoneSession() || ! $ucookie->getOzoneSession()->getOzoneUser() || ! $site) {
			return false;
		}
		if ($ucookie->getSiteId() != $site->getSiteId()) {
			return false;
		}
		return true;
	}
	
	public function process() {

		Ozone ::init();
		
		$runData = new RunData();
		$runData->init();
		Ozone::setRunData($runData);
		
		$siteHost = $_SERVER['HTTP_HOST'];
		$site = $this->getSite($siteHost);
		
		if (! $site) {
			$this->siteNotExists();
			return;
		}
		
		$file = urldecode($_SERVER['QUERY_STRING']);
		$file = preg_replace("/\\?.*\$/", "", $file);
		$file = preg_replace("|^/*|", "", $file);
		
		if (! $file) {
			$this->fileNotExists();
			return;
		}
		
		$path = $this->buildPath($site, $file);

		if ($this->isUploadDomain($siteHost)) {
			
			if ($this->publicArea($site, $file)) {
					
				if ($this->isCodeRequest($file)) {
					$this->serveCode($site, $file, 3600);
				} else {
					$this->serveFileWithMime($path, 3600);
				}
				
				return;
				
			} else {
			
				/* NON PUBLIC AREA -- CHECK PERMISSION! */
	
				if (preg_match("/\\?ukey=(.*)\$/", $_SERVER['QUERY_STRING'], $matches)) {
					setcookie("ucookie", $matches[1], 0, "/", $siteHost);
					$this->redirect($site, GlobalProperties::$URL_UPLOAD_DOMAIN, $file);
					return;
				}
				if (! isset($_COOKIE["ucookie"])) {
					$this->redirect($site, GlobalProperties::$URL_DOMAIN, $file);
					return;
				}
				
				$ucookie = DB_UcookiePeer::instance()->selectByPrimaryKey($_COOKIE["ucookie"]);
				
				if (! $this->validateUCookie($ucookie, $site)) {
					$this->redirect($site, GlobalProperties::$URL_DOMAIN, $file);
					return;
				}
				
				$user = $ucookie->getOzoneSession()->getOzoneUser();
				
				if ($this->userAllowed($user, $site, $file)) {
					
					if ($this->isCodeRequest($file)) {
						$this->serveCode($site, $file, -3600);
					} elseif ($this->isAuthRequest($file)) {
						$this->serveAuthResponse($file);
					} else {
						$this->serveFileWithMime($path, -3600);
					}
					return;
				}
			}
			
		} else {

			/* NOT UPLOAD DOMAIN, so it's *.wikidot.com or a custom domain */
			
			if ($this->publicArea($site, $file)) {
				
				$this->redirect($site, GlobalProperties::$URL_UPLOAD_DOMAIN, $file);
				return;
				
			} else {
				
				$runData->handleSessionStart();

				if ($this->userAllowed($runData->getUser(), $site, $file)) {
					
					$ucookie = new DB_Ucookie();
					$ucookie->generate($site, $runData->getSession());
					$ucookie->save();
					
					$ukey = $ucookie->getUcookieId();
					setcookie("ucookie", $ukey, 0, "/", $siteHost);
					$this->redirect($site, GlobalProperties::$URL_UPLOAD_DOMAIN, $file, $ukey);
					
					return;
					
				}
			}
		}
		
		$this->forbidden();
		
	}
}
