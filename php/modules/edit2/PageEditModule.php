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

class PageEditModule extends SmartyModule {
	
	public function build($runData){
		
		$pl = $runData->getParameterList();
		$site = $runData->getTemp("site");
		
		$pageId = $pl->getParameterValue("page_id");
		
		$mode = $pl->getParameterValue("mode");
		
		$runData->ajaxResponseAdd("mode", $mode);
		
		$user = $runData->getUser();
		
		$userId = $runData->getUserId();
		if($userId == null){
			$userString = $runData->createIpString();	
			$runData->contextAdd("anonymousString", $userString);
		}
		
		$db = Database::connection();
		$db->begin();
		
		if($pageId === null || $pageId===''){
			// means probably creating a new page
			// no context is needed
			$runData->sessionStart();
			$mode = "page";
			$runData->contextAdd("mode", $mode);
			$runData->contextAdd("newPage", true);

			// first create if a page not already exists!
			$unixName = $pl->getParameterValue("wiki_page");
			$unixName = WDStringUtils::toUnixName($unixName); // purify! (for sure)
		
			$page = DB_PagePeer::instance()->selectByName($site->getSiteId(), $unixName);
			if($page != null){
				// page exists!!! error!
				throw new ProcessException(_("The page you want to create already exists. Please refresh the page in your browser to see it."));
			/*	$runData->ajaxResponseAdd("pageExists", true);
				$runData->ajaxResponseAdd("locked", true); //well, it is somehow locked...
				$runData->setModuleTemplate("edit/NewPageExistsWinModule");
				$db->commit();
				return;	*/
			}
			
			// extract category name
			if(strpos($unixName, ':') != false){
				// ok, there is category!	
				$exp = explode(':',$unixName);
				$categoryName = $exp[0];
				$suggestedTitle = ucwords(str_replace("-", " ", $exp[1]));
			} else {
				// no category name, "_default" assumed
				$categoryName = "_default";	
				$suggestedTitle = ucwords(str_replace("-", " ", $unixName));
			}
			
			$category = DB_CategoryPeer::instance()->selectByName($categoryName, $site->getSiteId());
			
			if($category == null){
				// get the default!
				$category = DB_CategoryPeer::instance()->selectByName('_default', $site->getSiteId());
			}
			
			// now check for permissions!!!
			WDPermissionManager::instance()->hasPagePermission('create', $user, $category);

			$lock = new DB_PageEditLock();
			$lock->setPageUnixName($unixName);
			$lock->setSiteId($site->getSiteId());
			$lock->setUserId($runData->getUserId());
			$lock->setUserString($runData->getSession()->getIpAddress());
			
			$lock->setDateStarted(new ODate());
			$lock->setDateLastAccessed(new ODate());
			$lock->setMode("page");
			
			if($pl->getParameterValue("force_lock") != null){
				$lock->deleteConflicts();
			}else{	
				// check for conflicts
				$conflicts = $lock->getConflicts();
				if($conflicts != null){
					$runData->ajaxResponseAdd("locked", true); 
					$runData->setModuleTemplate("edit/NewPageLockedWinModule");	
					$runData->contextAdd("locks", $conflicts);
					return;
				}
			}

			$secret = md5(time().rand(1000,9999));
			$lock->setSecret($secret);
			$lock->setSessionId($runData->getSession()->getSessionId());
			$lock->save();
			$runData->ajaxResponseAdd('lock_id', $lock->getLockId());
			$runData->ajaxResponseAdd('lock_secret', $secret);
			
			// select available templates
			$templatesCategory = DB_CategoryPeer::instance()->selectByName("template", $site->getSiteId());
		
			if($templatesCategory != null){
				$c = new Criteria();
				$c->add("category_id", $templatesCategory->getCategoryId());
				$c->addOrderAscending("title");
				$templates =  DB_PagePeer::instance()->select($c);
				
				$runData->contextAdd("templates", $templates);
				
			}
			
			// check if there is a default template...

			$title = $suggestedTitle;
			
			if($category != null){
				if($category->getTemplateId() != null){
					$runData->contextAdd("templateId", $category->getTemplateId());
					
				}	
			}
			
			$db->commit();
			return;	
		}	
		
		// now if editing an existing page...
		
		$page = DB_PagePeer::instance()->selectByPrimaryKey($pageId);
		if($page == null){
			throw new ProcessException(_("Page does not exist."));
		}
		$unixName = $page->getUnixName();
		$category = $page->getCategory();
		if($category == null){
			throw new ProcessException(_("Internal error - page category does not exist!!!"));	
		}
		
		// now check for permissions!
		
		WDPermissionManager::instance()->hasPagePermission('edit', $user, $category, $page);
		
		// check if mode is sections if page is editable in this mode
		if($mode == "section"){
			$compiledContent = $page->getCompiled()->getText();
			$editable = WDEditUtils::sectionsEditable($compiledContent);
			if($editable == false){
				throw new ProcessException(_("Sections are not editable due to unclear section structure. This sometimes happen when nested headings are used (inside other page elements) or the page include other pages."), "sections_uneditable");
			}	
			// ok, get ranges for edit now.
			$pageSource = $page->getSource();
			$rangeMap = WDEditUtils::sectionMapping($pageSource);
			$sectionId = $pl->getParameterValue("section");
			if(!isset($rangeMap[$sectionId])){
				throw new ProcessException(_("Sections are not editable due to unclear section structure. This sometimes happen when nested headings are used (inside other page elements) or the page include other pages."), "sections_uneditable");
			}
			$rangeStart = $rangeMap[$sectionId]['start'];
			$rangeEnd = $rangeMap[$sectionId]['end'];
			
			$runData->ajaxResponseAdd('section', $sectionId);
			$runData->ajaxResponseAdd('rangeStart', $rangeStart);
			$runData->ajaxResponseAdd('rangeEnd', $rangeEnd);
			
		}

		// if we have not returned yet it means that the lock does not exist or is expired
		// if session is not started - start it!
		$runData->sessionStart();
		// create new page lock
		$lock = new DB_PageEditLock();
		$lock->setPageId($page->getPageId());
		$lock->setPageUnixName($page->getUnixName());
		$lock->setSiteId($site->getSiteId());
		$lock->setUserId($runData->getUserId());
		$lock->setUserString($runData->getSession()->getIpAddress());
		
		$lock->setDateStarted(new ODate());
		$lock->setDateLastAccessed(new ODate());
		$lock->setMode($mode);
		if($mode == "section"){
			$lock->setRangeStart($rangeStart);
			$lock->setRangeEnd($rangeEnd);	
		}
		
		// delete outdated...
		DB_PageEditLockPeer::instance()->deleteOutdated($pageId);
		// check for conflicts
		
		if($pl->getParameterValue("force_lock") != null){
			$lock->deleteConflicts();	
		} else {

			$blocklocks = $lock->getConflicts();
			if($blocklocks != null){
				// conflicting locks exist.	
				$runData->setModuleTemplate("edit/LockExistsWinModule");
				$runData->ajaxResponseAdd("locked", true);
				$runData->contextAdd("locks", $blocklocks);
				return;
			}
		}

		$secret = md5(time().rand(1000,9999));
		$lock->setSecret($secret);
		$lock->setSessionId($runData->getSession()->getSessionId());
		$lock->save();
		
		$runData->ajaxResponseAdd('lock_id', $lock->getLockId());
		$runData->ajaxResponseAdd('lock_secret', $secret);
		// also put current page revision in case one wants to regain lock after expired.
		
		$runData->ajaxResponseAdd('page_revision_id', $page->getRevisionId());
		
		// keep the session - i.e. put an object into session storage not to delete it!!!
		$runData->sessionAdd("keep", true);
		
		if($mode == "page"){
			$source = $page->getSource();
		}
		if($mode == "append"){
			//$runData->contextAdd("source", ""); // source not required...
			$source = '';
		}
		if($mode == "section"){
			// slice the source...
			$sliced = explode("\n",$pageSource);
			$s = array_slice($sliced, $rangeStart, $rangeEnd-$rangeStart+1);
			
			$source = trim(implode("\n", $s));
		}
		$title = $page->getTitle();	
		$runData->contextAdd("pageId", $page->getPageId());	
		
		$runData->contextAdd("mode", $mode);
		
		$runData->ajaxResponseAdd("timeLeft", 15*60);

		/////////////////////////////////////////////
		// HTML editable source
		/////////////////
		$wt = new WikiTransformation();
		$wt->setTransformationFormat('xhtmleditable');
		$wt->setPageUnixName($unixName);
		
		$htmlTemplateFile = WIKIDOT_ROOT.'/templates/layouts/EditableLayout.tpl';
		$smarty = OZONE::getSmartyPlain();
		// get CSS files now
		$theme = $category->getTheme();
		$smarty->assign("theme", $theme);
		$editableHtml = $wt->processSource($source); 
		$smarty->assign('editableHtml', $editableHtml);
		$htmlContent = $smarty->fetch($htmlTemplateFile);
		$runData->ajaxResponseAdd('htmlContent', $htmlContent);
		
		$runData->ajaxResponseAdd('wikiSource', $source);
		
		/////////////////////////////////////////////
		// UI
		/////////////////
		
		// get the toolbar
		
		$smarty = OZONE::getSmartyPlain();
		$toolbarTemplateFile = WIKIDOT_ROOT.'/templates/misc/wikiditor/PageEditToolbar.tpl';
		$toolbar = $smarty->fetch($toolbarTemplateFile);
		$runData->ajaxResponseAdd("toolbar", $toolbar);
		
		// get the content edit area
		$smarty = OZONE::getSmartyPlain();
		$areaTemplateFile = WIKIDOT_ROOT.'/templates/misc/wikiditor/PageEditArea.tpl';
		$smarty->assign("title", $title);
		$area = $smarty->fetch($areaTemplateFile);
		$runData->ajaxResponseAdd("area", $area);

		$db->commit();

	}

}
