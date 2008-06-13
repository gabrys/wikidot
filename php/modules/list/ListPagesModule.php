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

class ListPagesModule extends SmartyModule {
    
    public $parameterhash;
      
    protected $processPage = true;
    
    private $_tmpSplitSource;
    private $_tmpSource;
    private $_tmpPage;
    
    private $_vars = array();

    public function render($runData) {
        
        $site = $runData->getTemp("site");
        $pl = $runData->getParameterList();
        $categoryName = $pl->getParameterValue("category", "MODULE", "AMODULE");
        if(!$categoryName) {
            $categoryName = $pl->getParameterValue("categories", "MODULE", "AMODULE");
        }
        
        $categoryName = strtolower($categoryName);
        
        $parmHash = md5(serialize($pl->asArray()));
        $this->parameterhash = $parmHash;
    	/* Check if recursive. */
        foreach($this->_moduleChain as $m){
            if(get_class($m) == 'ListPagesModule'){// && $m->parameterHash == $parmHash){
                return '<div class="error-block">The ListPages module does not work recursively.</div>';
            }
        }

        $valid = true;
        
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
        
        $key = 'listpages_v..' . $site->getUnixName() . '..' . $categoryName . '..' . $parmHash;

        $mc = OZONE::$memcache;
        $struct = $mc->get($key);
        if (!$struct) {
            $valid = false;
        }
        $cacheTimestamp = $struct['timestamp'];
        $now = time();
        
        // now check lc for ALL categories involved
        

        $cats = preg_split('/[,;\s]+?/', $categoryName);
        
        if ($categoryName != '*') {
            foreach ($cats as $cat) {
                
                $tkey = 'pagecategory_lc..' . $site->getUnixName() . '..' . $cat; // last change timestamp
                $changeTimestamp = $mc->get($tkey);
                if ($changeTimestamp && $cacheTimestamp && $changeTimestamp <= $cacheTimestamp) {    //cache valid	
                } else {
                    $valid = false;
                    if (!$changeTimestamp) {
                        // 	put timestamp
                        $mc->set($tkey, $now, 0, 864000);
                        $valid = false;
                    }
                }
            }
        } else {
            $akey = 'pageall_lc..' . $site->getUnixName();
            $allPagesTimestamp = $mc->get($akey);
            if ($allPagesTimestamp && $cacheTimestamp && $allPagesTimestamp <= $cacheTimestamp) {    //cache valid
            } else {
                $valid = false;
                if (!$allPagesTimestamp) {
                    // 	put timestamp
                    $mc->set($akey, $now, 0, 864000);
                    $valid = false;
                }
            }
        }
        
        if ($valid) {
            $this->_vars = $struct['vars'];
            return $struct['content'];
        }
        
        $out = parent::render($runData);
        
        // and store the data now
        $struct = array();
        $now = time();
        $struct['timestamp'] = $now;
        $struct['content'] = $out;
        $struct['vars'] = $this->_vars;
        
        $mc->set($key, $struct, 0, 864000);
        
        return $out;
    
    }

    public function build($runData) {
        
        $pl = $runData->getParameterList();
        $site = $runData->getTemp("site");
        
        $categoryName = $pl->getParameterValue("category", "MODULE", "AMODULE");
        if(!$categoryName) {
            $categoryName = $pl->getParameterValue("categories", "MODULE", "AMODULE");
        }
        
        $categoryName = strtolower($categoryName);
        
        $order = $pl->getParameterValue("order");
        $limit = $pl->getParameterValue("limit");
        $perPage = $pl->getParameterValue("perPage");
        
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
        
        $tagString = $pl->getParameterValue("tag");
        if (!$tagString) {
            $tagString = $pl->getParameterValue("tags");
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
                } else {
                    $tagsAny[] = $t;
                }
            }
            
            /* Create extra conditions to the SELECT */
            
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
        
        /* Handle date ranges. */
        
        $date = $pl->getParameterValue("date");
        
        $dateA = array();
        if (preg_match(';^[0-9]{4};', $date)) {
            $dateA['year'] = $date;
        }
        if (preg_match(';^[0-9]{4}\.[0-9]{1,2};', $date)) {
            $dateS = explode('.', $date);
            $dateA['year'] = $dateS[0];
            $dateA['month'] = $dateS[1];
        }
        
        if (isset($dateA['year'])) {
            $c->add('EXTRACT(YEAR FROM date_created)', $dateA['year']);
        }
        
        if (isset($dateA['month'])) {
            $c->add('EXTRACT(MONTH FROM date_created)', $dateA['month']);
        }
        
        /* Handle pagination. */
        
        if (!$perPage || !preg_match(';^[0-9]+$;', $perPage)) {
            $perPage = 20;
        }
        
        if ($limit && preg_match(';^[0-9]+$;', $limit)) {
            $c->setLimit($limit); // this limit has no effect on count(*) !!!
        } else {
        	$limit = null;
        }
        
        $pageNo = $pl->getParameterValue("p");
        if ($pageNo == null || !preg_match(';^[0-9]+$;', $pageNo)) {
            $pageNo = 1;
        }
        
        $co = DB_PagePeer::instance()->selectCount($c);
        
        if($limit){
        	$co = min(array($co, $limit));
        }

        $totalPages = ceil($co / $perPage);
        if ($pageNo > $totalPages) {
            $pageNo = $totalPages;
        }
        $offset = ($pageNo - 1) * $perPage;
        if($limit){
            $newLimit = min(array($perPage, $limit - $offset));
        } else {
            $newLimit = $perPage;
        }
        $c->setLimit($newLimit, $offset);
        $runData->contextAdd("totalPages", $totalPages);
        $runData->contextAdd("currentPage", $pageNo);
        $runData->contextAdd("count", $co);
        $runData->contextAdd("totalPages", $totalPages);
        
        /* Pager's base url */
        $url = $_SERVER['REQUEST_URI'];
        $url = preg_replace(';(/p/[0-9]+)|$;', '/p/%d', $url, 1);
        $runData->contextAdd("pagerUrl", $url);
        
        switch ($order) {
            
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
        if (!$format) {
            $format = "" . "+ %%linked_title%%\n\n" . _("by") . " %%author%% %%date|%O ago (%e %b %Y, %H:%M %Z)%%\n\n" . "%%short%%";
        }
        
        //$wt = new WikiTransformation();
        //$wt->setMode("feed");
        //$template = $wt->processSource($format);
        

        //$template = preg_replace('/<p\s*>\s*(%%((?:short)|(?:description)|(?:summary)|(?:content)|(?:long)|(?:body)|(?:text))%%)\s*<\/\s*p>/smi', 
        //			"<div>\\1</div>", $template);
        

        //$template = $format;
        $items = array();
        
        $separation = $pl->getParameterValue("separate", "MODULE", "AMODULE");
        if ($separation == 'no' || $separation == 'false') {
            $separation = false;
        } else {
            $separation = true;
        }
        
        foreach ($pages as $page) {
            $this->_tmpPage = $page;
            $title = $page->getTitle();
            $source = $page->getSource();
            
            $title = str_replace(array('[',']'), '', $title);
            $title = str_replace('%%', "\xFD", $title);
            
            $source = str_replace('%%', "\xFD", $source);
            
            $c = new Criteria();
            $c->add('revision_id', $page->getRevisionId());
            $lastRevision = DB_PageRevisionPeer::instance()->selectOne($c);
            
            //$c = new Criteria();
            //$c->add('page_id', $page->getPageId());
            //$c->addOrderAscending('revision_id');
            //$firstRevision = DB_PageRevisionPeer::instance()->selectOne($c);
            $b = $format;
            
            /* A series of substitutions. */
            
            $b = str_replace("\xFD", '', $b);
            
            /* %%title%% and similar */
            
            $b = str_replace('%%title%%', $title, $b);
            $b = preg_replace("/%%((linked_title)|(title_linked))%%/i", preg_quote_replacement('[[[' . $page->getUnixName() . ' | ' . $title . ']]]'), $b);
            
            /* %%author%% */
            
            if($page->getOwnerUserId()){
	            $user = DB_OzoneUserPeer::instance()->selectByPrimaryKey($page->getOwnerUserId());
	            if ($user->getUserId() > 0) {
	                $userString = '[[*user ' . $user->getNickName() . ']]';
	            } else {
	                $userString = _('Anonymous user');
	            }
            } else {
                $userString = _('Anonymous user');
            }
            $b = str_ireplace("%%author%%", $userString, $b);
            $b = str_ireplace("%%user%%", $userString, $b);
            
            if($lastRevision->getUserId()){
	            $user = DB_OzoneUserPeer::instance()->selectByPrimaryKey($lastRevision->getUserId());
	            if ($user->getUserId() > 0) {
	                $userString = '[[*user ' . $user->getNickName() . ']]';
	            } else {
	                $userString = _('Anonymous user');
	            }
            } else {
                $userString = _('Anonymous user');
            }
            $b = str_ireplace("%%author_edited%%", $userString, $b);
            $b = str_ireplace("%%user_edited%%", $userString, $b);
            
            
            /* %%date%% */
            
            $b = preg_replace(';%%date(\|.*?)?%%;', '%%date|' . $page->getDateCreated()->getTimestamp() . '\\1%%', $b);
            $b = preg_replace(';%%date_edited(\|.*?)?%%;', '%%date|' . $page->getDateLastEdited()->getTimestamp() . '\\1%%', $b);
            
            /* %%content%% */
            
            $b = preg_replace(';%%((body)|(text)|(long)|(content))%%;i', $source, $b);
            
            /* %%content{n}%% */
            
            /* Split the content first. */
            $this->_tmpSplitSource = preg_split('/^([=]{4,})$/m', $source);
            $this->_tmpSource = $source;
            $b = preg_replace_callback(';%%content{([0-9]+)}%%;', array(
                $this, 
                '_handleContentSubstitution'), $b);
            
            /* %%short%% */
            
            $b = preg_replace_callback("/%%((description)|(short)|(summary))%%/i", array(
                $this, 
                '_handleSummary'), $b);
                
            $b = preg_replace_callback("/%%first_paragraph%%/i", array(
                $this, 
                '_handleFirstParagraph'), $b);
            
            /* %%page_unix_name%% */
            $b = str_ireplace('%%page_unix_name%%', $page->getUnixName(), $b);
            
            /* %%link%% */
            $b = str_ireplace('%%link%%', 'http://' . $site->getDomain().'/'.$page->getUnixName(), $b);
            
            /* %%tags%% */
            $b = preg_replace_callback("/%%tags%%/i", array(
                $this, '_handleTags'), $b);
            
            $b = str_replace("\xFD", '%%', $b);
            
            if ($separation) {
                $wt = new WikiTransformation();
                $wt->setMode("list");
                $wt->setPage($page);
                $b = $wt->processSource($b);
                $b = "<div class=\"list-pages-item\"\n" . $b . "</div>";
                //$b = "[[div class=\"list-pages-item\"]]\n".$b."\n[[/div]]";
            }
            

            $items[] = trim($b);
        }
        if (!$separation) {
            $prependLine = $pl->getParameterValue('prependLine', 'MODULE', 'AMODULE');
            $appendLine = $pl->getParameterValue('appendLine', 'MODULE', 'AMODULE');
            $wt = new WikiTransformation();
            $wt->setMode("list");
            $glue = "\n";
            $itemsContent = $wt->processSource(($prependLine ? ($prependLine . "\n") : ''). implode($glue, $items) . ($appendLine ? ("\n". $appendLine) : ''));
            
        } else {
            $itemsContent = implode("\n", $items);
        }
        /*
		 * If separation is false, we are not separating the items with double-newlines but rather
		 * with a single newline. This allows to create e.g. list of pages by creating a template:
		 * * %%linked_title%%
		 */
        
        /* Fix dates. */
        //$dateString = '<span class="odate">'.$thread->getDateStarted()->getTimestamp().'|%e %b %Y, %H:%M %Z|agohover</span>';
        $itemsContent = preg_replace_callback(';%%date\|([0-9]+)(\|.*?)?%%;', array(
            $this, '_formatDate'), $itemsContent);
        
        $runData->contextAdd("items", $items);
        $runData->contextAdd("itemsContent", $itemsContent);
        $runData->contextAdd("details", $details);
        $runData->contextAdd("preview", $preview);
        
        /* Also build an URL for the feed. */
        
        $url = 'http://' . $site->getDomain() . '/feed/pages';
        if (count($categoryNames) > 0) {
            $url .= '/category/' . urlencode(implode(',', $categoryNames));
        }
        if (isset($tags)) {
            $url .= '/tags/' . urlencode(implode(',', $tags));
        }
        if (isset($date)) {
            $url .= '/date/' . urlencode($date);
        }
        
        if ($order) {
            $url .= '/order/' . urlencode($order);
        }
        
        $erss = $pl->getParameterValue('rssEmbed');
        if ($erss == 'no' || $erss == 'false') {
            $erss = false;
        } else {
            $erss = true;
        }
        $srss = $pl->getParameterValue('rssShow');
        if ($srss == 'no' || $srss == 'false') {
            $srss = false;
        } else {
            $srss = true;
        }
        
        $trss = $pl->getParameterValue('rssTitle');
        if ($trss) {
            $url .= '/t/' . urlencode($trss);
        }
        if ($erss) {
            $this->_vars['rssUrl'] = $url;
            $this->_vars['rssTitle'] = $trss;
        }
        if ($srss) {
            $runData->contextAdd('rssUrl', $url);
            $runData->contextAdd('rssTitle', $trss);
        }
    }

    private function _formatDate($m) {
        if (isset($m[2])) {
            $format = $m[2];
        } else {
            $format = '|%e %b %Y, %H:%M %Z|agohover';
        }
        $dateString = '<span class="odate">' . $m[1] . $format . '</span>';
        return $dateString;
    }

    private function _handleContentSubstitution($m) {
        $n = $m[1] - 1;
        
        if (isset($this->_tmpSplitSource[$n])) {
            return trim($this->_tmpSplitSource[$n]);
        } else {
            return '';
        }
    
    }

    private function _handleSummary($m) {
        if (isset($this->_tmpSplitSource[0]) && count($this->_tmpSplitSource) > 1) {
            return trim($this->_tmpSplitSource[0]);
        } else {
            /* Try to extract the short version. */
            $s = $this->_tmpSource;
             /* Strip some blocks first. */
            $s = trim(preg_replace('/^(\+{1,6}) (.*)/m', '', $s));
            $s = trim(preg_replace('/^\[\[toc(\s[^\]]+)?\]\]/', '', $s));
            $s = trim(preg_replace('/^\[\[\/?div(\s[^\]]+)?\]\]/', '', $s));
            $s = trim(preg_replace('/^\[\[\/?module(\s[^\]]+)?\]\]/', '', $s));
            /* 1. Try the first paragraph. */
            $m1 = array();
            preg_match(";(^.*?)\n\n;", $s, $m1);
            if (isset($m1[1])) {
                $p = $m1[1];
                return trim($p);
            } else {
                return trim($s);
            }
        }
    
    }
    
     private function _handleFirstParagraph($m) {
        /* Try to extract the short version. */
        $s = $this->_tmpSource;
        /* Strip some blocks first. */
        $s = trim(preg_replace('/^(\+{1,6}) (.*)/m', '', $s));
        $s = trim(preg_replace('/^\[\[toc(\s[^\]]+)?\]\]/', '', $s));
        $s = trim(preg_replace('/^\[\[\/?div(\s[^\]]+)?\]\]/', '', $s));
        $s = trim(preg_replace('/^\[\[\/?module(\s[^\]]+)?\]\]/', '', $s));
        
        /* 1. Try the first paragraph. */
        $m1 = array();
        preg_match(";(^.*?)\n\n;", $s, $m1);
        if (isset($m1[1])) {
            $p = $m1[1];
            return trim($p);
        } else {
            return trim($s);
        }
    }

    private function _handleTags($m) {
        $page = $this->_tmpPage;
        /* Select tags. */
        // get the tags
        $c = new Criteria();
        $c->add("page_id", $page->getPageId());
        $c->addOrderAscending("tag");
        $tags = DB_PageTagPeer::instance()->select($c);
        $t2 = array();
        foreach ($tags as $t) {
            $t2[] = $t->getTag();
        }
        if(count($t2) == 0) {
            return _('//no tags found for this page//');
        }
        return implode(' ', $t2);
    }

    public function processPage($out, $runData) {
        $pl = $runData->getParameterList();
        $pl->getParameterValue('t');
        if ($this->_vars['rssUrl']) {
            $rssTitle = $this->_vars['rssTitle'];
            if (!$rssTitle) {
                $rssTitle = _('Page RSS Feed');
            }
            $out = preg_replace("/<\/head>/", '<link rel="alternate" type="application/rss+xml" title="' . preg_quote_replacement(htmlspecialchars($rssTitle)) . '" href="' . $this->_vars['rssUrl'] . '"/></head>', $out, 1);
        }
        return $out;
    
    }

}
