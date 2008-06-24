<?php

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
