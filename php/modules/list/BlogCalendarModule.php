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
 * @version $Id: ListPagesModule.php,v 1.10 2008/05/27 13:27:06 redbeard Exp $
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class BlogCalendarModule extends SmartyModule {
    
	protected $_pl;
	
    public function build($runData) {
        
        $pl = $runData->getParameterList();
        $this->_pl = $pl;
        $site = $runData->getTemp("site");
        
    	$categoryName = $this->_readParameter('category', false);
        if(!$categoryName) {
            $categoryName = $this->_readParameter('categories', false);
        }
        
        $categoryName = strtolower($categoryName);
        
        $startPage = $this->_readParameter('startPage');
       
        $categories = array();
        $categoryNames = array();
        if ($categoryName != '*') {
            if (!$categoryName) {
                /* No category name specified, use the current category! */
                $pageUnixName = $runData->getTemp('pageUnixName');
                if (!$pageUnixName) {
                    $pageUnixName = $pl->getParameterValue('page_unix_name'); // from preview
                }
                if (strpos($pageUnixName, ":") != false) {
                    $tmp0 = explode(':', $pageUnixName);
                    $categoryName = $tmp0[0];
                } else {
                    $categoryName = "_default";
                }
            
            }
            foreach (preg_split('/[,;\s]+?/', $categoryName) as $cn) {
                $category = DB_CategoryPeer::instance()->selectByName($cn, $site->getSiteId());
                if ($category) {
                    $categories[] = $category;
                    $categoryNames[] = $category->getName();
                }
            }
            if (count($categories) == 0) {
                throw new ProcessException('The requested categories do not (yet) exist.');
            }
        }
        //if(count($categories) == 0){
        //	throw new ProcessException(_("The category can not be found."));	
        //}
        


        // now select pages according to the specified criteria
        

        $c = new Criteria();
        $c->add("site_id", $site->getSiteId());
        if (count($categories) > 0) {
            $ccat = new Criteria();
            foreach ($categories as $cat) {
                $ccat->addOr('category_id', $cat->getCategoryId());
            }
            $c->addCriteriaAnd($ccat);
        }
        
        $c->add('unix_name', '(^|:)_', '!~');
        
        /* Handle tags! */
        
        $tagString = $this->_readParameter("tag", true);
        if (!$tagString) {
            $tagString = $this->_readParameter("tags", true);
        }
        
        if ($tagString) {
            /* Split tags. */
            $tags = preg_split(';[\s,\;]+;', $tagString);
            
            $tagsAny = array();
            $tagsAll = array();
            $tagsNone = array();
            
            foreach ($tags as $t) {
                if (substr($t, 0, 1) == '+') {
                    $tagsAll[] = substr($t, 1);
                } elseif (substr($t, 0, 1) == '-') {
                    $tagsNone[] = substr($t, 1);
                } elseif($t == '=') {
                    /* It means: any tags of the current page. */
                    if($runData->getTemp('page')){
                        $pageId = $runData->getTemp('page')->getPageId();
                        $co = new Criteria();
            			$co->add("page_id", $pageId);
            			$co->addOrderAscending("tag");
            			$tagso = DB_PageTagPeer::instance()->select($co);
            			foreach($tagso as $to){
            				$tagsAny[] = $to->getTag();	
            			}
            			if(count($tagsAny) == 0) {
            			    /*
            			     * If someone uses the '=' tag, the line below guarantees that
            			     * only pages that DO have tags and share at least one similar tag with the 
            			     * current page are listed.
            			     */
            			    $tagsAny[] = '   ';
            			}
                    }
                } else {
                    $tagsAny[] = $t;
                }
            }
           
            
            /* ANY */
            if (count($tagsAny) > 0) {
                $t = array();
                foreach ($tagsAny as $tag0) {
                    $t[] = 'tag = \'' . db_escape_string($tag0) . '\'';
                }
                $tagQuery = "SELECT count(*) FROM page_tag " . "WHERE page_tag.page_id=page.page_id " . "AND (" . implode(' OR ', $t) . ")";
                
                $c->add('(' . $tagQuery . ')', 1, '>=');
            }
            /* ALL */
            if (count($tagsAll) > 0) {
                $t = array();
                foreach ($tagsAll as $tag0) {
                    $t[] = 'tag = \'' . db_escape_string($tag0) . '\'';
                }
                $tagQuery = "SELECT count(*) FROM page_tag " . "WHERE page_tag.page_id=page.page_id " . "AND (" . implode(' OR ', $t) . ")";
                
                $c->add('(' . $tagQuery . ')', count($tagsAll));
            }
            /* NONE */
            if (count($tagsNone) > 0) {
                $t = array();
                foreach ($tagsNone as $tag0) {
                    $t[] = 'tag = \'' . db_escape_string($tag0) . '\'';
                }
                $tagQuery = "SELECT count(*) FROM page_tag " . "WHERE page_tag.page_id=page.page_id " . "AND (" . implode(' OR ', $t) . ")";
                
                $c->add('(' . $tagQuery . ')', 0);
            }
        

        }
        $c->addGroupBy('datestring');
        
        $db = Database::connection();
        
        
        $corig = clone($c);
        $c->setExplicitFields("EXTRACT(YEAR FROM date_created)::varchar || '.' || EXTRACT(MONTH FROM date_created)::varchar as datestring, count(*) as c");

        $q = DB_PagePeer::instance()->criteriaToQuery($c);

		$r = $db->query($q);
        $r = $r->fetchAll();
        $postCount = array();
    	if($lang == 'pl') {
        	$locale = 'pl_PL';
       	}
       	setlocale(LC_TIME, $locale);
        foreach($r as $mo) {
        	$spl = explode('.', $mo['datestring']);
        	$year = $spl[0];
        	$month = $spl[1];
        	$postCount[$year]['months'][$month]['count'] = $mo['c'];
        	/* Month names. */
        	$lang = $site->getLanguage();
        	$locale = 'en_US';
			$postCount[$year]['months'][$month]['name'] = strftime('%B', mktime(6,6,6,$month,6,$year));        	
        	
        }
        
        //$c = clone($corig);
        $c->setExplicitFields("EXTRACT(YEAR FROM date_created)::varchar as datestring, count(*) as c");
        $q = DB_PagePeer::instance()->criteriaToQuery($c);
        
		$r = $db->query($q);
        $r = $r->fetchAll();
        foreach($r as $mo){
        	$postCount[$mo['datestring']]['count'] = $mo['c'];
        }
        
        $runData->contextAdd('postCount', $postCount);
        
        $startUrlBase = '/' . $startPage . '/date/';
        $runData->contextAdd('startUrlBase', $startUrlBase);
        //var_dump($postCount);
        
        return;
        
    }

    protected function _readParameter($name, $fromUrl = false){
    	$pl = $this->_pl;
    	$val = $pl->getParameterValue($name, "MODULE", "AMODULE");
    	if($fromUrl && $val == '@URL') {
    		$val = $pl->resolveParameter($name, 'GET');
    	}
    	
    	return $val;
    }
}
