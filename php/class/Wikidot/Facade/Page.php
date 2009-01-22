<?php

class Wikidot_Facade_Page extends Wikidot_Facade_Base {
	/**
	 * Get all page attributes from site
	 * 
	 * Argument array keys:
	 *  site: site to get page from
	 *  page: page to get (full_name)
	 * 
	 * @param struct $args
	 * @return struct
	 */
	public function get($args) {
		$this->parseArgs($args, array("performer", "site", "page"));
		
		WDPermissionManager::instance()->canAccessSite($this->performer, $this->site);
		
		return $this->repr($this->page);
	}
}
