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

		if (! $this->userAllowed($runData->getUser(), $site)) {
			header("HTTP/1.0 401 Unauthorized");
			echo "Not authorized. This is a private site with access restricted to its members.";
			exit();
		}
		
		$file = $_SERVER['QUERY_STRING'];
		if (! $file) {
			exit();
		}
		
		/* Mangle the $file. */
		
		$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/'.$file;
		
		$mime_secure = $this->fileMime($path, true);
		$mime_insecure = $this->fileMime($path, false);
		
		if ($mime_insecure == $mime_secure || $secure_domain) {
			$this->serveFile($path, $mime_secure);
			return;
		}
		
		// we must redirect user
		$proto = (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on') ? 'https' : 'http';
		$domain = $site->getUnixName() . "." . GlobalProperties::$URL_UPLOAD_DOMAIN;
		
		header ('HTTP/1.1 301 Moved Permanently');
		header ("Location: ${proto}://${domain}/local--files/${file}");

		return;
	}
}
