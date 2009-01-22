<?php

class Wikidot_Facade_Site extends Wikidot_Facade_Base {
	/**
	 * Get pages from a site
	 * 
	 * Argument array keys:
	 *  performer: who asks for this
     *  site: site to get pages from
     *  category: category to get pages from (optional)
	 * 
	 * @param struct $args
	 * @return struct
	 */
	public function pages($args) {
		$args = $this->parseArgs($args, array("performer", "site"));
		
		WDPermissionManager::instance()->canAccessSite($args["performer"], $args["site"]);
		
		$c = new Criteria();
		$c->add("site_id", $args["site"]->getSiteId());
		if (isset($args["category"])) {
			$c->add("category_id", $args["category"]->getCategoryId());
		}
		
		$ret = array();
		foreach (DB_PagePeer::instance()->selectByCriteria($c) as $page) {
			$ret[] = $this->repr($page, "meta");
		}
		return $ret;
	}
}
