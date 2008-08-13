<?php
/**
 * Wikidot - free wiki collaboration software
 * Copyright (c) 2008, Wikidot Inc.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * For more information about licensing visit:
 * http://www.wikidot.org/license
 * 
 * @category Wikidot
 * @package Wikidot
 * @version $Id$
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class PrivateWikiScript extends SmartyScreen {
	
	public function build($runData){
		
		$user = $runData->getUser();
		$site_id = (int) $runData->getParameterList()->getParameterValue("site_id");
		$site = DB_SitePeer::instance()->selectByPrimaryKey($site_id);
		
		$u = new UploadedFileFlowController();
		
		if ($u->userAllowed($user, $site)) {
			
			// user has permission to this site
			// check if the cookie is valid
			
			$ukey = null;
			if (isset($_COOKIE["ucookie"])) {
				$ukey = $_COOKIE["ucookie"];
			}
			$ucookie = DB_UcookiePeer::instance()->selectByPrimaryKey($ukey);
			
			if (! $ukey || ! $u->validateUCookie($ucookie, $site)) {

				// user is allowed and has an invalid cookie (or none), generate new!
				
				$ucookie = new DB_Ucookie();
				$ucookie->generate($site, $runData->getSession());
				$ucookie->save();
				
				$ukey = $ucookie->getUcookieId();
			
				$domain = $site->getUnixName() . "." . GlobalProperties::$URL_UPLOAD_DOMAIN;
				$proto = ($_SERVER["HTTPS"]) ? "https" : "http";
				$url = "$proto://$domain/local--auth";
				
				$runData->contextAdd("redir", $url);
				$runData->contextAdd("usePrivateWikiScript", true);
			}
			
		}
			
	}
	
}
