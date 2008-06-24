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
 * @version $Id: PrivateFileFlowController.php,v 1.5 2008/06/24 10:36:53 quake Exp $
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class UploadedFileFlowController extends PrivateFileFlowController {
	public function process() {

		Ozone ::init();
		
		$runData = new RunData();
		$runData->init();
		Ozone :: setRunData($runData);
		
		$siteHost = $_SERVER['HTTP_HOST'];
		
		/* Redirect everything outside the secure domain to corresponding secure domain */

		if (! preg_match("/^[^.]*\." . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . "$/", $siteHost)) {

			$proto = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 'https' : 'http';
			$domain = $this->getSite($siteHost)->getUnixName() . "." . GlobalProperties::$URL_UPLOAD_DOMAIN;
			$file = $_SERVER['QUERY_STRING'];
			
			header ('HTTP/1.1 301 Moved Permanently');
			header ("Location: ${proto}://${domain}/local--${file}");
			
			/* Just redirect, don't serve anything */
			return;
		}
		
		/* Here we are in the secure domain */

		$siteHost = preg_replace("/" . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . "$/", GlobalProperties::$URL_DOMAIN, $siteHost);
		
		$site = $this->getSite($siteHost);
		
		if (! $site) {
			$this->serveFile(WIKIDOT_ROOT."/files/site_not_exists.html", "text/html");
			return;
		}
		
		$runData->setTemp("site", $site);	
		//nasty global thing...
		$GLOBALS['siteId'] = $site->getSiteId();
		$GLOBALS['site'] = $site;

		// handle session at the begging of procession
		$runData->handleSessionStart();
		
		// Mangle the $file.
		$file = $_SERVER['QUERY_STRING'];
		$file = preg_replace("/\\?[0-9]*\$/", "", $file);
		$file = preg_replace("|^/*|", "", $file);
		
		if (! $file) {
			return;
		}
		
		$dir = array_shift(explode("/", $file));
		
		/* Check permissions for uplodade files and resized images */

		if ($dir == "resized-images" || $dir == "files") {
			
			if (! $this->userAllowed($runData->getUser(), $site)) {
				header("HTTP/1.0 401 Unauthorized");
				echo "Not authorized. This is a private site with access restricted to its members.";
				return;
			}
			
		}
		
		/* file path */
		$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/'.$file;
		
		/* guess/set the mime type for the file */
		if ($dir == "theme") {
			$mime = "text/css";
		}
		
		if (! isset($mime)) {
			$mime = $this->fileMime($path, false);
		}
		
		/* serve file */
		$this->serveFile($path, $mime);
		
	}
}
