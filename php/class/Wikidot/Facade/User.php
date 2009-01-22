<?php

class Wikidot_Facade_User extends Wikidot_Facade_Base {
	/**
	 * Get sites of a user. This is a fake one!
	 * 
	 * @param struct $args
	 * @return struct
	 */
	public function sites($args) {
		$this->parseArgs($args, array("performer", "user"));
		$site = DB_SitePeer::instance()->selectByPrimaryKey(1);
		return $this->repr(array($site));
	}
}
