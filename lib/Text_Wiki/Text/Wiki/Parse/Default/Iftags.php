<?php
/**
 * @category Text
 * 
 * @package Text_Wiki
 * 
 * @author Michal Frackowiak
 * 
 * @license LGPL
 * 
 * @version $Id$
 * 
 */

/**
 * 
 * Creates a conditional, tag-based block.
 *
 * @category Text
 * 
 * @package Text_Wiki
 * 
 * @author Michal Frackowiak
 * 
 */
class Text_Wiki_Parse_Iftags extends Text_Wiki_Parse {


	public $regex = ';\[\[iftags(\s[^\]]*)?\]\]((?:(?R)|.)*?)\[\[/iftags\]\](\s);msi';

	
    /**
    * 
    * Generates a token entry for the matched text.  Token options are:
    * 
    * 'text' => The full matched text, not including the <code></code> tags.
    * 
    * @access public
    *
    * @param array &$matches The array of matches from parse().
    *
    * @return A delimited token number to be used as a placeholder in
    * the source text.
    *
    */
    
    function process(&$matches)
    {
    	$page = $this->wiki->vars['page'];
    	if(!$page){
    		$pageName = $this->wiki->vars['pageName'];
	    	$site = $GLOBALS['site'];
	    	$page = DB_PagePeer::instance()->selectByName($site->getSiteId(), $pageName);
    	}
    	if(!$page) {
    		return;
    	}
    	$tags0 = preg_split(';[, ]+;', trim($matches[1]));
    	$tag0 = $tags0[0];	
    	$tags = $page->getTagsAsArray();
    	if(in_array($tag0, $tags)){
    		return $matches[2];
    	} else {
    		return '';
    	}
    }

}
