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

class CustomDomainScript extends SmartyScreen {
	
	public function build($runData){
		
		$user = $runData->getUser();
		if($user){
			
			$runData->contextAdd('user', $user);
			
			// start a session for the custom domain
			// and return the session_id to the browser
			
			$pl = $runData->getParameterList();
			$domain = $pl->getParameterValue("domain");
			$url = $pl->getParameterValue("url");
			
			$session = $runData->getSession();
			
			$runData->contextAdd('sessionId', $session->getSessionId());
			$runData->contextAdd('cookieName', GlobalProperties::$SESSION_COOKIE_NAME);
			
			// now there is a small hack to prevent routing issues. ask MF about details
			$session = $runData->getSession();
			$ipString = $runData->createIpString();
			
			$runData->contextAdd('sessionIp', $session->getIpAddress());
			$runData->contextAdd('currentIp', $ipString);

		}
			
	}
	
}
