<?php

abstract class Wikidot_Facade_Base {
	/**
	 * The array of argument array keys that are accepted and passed thru
	 * in addition to standard ones (like site, page, category, ...)
	 *  
	 * @var array
	 */
	protected $passthruArgs = array();
	
	/**
	 * User that calls Facade methods
	 * 
	 * @var DB_OzoneUser
	 */
	protected $performer;
	
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
		
		$ret = array();
		
		foreach ($args as $key => $value) {
			switch ($key) {
				case "performer":
					$ret[$key] = $this->_parseUser($value);
					break;
				case "user":
					$ret[$key] = $this->_parseUser($value);
					break;
				case "site":
					$ret[$key] = $this->_parseSite($value);
					break;
				case "category":
					$ret[$key] = $this->_parseCategory($value);
					break;
				default:
					if (in_array($key, $this->passthruArgs)) {
						$ret[$key] = $value;
					} else {
						throw new Wikidot_Facade_Exception_WrongArguments("Invalid argument array key: $key");
					}
					break;
			}
		}
		
		if ($this->performer) {
			$ret["performer"] = $this->performer;
		}
		
		foreach ($requiredArgs as $key) {
			if (! isset($ret[$key])) {
				throw new Wikidot_Facade_Exception_WrongArguments("Required argument array key not passed: $key");
			}
		}
		
		return $ret;
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
		
		// we're not an array, check by type
		if (is_a($object, "DB_Page")) {
			return $this->_reprPage($object, $hint);
		}
		
		// the result is of none supported types
		throw new Wikidot_Facade_Exception_WrongReturnValue("Invalid type of returned value");
	}
	
	private function _parseUser($user) {
		if (is_int($user)) { // int = ID
			$user = DB_OzoneUserPeer::instance()->selectByPrimaryKey($user);
		}
		
		if (is_a($user, 'DB_OzoneUser')) {
			return $user;
		}
		throw new Wikidot_Facade_Exception_WrongArguments("User does not exist");
	}
	
	private function _parseSite($site) {
		if (is_int($site)) { // int = ID
			$site = DB_SitePeer::instance()->selectByPrimaryKey($site);
		}
		
		if (is_a($site, 'DB_Site')) {
			throw new Wikidot_Facade_Exception_WrongArguments("Site does not exist");
		}
	}
	
	private function _parseCategory($category) {
		if (is_int($category)) { // int = ID
			$category = DB_SitePeer::instance()->selectByPrimaryKey($category);
		}
		
		if (is_a($category, 'DB_Site')) {
			throw new Wikidot_Facade_Exception_WrongArguments("Site does not exist");
		}
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
			$name = $page->getUnixName();
			$tags = $page->getTagsAsArray();
			
			$parent_page_name = null;
			if ($parent_page_id = $page->getParentPageId()) {
				if ($parent_page = DB_PagePeer::instance()->selectByPrimaryKey($parent_page_id)) {
					$parent_page_name = $parent_page->getUnixName();
				}
			}
			
			$user_created_name = null;
			if ($user_created_id = $page->getOwnerUserId()) {
				if ($user_created = DB_OzoneUser::instance()->selectByPrimaryKey($user_created_id)) {
					$user_created_name = $user_created->getNickName();
				}
			}
			
			return array(
				"site" => $page->getSite()->getUnixName(),
    			"category" => $category,
				"name" => $name,
				"full_name" => "$category:$name",
				"title" => $page->getTitle(),
				"tag_string" => join(" ", $tags),
				"tag_array" => $tags,
				"parent_page" => $parent_page_name,
				"date_edited" => $this->_reprData($page->getDateLastEdited()),
				"user_edited" => $page->getLastEditUserString(),
				"date_created" => $this->_reprData($page->getDateCreated()),
				"user_created" => $user_created_name
			);
		} else {
			return array(
				"source" => $page->getSource(),
				"html" => $page->getCompiled(),
				"meta" => $this->_reprPage($page, "meta"),
			);
		}
	}
}
