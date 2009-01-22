<?php

abstract class Wikidot_Facade_Base {
	
	/**
	 * 
	 * @var DB_OzoneUser
	 */
	protected $performer = null;
	
	/**
	 * 
	 * @var DB_Site
	 */
	public $site = null;
	
	/**
	 * 
	 * @var DB_Category
	 */
	protected $category = null;
	
	/**
	 * 
	 * @var DB_Page
	 */
	protected $page = null;
	
	/**
	 * construct Facade object
	 * 
	 * @param $performer DB_OzoneUser
	 */
	public function __construct($performer = null) {
		$this->performer = $performer;
	}
	
	/**
	 * Parse the arguments array and resolve objects from their names.
	 * 
	 * @param array $args the argument array
	 * @param array $requiredArgs the required argument array keys
	 * @return array the array of arguments filtered and resolved to native types
	 */
	protected function parseArgs($args, $requiredArgs = array()) {
		if (! is_array($args)) {
			throw new Wikidot_Facade_Exception_WrongArguments("Argument is not an array");
		}
		
		// simple types
		foreach ($args as $key => $value) {
			switch ($key) {
				case "performer":
					if (! $this->performer) {
						$this->performer = $this->_parseUser($value);
					}
					break;
				case "site":
					$this->site = $this->_parseSite($value);
					break;
				case "category":
					$this->category = $value;
					break;
				case "page":
					$this->page = $value;
					break;
				default:
					throw new Wikidot_Facade_Exception_WrongArguments("Invalid argument array key: $key");
					break;
			}
		}
		
		// more sophisticated ones...
		if ($this->category) {
			$this->category = $this->_parseCategory($this->site, $this->category);
		}
		
		if ($this->page) {
			$this->page = $this->_parsePage($this->site, $this->page);
		}
		
		foreach ($requiredArgs as $key) {
			if (! $this->$key) {
				throw new Wikidot_Facade_Exception_WrongArguments("Required argument array key not passed: $key");
			}
		}
	}
	
	protected function repr($object, $hint = null) {
		// first deal with arrays of objects
		if (is_array($object)) {
			$array = array();
			foreach ($object as $item) {
				$array[] = $this->repr($item, $hint);
			}
			return $array;
		}
		
		// page
		if ($object instanceof DB_Page) {
			return $this->_reprPage($object, $hint);
		}
		
		// category
		if ($object instanceof DB_Category) {
			return $this->_reprCategory($object);
		}
		
		// the result is of none supported types
		throw new Wikidot_Facade_Exception_WrongReturnValue("Invalid type of returned value");
	}
	
	private function _parseUser($user) {
		if (is_int($user)) { // int = ID
			$user = DB_OzoneUserPeer::instance()->selectByPrimaryKey($user);
		}
		
		if ($user instanceof DB_OzoneUser) {
			return $user;
		}
		throw new Wikidot_Facade_Exception_WrongArguments("User does not exist");
	}
	
	private function _parseSite($site) {
		if (is_int($site)) { // int = ID
			
			$site = DB_SitePeer::instance()->selectByPrimaryKey($site);
			
		} elseif (is_string($site)) { // string = name
			
			$c = new Criteria();
			$c->add("unix_name", WDStringUtils::toUnixName($site));
			$site = DB_SitePeer::instance()->selectOne($c);
			
		}
		
		if ($site instanceof DB_Site) {
			return $site;
		}
		
		throw new Wikidot_Facade_Exception_WrongArguments("Site does not exist");
	}
	
	private function _parseCategory($site, $category) {
		if (is_int($category)) { // int = ID
			
			$category = DB_SitePeer::instance()->selectByPrimaryKey($category);
			
		} elseif (is_string($category)) {
			
			if ($site) {
				$c = new Criteria();
				$c->add("name", WDStringUtils::toUnixName($category));
				$c->add("site_id", $site->getSiteId());
				$category = DB_CategoryPeer::instance()->selectOne($c);
			}
		}
		
		if ($category instanceof DB_Category) {
			return $category;
		}
		throw new Wikidot_Facade_Exception_WrongArguments("Category does not exist");
	}
	
	private function _parsePage($site, $page) {
		if (is_int($page)) { // int = ID
			
			$page = DB_PagePeer::instance()->selectByPrimaryKey($page);
			
		} elseif (is_string($page)) {
			
			if ($site) {
				
				$page = preg_replace("/^_default:/", "", $page);
				
				$c = new Criteria();
				$c->add("unix_name", WDStringUtils::toUnixName($page));
				$c->add("site_id", $site->getSiteId());
				$page = DB_PagePeer::instance()->selectOne($c);
			}
		}
		
		if ($page instanceof DB_Page) {
			return $page;
		}
		throw new Wikidot_Facade_Exception_WrongArguments("Page does not exist");
	}
	
	/**
	 * string representation of date from ODate
	 * 
	 * @param $date ODate
	 * @return string
	 */
	private function _reprDate($date) {
		return $date->getDate();
	}
	
	/**
	 * string representation of compiled page
	 * 
	 * @param $compiled DB_PageCompiled
	 * @return string
	 */
	private function _reprPageCompiled($compiled) {
		$d = utf8_encode("\xFE");
		$content = $compiled->getText();
        $content = preg_replace("/" . $d . "module \"([a-zA-Z0-9\/_]+?)\"(.+?)?" . $d . "/", '', $content);
        // TODO fix links: 
    	//$content = preg_replace(';(<.*?)(src|href)="/([^"]+)"([^>]*>);si', '\\1\\2="http://'.$site->getDomain().'/\\3"\\4', $content);
		$content = preg_replace(';<script\s+[^>]+>.*?</script>;is', '', $content);
		$content = preg_replace(';(<[^>]*\s+)on[a-z]+="[^"]+"([^>]*>);si', '\\1 \\2', $content);
		return $content;
	}
	
	/**
	 * representation of category
	 * 
	 * @param $category DB_Category
	 * @return array
	 */
	private function _reprCategory($category) {
		return $category->getName();
	}
	
	/**
	 * External representation of a page object
	 *  
	 * @param DB_Page $page
	 * @param string $hint
	 * @return array
	 */
	private function _reprPage($page, $hint) {
		if ($hint == "meta") {
			$category = $page->getCategoryName();
			$name = preg_replace("|^$category:|", "", $page->getUnixName());
			$tags = $page->getTagsAsArray();
			
			$parent_page_name = null;
			if ($parent_page_id = $page->getParentPageId()) {
				if ($parent_page = DB_PagePeer::instance()->selectByPrimaryKey($parent_page_id)) {
					$parent_page_name = $parent_page->getUnixName();
				}
			}
			
			$user_created_name = null;
			if ($user_created_id = $page->getOwnerUserId()) {
				if ($user_created = DB_OzoneUserPeer::instance()->selectByPrimaryKey($user_created_id)) {
					$user_created_name = $user_created->getNickName();
				}
			}
			
			return array(
				"site" => $page->getSite()->getUnixName(),
    			"category" => $category,
				"name" => $name,
				"full_name" => $page->getUnixName(),
				"title" => $page->getTitle(),
				"tag_string" => join(" ", $tags),
				"tag_array" => $tags,
				"parent_page" => $parent_page_name,
				"date_edited" => $this->_reprDate($page->getDateLastEdited()),
				"user_edited" => $page->getLastEditUserString(),
				"date_created" => $this->_reprDate($page->getDateCreated()),
				"user_created" => $user_created_name
			);
		} else {
			return array(
				"source" => $page->getSource(),
				"html" => $this->_reprPageCompiled($page->getCompiled()),
				"meta" => $this->_reprPage($page, "meta"),
			);
		}
	}
}
