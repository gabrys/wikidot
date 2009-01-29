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
 * @version $Id: Lucene.php,v 1.1 2008/12/10 13:00:21 quake Exp $
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class Wikidot_Search_Lucene {
	
	protected $AT_ONCE = 10;	// load N pages from DB at once when indexing
	protected $CACHE_FOR = 150;	// cache the results for seconds
	
	protected $indexFile;
	protected $index;
	protected $queueFile;
	protected $queueLockFile;
	protected $lock;
	protected $processedFtsEntries = array();
	
	public function __construct($indexFile = null, $queueFile = null, $queueLockFile = null) {
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
		
		if ($queueLockFile) {
			$this->queueLockFile = $queueLockFile;
		} else {
			$this->queueLockFile = GlobalProperties::$SEARCH_LUCENE_LOCK;
		}
	}
	
	protected function loadIndex() {
		$this->index = Zend_Search_Lucene::open($this->indexFile);
		Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_Utf8Num_CaseInsensitive());
	}
	
	public function createIndex() {
		$this->index = Zend_Search_Lucene::create($this->indexFile);
		Zend_Search_Lucene_Analysis_Analyzer::setDefault(new Zend_Search_Lucene_Analysis_Analyzer_Common_Utf8Num_CaseInsensitive());
	}
	
	protected function resetQueue() {
		file_put_contents($this->queueFile, "");
	}
		
	protected function getFtsEntryDetails($fts, $site = null) {
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
			
			// add content, site_id, site_public, fts_id fields
			$doc = "UNSTORED content 1.0 " . str_replace("\n", " ", $fts->getText());
			$doc .= "\nTEXT site_id 0.1 " . $fts->getSiteId();
			$doc .= "\nTEXT site_public 0.1 " . ($site->getPrivate() ? "false" : "true");
			$doc .= "\nTEXT title 7.0 " . $fts->getTitle();
			
			if ($fts->getPageId()) {
				
				$doc .= "\nTEXT item_type 0.1 page";
				$doc .= "\nTEXT page_id 0.1 " . $fts->getPageId();
				
				// TAGS
				if ($page = DB_PagePeer::instance()->selectByPrimaryKey($fts->getPageId())) {
					$tags = $page->getTagsAsArray();
					$doc .= "\nUNSTORED tags " . (4.0 * count($tags)) . " " . implode(" ", $tags);
				}
				
			} elseif ($fts->getThreadId()) {
				
				$doc .= "\nTEXT item_type 0.1 thread";
				$doc .= "\nTEXT thread_id 0.1 " . $fts->getThreadId();
				
			} else {
				// NEITHER A PAGE NOR THREAD
				return;	
			}
			
			return "$doc\n";
		}
	}
	
	protected function queue($type, $id, $details = null) {
		while (! $this->tryLockingQueue()) {
			sleep(1);
		}
		
		$fp = fopen($this->queueFile, "a");
		
		if (! in_array($type, array("INDEX_FTS", "DELETE_PAGE", "DELETE_THREAD", "DELETE_SITE"))) {
			$type = "UNKNOWN";
		}
		$id = (int) $id;
		
		if ($type == "INDEX_FTS") {
			if ($details) {
				fwrite($fp, "$type $id\n");
				fwrite($fp, $details);
				fwrite($fp, "\n");
			}
		} else {
			fwrite($fp, "$type $id\n");
		}
		fclose($fp);
		
		$this->releaseQueueLock();
	}
	
	public function queueFtsEntry($fts_id, $fts_details = null) {
		if (! $fts_details) {
			$fts = DB_FtsEntryPeer::instance()->selectByPrimaryKey($fts_id);
			$fts_details = $this->getFtsEntryDetails($fts);
		}
		$this->queue("INDEX_FTS", $fts_id, $fts_details);
	}
	
	public function queueDeletePage($page_id) {
		$this->queue("DELETE_PAGE", $page_id);
	}
	
	public function queueDeleteThread($thread_id) {
		$this->queue("DELETE_THREAD", $thread_id);
	}
	
	protected function queueSite($site, $verbose = false, $fts_id_from = null, $fts_id_to = null) {
		
		if (is_numeric($site)) {
			$site = DB_SitePeer::instance()->selectByPrimaryKey($site);
		}
		
		if ($site) {
		
			$atOnce = $this->AT_ONCE;
			$offset = 0;
			
			$c = new Criteria();
			$c->setLimit($atOnce, $offset);
			
			if ($fts_id_to) {
				$c->add("fts_id", $fts_id_from, ">=");
				$c->add("fts_id", $fts_id_to, "<");
			}
			
			if ($site == "ALL") {
				$site = null;
			} else {
				$c->add("site_id", $site->getSiteId());
			}
			
			$pp = DB_FtsEntryPeer::instance();
			$entries = null;
			
			do {
				unset($entries); // try to save SOME memory
				
				$entries = $pp->selectByCriteria($c);
				
				foreach ($entries as $fts) {
					$this->queueFtsEntry($fts->getFtsId(), $this->getFtsEntryDetails($fts, $site));
				}

				$offset += $atOnce;
				$c->setLimit($atOnce, $offset);
				
				if ($verbose) {
					echo ".";
				}
				
			} while (count($entries));
		}
	}
	
	public function queueReIndexSite($site_id) {
		$this->queue("DELETE_SITE", $site_id);
		$this->queueSite($site_id);
	}

	/*
	 * queries the index and returns the array of Fts entries
	 * @param $query Lucene query to search for
	 * @return array fts_id array
	 */
	public function rawQuery($query) {
		$cache = Ozone::$memcache;
		$key = "search.." . md5($query);
		
		if ($cache && $result = $cache->get($key)) {
			return $result;
		}
		
		$result = $this->executeWikidotSearch($query);
		
		if ($cache) {
			$cache->set($key, $result, 0, $this->CACHE_FOR);
		}
		
		return $result;
	}
	
	/**
	 * high level Wikidot search function
	 * manages user permisisons, searches only in public sites + those user is a member of
	 * 
	 * @param $phrase		 Lucene query to search for 
	 * @param $user			 user that searches
	 * @param $itemType		 p - search only pages, f - only forums
	 * @param $sites		 sites to search within
	 * @param $onlyUserSites whether to search ONLY in user sites 
	 * @return array  		 fts_id array
	 */
	public function search($phrase, $user = null, $itemType = null, $sites = null, $onlyUserSites = false) {
		
		// user filter
		
		if ($onlyUserSites) {
			$user_query = "";
		} else {
			$user_query = "site_public:true";
		}
		
		if ($user) {
			$c = new Criteria();
			$c->add("user_id", $user->getUserId());
			$c->setLimit(100, 0);
			
			$memberships = DB_MemberPeer::instance()->selectByCriteria($c);
			if (count($memberships) < 100) {
				foreach ($memberships as $m) {
					$user_query .= " site_id:" . $m->getSiteId() . "^2";
				}
			}
		}
		
		if ($user_query == "") {
			$user_query = "site_public:true";
		}
		
		// sites filter
		
		$sites_query = "";
		if (is_array($sites) && count($sites)) {
			foreach ($sites as $site) {
				if (! is_numeric($site)) { // not an ID
					if (is_string($site)) { // maybe unix_name?
						$c = new Criteria();
						$c->add("unix_name", $site);
						$site = DB_SitePeer::instance()->selectOne($c); // make it an object
					}
				}
				if (is_a($site, "DB_Site")) { // object?
					$site = $site->getSiteId(); // get an id
				}
				if ($site !== null && is_numeric($site)) { // we have site id finally
					$sites_query .= " site_id:$site";
				}
			}	
		}
		
		// construct content_query
		$phrase = trim($phrase);
		if ($phrase == "") {
			return array();
		}
		if (! preg_match("/tags:/", $phrase) && ! preg_match("/title:/", $phrase) && ! preg_match("/content:/", $phrase)) {
			
			// give the exact match in title higher boost
			if (! strstr($phrase, '"') && ! strstr($phrase, '^')) {
				$title_phrase = "\"$phrase\"^5 $phrase";
			} else {
				$title_phrase = $phrase;
			}
			
			$content_query = "tags:($phrase) title:($title_phrase) content:($phrase)";
		} else {
			$content_query = $phrase;
		}
	
		$query = "";
		if ($itemType == "p") {
			$query .= "+item_type:page ";
		}
		if ($itemType == "f") {
			$query .= "+item_type:thread ";
		}
		if ($sites_query) {
			$query .= "+($sites_query) ";
		}
		$query .= "+($user_query) +($content_query)";
		
		return $this->rawQuery($query);
	}
	
	public function indexAllSitesVerbose($fts_id_from = null, $fts_id_to = null) {
		$this->loadIndex();
		$this->queueSite("ALL", true, $fts_id_from, $fts_id_to);
		echo "\n";
	}
	
	protected function executeWikidotSearch($query) {
		$results = array();
		if (GlobalProperties::$SEARCH_USE_JAVA) {
			$cmd = "java -jar " . escapeshellcmd(WIKIDOT_ROOT . "/bin/wikidotIndexer.jar");
			$cmd .= " search " . escapeshellarg($this->indexFile);
			$cmd .= " " . escapeshellarg($query);
			$cmd .= " 2>&1";
			
			exec($cmd, $results);
			if (count($results)) {
				// something other than int in the first line means we had an exception in java program
				if (! is_numeric($results[0])) {
					throw new Wikidot_Search_Exception(join("\n", $results));
				}
			}
		} else {
			$this->loadIndex();
			foreach ($this->index->find($query) as $hit) {
				$results[] = $hit->fts_id;
			}
		}
		
		return $results;
	}
	
	protected function tryLockingQueue() {
		$this->lock = fopen($this->queueLockFile, 'w');
		return flock($this->lock, LOCK_EX);
	}
	
	protected function releaseQueueLock() {
		fclose($this->lock);
	}
	
	public function processQueue() {
		if (GlobalProperties::$SEARCH_USE_JAVA) {
			$cmd = "java -jar " . escapeshellcmd(WIKIDOT_ROOT . "/bin/wikidotIndexer.jar");
			$cmd .= " process " . escapeshellarg($this->indexFile);
			$cmd .= " " . escapeshellarg($this->queueFile);
			$cmd .= " " . escapeshellarg($this->queueLockFile);
			$cmd .= " 2>&1";
			exec($cmd, $results);
			if (count($results)) {
				// something other than int in the first line means we had an exception in java program
				if (! is_numeric($results[0])) {
					throw new Wikidot_Search_Exception(join("\n", $results));
				}
			}
		} else {

			if (! $this->tryLockingQueue()) {
				return;
			}
			
			$this->loadIndex();
			
			$cmds = file($this->queueFile);
			$this->resetQueue();
			
			$this->releaseQueueLock();
			
			while (count($cmds)) {
				
				$cmd = array_shift($cmds);
				$a = explode(" ", $cmd);
				if ($a[0] == "DELETE_PAGE") {
					$this->zlDeleteItems("page_id:" . $a[1]);
				} elseif ($a[0] == "DELETE_THREAD") {
					$this->zlDeleteItems("thread_id:" . $a[1]);
				} elseif ($a[0] == "DELETE_SITE") {
					$this->zlDeleteItems("site_id:" . $a[1]);
				} elseif ($a[0] == "INDEX_FTS") {
					
					// delete it first
					$this->zlDeleteItems("fts_id:" . $a[1]);
				
					// construct the document
					$doc = new Zend_Search_Lucene_Document();
					
					while (true) {
						$line = array_shift($cmds);
						if (trim($line) == "") {
							break;
						}
						
						$args = explode(" ", $line);
						$type = array_shift($args);
						$key = array_shift($args);
						$boost = array_shift($args);
						$val = implode(" ", $args);
						
						if ($type == "TEXT") {
							$field = Zend_Search_Lucene_Field::text($key, $val);
						} else {
							$field = Zend_Search_Lucene_Field::unStored($key, $val);
						}
						
						$field->boost = $boost;
						$doc->addField($field);
					}
					$this->index->addDocument($doc);
				}
			}
			$this->index->commit();
		}
	}
	
	public function getCount() {
		$this->loadIndex();
		return $this->index->count();
	}
	
	protected function zlDeleteItems($query) {
		foreach ($this->index->find($query) as $hit) {
			$this->index->delete($hit->id);
		}
		
		$this->index->commit();
	}
}
