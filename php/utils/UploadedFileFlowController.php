<?php

class UploadedFileFlowController extends PrivateFileFlowController {
	public function process() {

		Ozone ::init();
		
		$runData = new RunData();
		$runData->init();
		Ozone :: setRunData($runData);
		
		$file = $_SERVER['QUERY_STRING'];

		$file = explode("/", $file);
		$siteHost = array_shift($file);
		array_shift($file);
		$file = implode("/", $file);
		
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

		if(!$file){exit();}
		$path = WIKIDOT_ROOT.'/web/files--sites/'.$site->getUnixName().'/files/'.$file;
		
		$this->serveFile($path);

		return;
	}
}
