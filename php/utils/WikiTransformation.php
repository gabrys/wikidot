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

require_once(WIKIDOT_ROOT."/lib/Text_Wiki/Text/Wiki.php");
// just for text_wiki extend the include_path
ini_set('include_path',ini_get('include_path').':'.WIKIDOT_ROOT.'/lib/Text_Wiki/');
//for SmartyPants

class WikiTransformation {
	/**
     * The array stores all internal links within a page. 
     * Each element is an array (page_id, page_unix_name)
     */
    public static $internalLinksExist;
    public static $internalLinksNotExist;
    public static $inclusions;
    
    private $page; 
    private $pageUnixName;
    
    private $transformationFormat = 'xhtml'; 
    
    public $wiki;

	public function __construct($initialize = true){
		if($initialize){
			self::$internalLinksExist = array();
			self::$internalLinksNotExist = array();
			$this->resetWiki();
		}
	}
	
	public static function purifyHtml($code){
		//$code is not a complete page so we need to wrap it!
		$head = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">  <head>    <title>Just A Wrapper</title><meta http-equiv="content-type" content="text/html;charset=UTF-8"/>  </head> <!--wrapdelimiter--><body>';
  		$tail=' </body><!--wrapdelimiter--></html>';
		
		$c = $head.$code.$tail;
		$config = array('indent' => false,
               'output-xhtml' => TRUE,
               'wrap' => 0);

		$c2 = tidy_parse_string($c, $config, 'UTF8');
			
		$arr = explode("<!--wrapdelimiter-->", $c2);
		$out=$arr[1];
		$out = str_replace("<body>", "", $out);
		$out = str_replace("</body>", "", $out);
		return $out;
	}
	
	public function processSource($source){
		
		$wiki = $this->wiki;
		$out = $wiki->transform($source, $this->transformationFormat);
	
		$out = $this->purifyHtml($out);
		
		return $out;	
	}
	
	public function setPage($page){
		
		$this->wiki->setRenderConf($this->transformationFormat, 'image', 'base', '/local--files/'.$page->getUnixName().'/');
 		$this->wiki->setRenderConf($this->transformationFormat, 'file', 'base', '/local--files/'.$page->getUnixName().'/');
 		$this->wiki->vars['pageName'] = $page->getUnixName();
 		$this->wiki->vars['pageTitle'] = $page->getTitleOrUnixName();
		$this->page = $page;
	}	
	public function setPageUnixName($pageUnixName){
		$this->wiki->setRenderConf($this->transformationFormat, 'image', 'base', '/local--files/'.$pageUnixName.'/');
		$this->wiki->setRenderConf($this->transformationFormat, 'file', 'base', '/local--files/'.$pageUnixName.'/');
		$this->wiki->vars['pageName'] = $pageUnixName;
		$this->pageUnixName = $pageUnixName;
	}	
	
	public function resetWiki(){
		// initialize wiki engine with default values
		$wiki = new Text_Wiki();
		$viewUrl = "/%s";
		$wiki->setRenderConf($this->transformationFormat, 'freelink', 'view_url', $viewUrl);
 		$wiki->setRenderConf($this->transformationFormat, 'freelink', 'new_url', $viewUrl);
 		$wiki->setRenderConf($this->transformationFormat, 'url', 'images', false);
 		
 		$wiki->setRenderConf($this->transformationFormat, 'freelink', 'new_text', '');
 		$wiki->setRenderConf($this->transformationFormat, 'freelink', 'css_new', 'newpage');
		$wiki->setRenderConf($this->transformationFormat, 'table', 'css_table', 'wiki-content-table');
 		
 		$wiki->setRenderConf($this->transformationFormat, 'freelink', 'exists_callback', 'wikiPageExists');
 		
 		$interWikis = array(
		    'wikipedia'    => 'http://en.wikipedia.org/wiki/%s',
		    'wikipedia.pl'    => 'http://pl.wikipedia.org/wiki/%s',
		    'pl.wikipedia'    => 'http://pl.wikipedia.org/wiki/%s',
		    'google'    => 'http://www.google.com/search?q=%s',
		    'dictionary' => 'http://dictionary.reference.com/browse/%s'
		);

		// configure the interwiki rule
		$wiki->setRenderConf($this->transformationFormat, 'interwiki', 'sites', $interWikis);
 		$wiki->setParseConf('interwiki', 'sites', $interWikis);
 		
 		$wiki->disableRule('wikilink');
 		$this->wiki = $wiki;	
		
	}
	
	public function setMode($mode){
		$wiki = $this->wiki;
		switch($mode){
			case 'post':
				// disable a few rules
				$wiki->disableRule("include");
				$wiki->disableRule("modulepre");
				$wiki->disableRule("module");
				$wiki->disableRule("module654");
				$wiki->disableRule("toc");
				$wiki->disableRule("Social");
				$wiki->disableRule("button");
				
				//configure
			
				$wiki->setRenderConf($this->transformationFormat, 'heading', 'use_id', false);
				$wiki->setRenderConf($this->transformationFormat, 'footnote', 'id_prefix', rand(0,1000000).'-');
				$wiki->setRenderConf($this->transformationFormat, 'bibitem', 'id_prefix', rand(0,1000000).'-');
				$wiki->setRenderConf($this->transformationFormat, 'math', 'id_prefix', rand(0,1000000).'-');
				
				$wiki->setRenderConf($this->transformationFormat, 'file', 'no_local', true);
				$wiki->setRenderConf($this->transformationFormat, 'image', 'no_local', true);
				$wiki->setRenderConf($this->transformationFormat, 'gallery', 'no_local', true);
				break;
				
			case 'pm':
				// disable a few rules
				$wiki->disableRule("include");
				$wiki->disableRule("modulepre");
				$wiki->disableRule("module");
				$wiki->disableRule("module654");
				$wiki->disableRule("toc");
				$wiki->disableRule("Social");
				$wiki->disableRule("button");
				
				//configure
			
				$wiki->setRenderConf($this->transformationFormat, 'heading', 'use_id', false);
				$wiki->setRenderConf($this->transformationFormat, 'footnote', 'id_prefix', rand(0,1000000).'-');
				$wiki->setRenderConf($this->transformationFormat, 'bibitem', 'id_prefix', rand(0,1000000).'-');
				$wiki->setRenderConf($this->transformationFormat, 'math', 'id_prefix', rand(0,1000000).'-');
				
				$wiki->setRenderConf($this->transformationFormat, 'file', 'no_local', true);
				$wiki->setRenderConf($this->transformationFormat, 'image', 'no_local', true);
				$wiki->setRenderConf($this->transformationFormat, 'gallery', 'no_local', true);
				break;	
				
			case 'feed':
				// disable a few rules
				$wiki->disableRule("include");
				$wiki->disableRule("modulepre");
				$wiki->disableRule("module");
				$wiki->disableRule("module654");
				$wiki->disableRule("toc");
				
				$wiki->disableRule("footnote");
				$wiki->disableRule("math");
				$wiki->disableRule("equationreference");
				$wiki->disableRule("Footnoteitem");
				$wiki->disableRule("Footnoteblock");
				$wiki->disableRule("Bibitem");
				$wiki->disableRule("Bibliography");
				$wiki->disableRule("Bibcite");
				$wiki->disableRule("Gallery");
				$wiki->disableRule("File");
				$wiki->disableRule("Social");

				// configure
				
				$wiki->setRenderConf($this->transformationFormat, 'heading', 'use_id', false);
				
				$wiki->setRenderConf($this->transformationFormat, 'file', 'no_local', true);
				$wiki->setRenderConf($this->transformationFormat, 'image', 'no_local', true);
				$wiki->setRenderConf($this->transformationFormat, 'image', 'post_vars', true);
				$wiki->setParseConf( 'url', 'post_vars', true);

				break;
				
			case 'awiki':
				break;
			default:
				throw Exception("Invalid wiki engine mode.");	
				break;
		}	
	}
	
	public function setTransformationFormat($format){
		$this->transformationFormat = $format;
		$this->resetWiki();
	}
	
	public function processHtml($doc){
		require_once(WIKIDOT_ROOT."/lib/Text_Antiwiki/Text/Antiwiki.php");
		// just for text_wiki extend the include_path
		ini_set('include_path',ini_get('include_path').':'.WIKIDOT_ROOT.'/lib/Text_Antiwiki/');
		
		// clean the code!!!
		$doc = $this->purifyHtml($doc);
		
		// no extra parameters, just GO GO GO
		$wiki = new Text_Antiwiki();
		$out = $wiki->transform($doc, 'Wiki');
		
		return $out;
		
	}
	
}

// quick checkup if page exists

function wikiPageExists($pageName){
	
	if($GLOBALS['site'] == null){
		$runData = Ozone::getRunData();
		$siteId = $runData->getTemp("site")->getSiteId();
	}else{
		$siteId = $GLOBALS['site']->getSiteId();
	}
	$q = "SELECT page_id FROM page WHERE unix_name='".db_escape_string($pageName)."' AND site_id='".db_escape_string($siteId)."' LIMIT 1";
	$db = Database::connection();
	$r = $db->query($q);
	if($row = $r->nextRow()){
		return $row['page_id'];
	} else {
		return false;
	}	
}
