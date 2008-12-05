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
 * @package Wikidot_Web
 * @version $Id: lucene_search.php,v 1.1 2008/12/04 12:16:45 redbeard Exp $
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

require_once ("../php/setup.php");

$index = new Zend_Search_Lucene(GlobalProperties::$SEARCH_LUCENE_INDEX);

Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_Utf8Num_CaseInsensitive());

$hits = $index->find($argv[1]);

$i = 0;

foreach ($hits as $hit) {
	if (++$i == 10) {
		return;
	}
	$page = DB_PagePeer::instance()->selectByPrimaryKey($hit->page_id);
	
	echo "score: ";
	printf("%0.4f", $hit->score);
	echo "\tpage_name: " . $page->getUnixName() . "\n";
}

