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

class Codeblock extends Screen {

	public function render($runData){
		
		try{
			// get site
			$site = $runData->getTemp("site");
			$runData->contextAdd("site", $site);

			$pl = $runData->getParameterList();
			
			$wikiPage = $pl->getParameterValue("wiki_page");
			
			if($site->getPrivate()){
				$user = $runData->getUser();
				if($user && !$user->getSuperAdmin() && !$user->getSuperModerator()){
					// check if member
					$c = new Criteria();
					$c->add("site_id", $site->getSiteId());
					$c->add("user_id", $user->getUserId());
					$mem = DB_MemberPeer::instance()->selectOne($c);
					if(!$mem) {
						// check if a viewer
						$c = new Criteria();
						$c->add("site_id", $site->getSiteId());
						$c->add("user_id", $user->getUserId());
						$vi = DB_SiteViewerPeer::instance()->selectOne($c);
						if(!$vi) {
							$user = null;
						}
					}
				}
				if($user == null){
					throw new ProcessException("This is a private wiki. Access is limited to selected users.");
				}
			}

			$wikiPage = WDStringUtils::toUnixName($wikiPage);
			$runData->setTemp("pageUnixName", $wikiPage);
			if($wikiPage===""){$wikiPage=$site->getDefaultPage();}

			$runData->contextAdd("wikiPageName", $wikiPage);
			// get wiki page from the database

			/* TODO: Now check if the code blocks is already in the cache! */
			
			//$mkey = 
			
			$page = DB_PagePeer::instance()->selectByName($site->getSiteId(), $wikiPage);
			
			if($page == null){
				throw new ProcessException("No such page");
			}
			// page exists!!! wooo!!!
			
			$runData->setTemp("page", $page);
			$GLOBALS['page'] = $page;
			
			$source = $page->getSource();
			/* Get code block. */
			
			$regex = ';^\[\[code(\s[^\]]*)?\]\]((?:(?R)|.)*?)\[\[/code\]\](\s|$);msi';
			
			$allMatches = array();
			preg_match_all($regex, $source, $allMatches);
			
			//var_dump($allMatches);
			
			
			$codeblockNo = $pl->getParameterValue('code');
			if(!$codeblockNo) {
				$codeblockNo = 1;
			}
			
			if(count($allMatches) < $codeblockNo ) {
				throw new ProcessException('No valid codeblock found.');
			}
			
			$code = $allMatches[2][$codeblockNo - 1];
			header("Content-Type: text/plain");
			
			return trim($code)."\n";
		}catch(Exception $e){
			$out = $e->getMessage(); 	
			return $out;
		}
	}

}
