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

class Wikidot_Search_Lucene {
	
	protected $indexFile;
	protected $index;
	protected $queueFile;
	protected $processedFtsEntries = array();
	
	public function __construct($indexFile = null, $queueFile = null) {
		if ($indexFile) {
			$this->indexFile = $indexFile;
		} else {
			$this->indexFile = GlobalProperties::$SEARCH_LUCENE_INDEX;
		}
		
		if ($queueFile) {
			$this->queueFile = $queueFile;
		} else {
			$this->queueFile = GlobalProperties::$SEARCH_LUCENE_QUEUE;
		}
		
		try {
			$this->index = Zend_Search_Lucene::open($this->indexFile);
		} catch (Zend_Search_Lucene_Exception $e) {
			$this->createIndex();
		}
		
		Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_Utf8Num_CaseInsensitive());
	}
	
	protected function createIndex() {
		$this->index = Zend_Search_Lucene::create($this->indexFile, true);
	}
	
	protected function resetQueue() {
		file_put_contents($this->queueFile, "");
	}
	
	protected function queue($type, $id) {
		$fp = fopen($this->queueFile, "a");
		
		if (! in_array($type, array("INDEX_FTS", "INDEX_SITE", "DELETE_PAGE", "DELETE_THREAD", "DELETE_SITE"))) {
			$type = "UNKNOWN";
		}
		$id = (int) $id;
		
		fwrite($fp, "$type $id\n");
		fclose($fp);
	}
	
	protected function deleteItems($query) {
		foreach ($this->index->find($query) as $hit) {
			$this->index->delete($hit->id);
		}
	}
	
	protected function addFtsEntry($fts, $site = null) {
		if ($fts) {
			if (in_array($fts->getFtsId(), $this->processedFtsEntries)) {
				return;
			}
			
			$this->processedFtsEntries[] = $fts->getFtsId();
			
			if (! $site) {
				$site = DB_SitePeer::instance()->selectByPrimaryKey($fts->getSiteId());
			}
			
			if (! $site || $site->getDeleted() || ! $site->getVisible()) {
				return;
			}
			
			// delete it first
			$this->deleteItems("fts_id:" . $fts->getFtsId());
			
			// construct the document
			$doc = new Zend_Search_Lucene_Document();
			
			// add content, site_id, site_public, fts_id fields
			$doc->addField(Zend_Search_Lucene_Field::unStored("content", $fts->getText()));
			$doc->addField(Zend_Search_Lucene_Field::text("site_id", $fts->getSiteId()));
			$doc->addField(Zend_Search_Lucene_Field::text("site_public", $site->getPrivate() ? "false" : "true"));
			$doc->addField(Zend_Search_Lucene_Field::text("fts_id", $fts->getFtsId()));
			
			// TITLE
			$title_field = Zend_Search_Lucene_Field::text("title", $fts->getTitle());
			$title_field->boost = 7;
			$doc->addField($title_field);
			
			if ($fts->getPageId()) {
				
				// delete also by page_id (this shouldn't delete anything more)
				$this->deleteItems("page_id:" . $fts->getPageId());
				
				$doc->addField(Zend_Search_Lucene_Field::text("item_type", "page"));
				$doc->addField(Zend_Search_Lucene_Field::text("page_id", $fts->getPageId()));
				
				// TAGS
				if ($page = DB_PagePeer::instance()->selectByPrimaryKey($fts->getPageId())) {
					
					$tags = $page->getTagsAsArray();
					$tags_field = Zend_Search_Lucene_Field::text("tags", implode(" ", $tags));
					$tags_field->boost = 4 * count($tags);
					$doc->addField($tags_field);
					
				}
				
			} elseif ($fts->getThreadId()) {
				
				// delete also by thread_id (this shouldn't delete anything more)
				$this->deleteItems("thread_id:" . $fts->getThreadId());
				
				$doc->addField(Zend_Search_Lucene_Field::keyword("item_type", "thread"));
				$doc->addField(Zend_Search_Lucene_Field::keyword("thread_id", $fts->getThreadId()));
				
			} else {
				
				// NEITHER A PAGE NOR THREAD
				return;
				
			}
			
			$this->index->addDocument($doc);
		}
	}
	
	protected function indexSite($site) {
		
		if ($site) {
		
			$atOnce = 5;
			$offset = 0;
			
			$c = new Criteria();
			$c->add("site_id", $site->getSiteId());
			$c->setLimit($atOnce, $offset);
			
			$pp = DB_FtsEntryPeer::instance();
			 
			do {
				$entries = $pp->selectByCriteria($c);
				
				foreach ($entries as $fts) {
					$this->addFtsEntry($fts, $site);
				}

				$offset += $atOnce;
				$c->setLimit($atOnce, $offset);
				
			} while (count($entries));
		}
	}
	
	public function processQueue() {
		
		$q = file($this->queueFile);
		$this->resetQueue();
		
		foreach ($q as $msg) {
			$m = explode(" ", $msg);
			$type = $m[0];
			$id = $m[1];
			
			if ($type == "INDEX_FTS") {
				
				$fts = DB_FtsEntryPeer::instance()->selectByPrimaryKey($id);
				$this->addFtsEntry($fts);
				
			} elseif ($type == "INDEX_SITE") {
				
				$this->indexSite(DB_SitePeer::instance()->selectByPrimaryKey($id));
				
			} elseif ($type == "DELETE_PAGE") {
				
				$this->deleteItems("page_id:$id");
				
			} elseif ($type == "DELETE_THREAD") {
				
				$this->deleteItems("thread_id:$id");
				
			} elseif ($type == "DELETE_SITE") {
				
				$this->deleteItems("site_id:$id");
				
			}
		}
		
		$this->index->commit();
	}
	
	public function queueFtsEntry($fts_id) {
		$this->queue("INDEX_FTS", $fts_id);
	}
	
	public function queueDeletePage($page_id) {
		$this->queue("DELETE_PAGE", $page_id);
	}
	
	public function queueDeleteThread($thread_id) {
		$this->queue("DELETE_THREAD", $thread_id);
	}
	
	public function queueReIndexSite($site_id) {
		$this->queue("DELETE_SITE", $site_id);
		$this->queue("INDEX_SITE", $site_id);
	}

	// queries the index and returns the array of Fts entries
	public function query($query) {
		$cache = Ozone::$memcache;
		$key = "search..$query";
		
		if ($cache && $result = $cache->get($key)) {
			return $result;
		}
		
		$result = array();
		foreach ($this->index->find($query) as $hit) {
			$result[] = array(
				"fts_id" => $hit->fts_id,
			);
		}
		
		if ($cache) {
			$cache->set($key, $result, 0, 150);
		}
		
		return $result;
	}
	
	public function indexAllSitesVerbose() {
		$c = new Criteria();
		$c->add("deleted", false);
		$c->add("visible", true);
		
		foreach (DB_SitePeer::instance()->select($c) as $site) {
			echo "indexing " . $site->getUnixName() . "\n";
			$this->indexSite($site);
			echo "commiting\n";
		}
		echo "commiting\n";
		$this->index->commit();
		$this->index->optimize();
		$this->index->commit();
	}
}
