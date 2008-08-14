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

class CustomDomainScriptController extends UploadedFileFlowController {
	
	public function process() {
		
		Ozone::init();
		$runData = new RunData();
		
		$siteHost = $_SERVER['HTTP_HOST'];
		$site_id = $_GET["site_id"];
		
		$site = DB_SitePeer::instance()->selectByPrimaryKey($site_id);
		
		if (! $site) {
			echo "error";
		}
		
		if ($siteHost == GlobalProperties::$URL_HOST) {
			$runData->handleSessionStart();
			if ($runData->getUser()) {
				$proto = ($_SERVER["HTTPS"]) ? "https" : "http";
				$domain = $site->getCustomDomain();
				$url = "$proto://$domain/domainauth.js.php";
				
				header('HTTP/1.1 301 Moved Permanently');
				header("Location: $url");
			}
		} else {
			$skey = md5($site_id . CustomDomainLoginFlowController::$secretString . $runData->getSessionId());
			echo "<script type=\"text/javascript\"> parent.location = '/domainauth.php?skey=$skey&url=' + encodeURIComponent(parent.location.toString()); </script>";
		}
	}
	
}
