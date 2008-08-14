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

class CustomDomainLoginFlowController extends WebFlowController {

	public static $secretString = "--DziendobrynazywamsieczesioiopowiemWamWierszyka--";
	protected $controllerUrl = "/domainauth.php";
	
	protected function siteNotExists() {
		$this->serveFile(WIKIDOT_ROOT."/files/site_not_exists.html", "text/html");
	}
	
	/**
	 * Redirects browser to certain URL build from URL and params
	 *
	 * @param string $url URL to redirect to
	 * @param array $params params to pass with GET
	 */
	protected function redirect($url, $params = null) {
		if (is_array($params)) {
			$url = $url . "?" . http_build_query($params);
		}
		
		header('HTTP/1.1 301 Moved Permanently');
		header("Location: $url");
		
	}
	
	protected function redirectConfirm($url) {
		$this->redirect($this->controllerUrl, array("confirm" => "cookie", "url" => $url));
	}
	
	protected function cookieError($url) {
		$url = htmlspecialchars($url);
		$this->setContentTypeHeader("text/html");
		echo "<p>Can't proceed, you should accept cookies for this domain.</p>";
		echo "<p>Then you can go back to $url</p>";
	}
	
	/**
	 * Gets a site from given hostname. This version works for custom domains
	 *
	 * @param string $siteHost
	 * @return DB_Site
	 */
	protected function getSite($siteHost) {
		
		$memcache = Ozone::$memcache;
		
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
		
		return $site;
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
		
		$url = $_GET["url"];
		$siteId = (int) $site->getSiteId();
		$confirm = isset($_GET["confirm"]);
		
		if (! $confirm) {
			
			// checking
			$user_id = (int) $_GET["user_id"];
			$skey = $_GET["skey"];
			$secret = pg_escape_string(self::$secretString);
			
			$sessionPeer = new DB_OzoneSessionPeer();
			$c = new Criteria();
			$c->add("user_id", $user_id);
			$c->add("MD5($siteId || '$secret' || session_id)", $skey);
			$session = $sessionPeer->selectOne($c);
			
			if ($session) {
				setcookie(GlobalProperties::$SESSION_COOKIE_NAME, $session->getSessionId(), null, '/');
				$this->redirectConfirm($url);
			} else {
				$this->redirect($url);
			}
			
		} else {
			
			// checking if cookie exists
			
			$runData->handleSessionStart();
			
			if ($runData->getUser()) {
				$this->redirect($url);
			} else {
				$this->cookieError($url);
			}
		}
		
	}
}
