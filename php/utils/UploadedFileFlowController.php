<?php

class UploadedFileFlowController extends PrivateFileFlowController {
	public function process() {

		Ozone ::init();
		
		$runData = new RunData();
		$runData->init();
		Ozone :: setRunData($runData);
		
		$siteHost = $_SERVER['HTTP_HOST'];
		
		$secure_domain = false;
		
		// manage the special trusted upload domain
		if (preg_match("/^[^.]*\." . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . "$/", $siteHost)) {
			$secure_domain = true;
			$siteHost = preg_replace("/" . GlobalProperties::$URL_UPLOAD_DOMAIN_PREG . "$/", GlobalProperties::$URL_DOMAIN, $siteHost);
		}
		
		$site = $this->getSite($siteHost);
		
		if (! $site) {
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
		
		// Mangle the $file.
		$file = $_SERVER['QUERY_STRING'];
		$file = preg_replace("/\\?[0-9]*\$/", "", $file);
		$file = preg_replace("|^/*|", "", $file);
		
		if (! $file) {
			exit();
		}
		
		$dir = array_shift(explode("/", $file));
		
		if ($dir == "resized-images" || $dir == "files") {
			
			if (! $this->userAllowed($runData->getUser(), $site)) {
				header("HTTP/1.0 401 Unauthorized");
				echo "Not authorized. This is a private site with access restricted to its members.";
				exit();
			}
				
		}
		
		$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/'.$file;
		
		if ($secure_domain) { /* SERVE FILE */
			
			$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/'.$file;
			
			if ($dir == "theme") {
				$mime = "text/css";
			}
			
			if (! $mime) {
				$mime = $this->fileMime($path, false);
			}
			
			$this->serveFile($path, $mime);
			
			
		} else { /* OR REDIRECT */

			$proto = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 'https' : 'http';
			$domain = $site->getUnixName() . "." . GlobalProperties::$URL_UPLOAD_DOMAIN;
			
			header ('HTTP/1.1 301 Moved Permanently');
			header ("Location: ${proto}://${domain}/local--${file}");
		}
	}
}
