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
	
	/**
	 * Get files from page
	 * 
	 * Argument array keys:
	 *  site: site to get page from
	 *  page: page to get (full_name) files from
	 * 
	 * @param struct $args
	 * @return struct
	 */
	public function files($args) {
		$this->parseArgs($args, array("performer", "site", "page"));
		
		WDPermissionManager::instance()->canAccessSite($this->performer, $this->site);
		
		$c = new Criteria();
		$c->add("page_id", $this->page->getPageId());
		$files = DB_FilePeer::instance()->select($c);
		
		return $this->repr($files);
	}
	
	public function save($args) {
		
		if (! isset($args['page'])) {
			throw new Wikidot_Facade_Exception_WrongArguments("Page argument must be passed");
		}
		
		$arg_page = $args['page'];
		
		unset($args['page']);
		$this->parseArgs($args, array("performer", "site"));
		
		try {
			
			$page = $this->_parsePage($this->site, $arg_page);
			
			// page exists
			$new = false;
			
			// check permision to edit here
			
		} catch (Wikidot_Facade_Exception_WrongArguments $e) {
			
			// page does not exist
			$new = true;
			
			// check permission to create here
			
			// create
			$page = new DB_Page();
			// ...
		}
		
		if ($this->title === null && ! $this->tags && ! $this->parent_page && $this->source === null) {
			
			if ($new) {
				// save a new page, but only page_name is passed
				
			} else {
				// no changes
				// maybe recompile?
				//
				// or just throw Wikidot_Facade_Exception_WrongArgument
				
			}
			
			return;
		}
		
		if ($this->source !== null) {
			// set source
		}
		
		if ($this->title !== null) {
			// set title
		}
		
		if ($this->tags) {
			// set tags
		}
		
		if ($this->parent_page) {
			// set parent_page
		}
		
		// save new revision and stuff
	}
}
