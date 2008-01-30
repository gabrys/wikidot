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

ini_set('include_path',ini_get('include_path').':'.WIKIDOT_ROOT.'/lib/Text_Diff/');
require_once (WIKIDOT_ROOT.'/lib/Text_Diff/Text/Diff.php');
require_once (WIKIDOT_ROOT.'/lib/Text_Diff/Text/Diff/Renderer.php');
require_once (WIKIDOT_ROOT.'/lib/Text_Diff/Text/Diff/Renderer/inline.php');

class PageEditDiffModule extends SmartyModule {
	
	public function build($runData){
		$pl = $runData->getParameterList();
		$toPageSource = $pl->getParameterValue("source");
		$mode = $pl->getParameterValue("mode");
		$revisionId = $pl->getParameterValue("revision_id");
		
		$revision = DB_PageRevisionPeer::instance()->selectByPrimaryKey($revisionId);
		$fromPageSource = $revision->getSourceText();
		
		if($mode == "section"){
			// compare only a fragment...
			$rangeStart = $pl->getParameterValue("range_start");
			$rangeEnd = $pl->getParameterValue("range_end");
			
			$s2 = explode("\n", $fromPageSource);
			$fromPageSource = implode("\n", array_slice($s2, $rangeStart, $rangeEnd-$rangeStart+1));	
		}

		// create page diff... wooo...
		
		$t1 = $fromPageSource;
		$t2 = $toPageSource;

		$diff = new Text_Diff(explode("\n",$t1), explode("\n",$t2));
		
		$show = $runData->getParameterList()->getParameterValue('show_type');
		
		$renderer = new Text_Diff_Renderer_inline();
		$inlineDiff = $renderer->render( $diff );
		$runData->contextAdd("diff", $inlineDiff	);

	}
	
}
