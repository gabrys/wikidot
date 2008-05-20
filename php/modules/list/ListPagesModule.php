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

class ListPagesModule extends SmartyModule {
	
    private $_tmpSplitSource;
    private $_tmpSource;
    
    private $_vars = array();
	
    public function render($runData){
		$site = $runData->getTemp("site");
		$pl = $runData->getParameterList();
		$categoryName = $pl->getParameterValue("category", "MODULE", "AMODULE");
		$parmHash = md5(serialize($pl->asArray()));
		
		$key = 'listpages_v..'.$site->getUnixName().'..'.$categoryName.'..'.$parmHash;
		
		$valid = true;
		
		$mc = OZONE::$memcache;
		$struct = $mc->get($key);
		if(!$struct){
			$valid = false;
		}
		$cacheTimestamp = $struct['timestamp'];
		$now = time();
		
		// now check lc for ALL categories involved
		$cats = preg_split('/[,;\s]+?/', $categoryName);
		
        foreach($cats as $cat){
		
			$tkey = 'pagecategory_lc..'.$site->getUnixName().'..'.$cat; // last change timestamp
			$changeTimestamp = $mc->get($tkey);
			if($changeTimestamp && $cacheTimestamp && $changeTimestamp <= $cacheTimestamp){
				//cache valid	
			}else{
				$valid = false;
				if(!$changeTimestamp){
					// 	put timestamp
					$mc->set($tkey, $now, 0, 864000);
					$valid = false;
				}	
			}
		}
		
        if($valid){
			$this->vars = $struct['vars'];
			return $struct['content'];	
		}
		
		$out = parent::render($runData);
		
		// and store the data now
		$struct = array();
		$now = time();
		$struct['timestamp'] = $now;
		$struct['content'] = $out;
		$struct['vars']=$this->vars;	
		
		$mc->set($key, $struct, 0, 864000);
		
		return $out; 
		
    }
    
	public function build($runData){
		
		$pl = $runData->getParameterList();
		$site = $runData->getTemp("site");
		
		$categoryName = $pl->getParameterValue("category", "MODULE", "AMODULE");

		$order = $pl->getParameterValue("order");
		$limit = $pl->getParameterValue("limit");
		$perPage = $pl->getParameterValue("perPage");
		
		$categories = array();
		$categoryNames = array();
		
		foreach(preg_split('/[,;\s]+?/', $categoryName) as $cn) {
		    $category = DB_CategoryPeer::instance()->selectByName($cn, $site->getSiteId());
		    if($category) {
		        $categories[] = $category;
		        $categoryNames[] = $category->getName();
		    }
		}	
		//if(count($categories) == 0){
		//	throw new ProcessException(_("The category can not be found."));	
		//}
	
		
		// now select pages according to the specified criteria
		
		$c = new Criteria();
		$c->add("site_id", $site->getSiteId());
		if(count($categories) > 0){
		    $ccat = new Criteria();
		    foreach($categories as $cat) {
		        $ccat->addOr('category_id', $cat->getCategoryId());
		    }
		    $c->addCriteriaAnd($ccat);
		}
		
		$c->add('unix_name', '(^|:)_', '!~');
		
		/* Handle tags! */
		
		$tagString = $pl->getParameterValue("tag");
		if(!$tagString) {
		    $tagString = $pl->getParameterValue("tags");
		}
		
		if($tagString) {
    		/* Split tags. */
    		$tags = preg_split(';[\s,\;]+;', $tagString);
    		
    		/* Create an extra condition to the SELECT */
    		
    		$tagMode = $pl->getParameterValue("tagMode");
    		if(!$tagMode){
    		    $tagMode = 'any';
    		}
    		$t = array();
    		foreach($tags as $tag0) {
    		    $t[] = 'tag = \''.db_escape_string($tag0).'\'';
    		}
    		$tagQuery = "SELECT count(*) FROM page_tag "
    		    ."WHERE page_tag.page_id=page.page_id "
    		    ."AND (".implode(' OR ', $t).")";
    		
    		if($tagMode == 'all'){
        		$c->add('('.$tagQuery.')', count($tags), '>='); ;
    		} else if($tagMode == 'none') {
    		    $c->add('('.$tagQuery.')', 0, '=');
    		} else {
    		    $c->add('('.$tagQuery.')', 1, '>=');
    		}
    		
    		/* Add this to the query. */
    		
    		
		}
		
		/* Handle date ranges. */
		
		$date = $pl->getParameterValue("date");
		
		$dateA = array();
		if(preg_match(';^[0-9]{4};', $date)){
		    $dateA['year'] = $date;
		}
	    if(preg_match(';^[0-9]{4}\.[0-9]{1,2};', $date)){
	        $dateS = explode('.', $date);
		    $dateA['year'] = $dateS[0];
		    $dateA['month'] = $dateS[1];
		}
		
		if(isset($dateA['year'])){
		    $c->add('EXTRACT(YEAR FROM date_created)', $dateA['year']);
		}
		
	    if(isset($dateA['month'])){
		    $c->add('EXTRACT(MONTH FROM date_created)', $dateA['month']);
		}
		
		/* Handle pagination. */
		
		if(!$perPage || !preg_match(';^[0-9]+$;', $perPage) ){
		    $perPage = 20;
		}
		
		if($limit && preg_match(';^[0-9]+$;', $perPage)){
			$c->setLimit($limit);	
		}
		
	    $pageNo = $pl->getParameterValue("p");
		if($pageNo == null || !preg_match(';^[0-9]+$;', $pageNo)){
			$pageNo = 1;	
		}
		
		$co = DB_PagePeer::instance()->selectCount($c);
		
		$totalPages = ceil($co/$perPage);
		if($pageNo>$totalPages){$pageNo = $totalPages;}
		$offset = ($pageNo-1) * $perPage;
		
		$c->setLimit($perPage, $offset); 
		$runData->contextAdd("totalPages", $totalPages);
		$runData->contextAdd("currentPage", $pageNo);
		$runData->contextAdd("count", $co);
		$runData->contextAdd("totalPages", $totalPages);
		
		/* Pager's base url */
		$url = $_SERVER['REQUEST_URI'];
		$url = preg_replace(';(/p/[0-9]+)|$;', '/p/%d', $url, 1);
		$runData->contextAdd("pagerUrl", $url);

	    switch($order){
			
			case 'dateCreatedAsc':
				$c->addOrderAscending('page_id');
				break;
			case 'dateEditedDesc':
				$c->addOrderDescending('date_last_edited');
				break;
			case 'dateEditedAsc':
				$c->addOrderAscending('date_last_edited');
				break;
			case 'titleDesc':
				$c->addOrderDescending("COALESCE(title, unix_name)");
				break;
			case 'titleAsc':
				$c->addOrderAscending("COALESCE(title, unix_name)");
				break;
			default:
			case 'dateCreatedDesc':
				$c->addOrderDescending('page_id');
				break;
		}
		
		$pages = DB_PagePeer::instance()->select($c);
		
		/* Process... */
	    $format = $pl->getParameterValue("module_body");
	    if(!$format){
			$format = "" .
					"+ %%linked_title%%\n\n" .
					_("by")." %%author%% %%date|%O ago (%e %b %Y, %H:%M %Z)%%\n\n" .
					"%%content%%\n\n%%comments%%";	
		}
		
		//$wt = new WikiTransformation();
		//$wt->setMode("feed");
		//$template = $wt->processSource($format);
		
		//$template = preg_replace('/<p\s*>\s*(%%((?:short)|(?:description)|(?:summary)|(?:content)|(?:long)|(?:body)|(?:text))%%)\s*<\/\s*p>/smi', 
		//			"<div>\\1</div>", $template);

		//$template = $format;
		$items = array();
		
		$separation = $pl->getParameterValue("separate", "MODULE", "AMODULE");
	    if($separation == 'no' || $separation == 'false') {
		    $separation = false;
		} else {
		    $separation = true;
		}
		
		foreach($pages as $page) {
		    $title = $page->getTitle();
		    $source = $page->getSource();
		    //$c = new Criteria();
		    //$c->add('page_id', $page->getPageId());
		    //$c->addOrderAscending('revision_id');
		    //$firstRevision = DB_PageRevisionPeer::instance()->selectOne($c);
		    $b = $format;
		    
		    /* A series of substitutions. */
		    
		    /* %%title%% and similar */
		    
		    $b = str_replace('%%title%%', $title, $b);
		    $b = preg_replace("/%%((linked_title)|(title_linked))%%/i", preg_quote_replacement('[[['.$page->getUnixName(). ' | '.$page->getTitle() .']]]'), $b);
			
		    /* %%author%% */
		    
		    $user = DB_OzoneUserPeer::instance()->selectByPrimaryKey($page->getOwnerUserId());
			if($user->getUserId() > 0){
			    $userString = '[[*user '.$user->getNickName().']]';
			} else {
			    $userString = 'Anonymous user';
			} 
		    $b = str_ireplace("%%author%%", $userString, $b);
		    
		    /* %%date%% */
		    
			$b = preg_replace(';%%date(\|.*?)?%%;', '%%date|'. $page->getDateCreated()->getTimestamp().'\\1%%', $b);
		    
			/* %%content%% */
			
			$b = preg_replace(';%%((body)|(text)|(long)|(content))%%;i', $source, $b);
			
			/* %%content{n}%% */
			
			/* Split the content first. */
			$this->_tmpSplitSource = preg_split('/^([=]{4,})$/m', $source);
			$this->_tmpSource = $source;
			$b = preg_replace_callback(';%%content{([0-9]+)}%%;', array($this, '_handleContentSubstitution'), $b);
			
			/* %%short%% */
			
			$b = preg_replace_callback("/%%((description)|(short)|(summary))%%/i", array($this, '_handleSummary'), $b);
			
			/* %%page_unix_name%% */
			$b = str_ireplace('%%page_unix_name%%', $page->getUnixName(), $b);
			if($separation) {
		        $b = "[[div class=\"list-pages-item\"]]\n".$b."\n[[/div]]";
			}
		    $items[] = trim($b);
		}
		$wt = new WikiTransformation();
		$wt->setMode("feed");
		$glue = $separation ? "\n\n" : "\n";
		$itemsContent = $wt->processSource(implode($glue, $items));
		
		/*
		 * If separation is false, we are not separating the items with double-newlines but rather
		 * with a single newline. This allows to create e.g. list of pages by creating a template:
		 * * %%linked_title%%
		 */
		
		/* Fix dates. */
		//$dateString = '<span class="odate">'.$thread->getDateStarted()->getTimestamp().'|%e %b %Y, %H:%M %Z|agohover</span>';
		$itemsContent = preg_replace_callback(';%%date\|([0-9]+)(\|.*?)?%%;', array($this, '_formatDate'), $itemsContent);
		
		$runData->contextAdd("items", $items);
		$runData->contextAdd("itemsContent", $itemsContent);
		$runData->contextAdd("details", $details);
		$runData->contextAdd("preview", $preview);
		
		/* Also build an URL for the feed. */
		
		$url = 'http://'.$site->getDomain().'/feed/pages';
		$url .= '/category/' . implode(',', $categoryNames);
		if(isset($tags)) {
		    $url .= '/tags/' . implode(',', $tags);
		    if($tagMode != 'any') {
		        $url .= '/tagMode/' . $tagMode;
		    }
		}
		if(isset($date)){
		    $url .= '/date/' . $date;
		}
		
		if($order){
		    $url .= '/order/'.urlencode($order);
		}
		
		$erss = $pl->getParameterValue('embedRss');
		if($erss == 'no' || $grss == 'false') {
		    $erss = false;
		} else {
		    $erss = true;
		}
	    $srss = $pl->getParameterValue('showRss');
		if($srss == 'no' || $grss == 'false') {
		    $srss = false;
		} else {
		    $srss = true;
		}
		
		$trss = $pl->getParameterValue('rssTitle');
		if($trss) {
		    $url .= '/t/'.urlencode($trss);
		}
		if($erss) {
		    $this->_vars['rssUrl'] = $url;
		}
		if($srss) {
		    $runData->contextAdd('rssUrl', $url);
		    $runData->contextAdd('rssTitle', $trss);
		}
	}
	
	private function _formatDate($m) {
	    if(isset($m[2])){
	        $format = $m[2];
	    } else {
	        $format = '|%e %b %Y, %H:%M %Z|agohover';
	    }
	    $dateString = '<span class="odate">'.$m[1].$format.'</span>';
	    return $dateString;
	}
	
	private function _handleContentSubstitution($m){
	    $n = $m[1]-1;
	    
	    if(isset($this->_tmpSplitSource[$n])) {
	        return $this->_tmpSplitSource[$n];
	    } else {
	        return '';
	    }
	    
	}
	
    private function _handleSummary($m){
	    if(isset($this->_tmpSplitSource[0]) && count($this->_tmpSplitSource[0]) > 1) {
	        return $this->_tmpSplitSource[0];
	    } else {
	        /* Try to extract the short version. */
	        $s = $this->_tmpSource;
	        /* 1. Try the first paragraph. */
	        $m1 = array();
	        preg_match(";(^.*?)\n\n;", $s, $m1);
	        if(isset($m1[1])){
	            $p = $m1[1];
	            return $p;
	        } else {
	            return $s;
	        }
	    }
	    
	}
	
}
