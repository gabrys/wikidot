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
 * @version $Id: UploadedFileFlowController.php,v 1.2 2008/06/24 12:25:48 quake Exp $
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

class UploadedFileFlowController extends PrivateFileFlowController {
	
	protected function serveFileWithMime($path) {
		
		/* guess/set the mime type for the file */
		if ($dir == "theme" || preg_match("/\.css$/", $path)) {
			$mime = "text/css";
		} else if (preg_match("/\.js$/", $path)) {
			$mime = "text/javascript";
		}
		
		if (! isset($mime)) {
			$mime = $this->fileMime($path, true);
		}
		
		$this->serveFile($path, $mime);
	}
	
	// detects from "file" if this is code request
	protected function isCodeRequest($file) {
		if (preg_match(";^code/;", $file)) {
			return true;
		} else {
			return false;
		}
	}
	
	protected function serveCode($site, $fileName) {
		$m = array();
		
		if (preg_match(";^code/([^/]+)(?:/([0-9]+))?$;", $fileName, $m)) {
			$pageName = $m[1];
			$number = 1;
			if (isset($m[2])) {
				$number = (int) $m[2];	
			}
			$ext = new CodeblockExtractor();
			header("Content-type: text/plain");
			echo $ext->extract($site, $pageName, $number);
			
		} else {
			$this->fileNotExists();
		}
	}
	
	public function process() {

		Ozone ::init();
		
		$runData = new RunData();
		$runData->init();
		Ozone::setRunData($runData);
		
		$siteHost = $_SERVER['HTTP_HOST'];
		$site = $this->getSite($siteHost);
		
		if (! $site) {
			$this->siteNotExists();
			return;
		}
		
		$file = $_SERVER['QUERY_STRING'];
		$file = preg_replace("/\\?.*\$/", "", $file);
		$file = preg_replace("|^/*|", "", $file);
		
		if (! $file) {
			$this->fileNotExists();
			return;
		}
		
		$path = $this->buildPath($site, $file);

		if ($this->isUploadDomain($siteHost)) {
			
			if ($this->publicArea($site, $file)) {
					
				if ($this->isCodeRequest($file)) {
					$this->serveCode($site, $file);
				} else {
					$this->serveFileWithMime($path);
				}
				
				return;
				
			} else {
			
				/* NON PUBLIC AREA -- CHECK PERMISSION! */
	
				if (preg_match("/\\?ukey=(.*)\$/", $_SERVER['QUERY_STRING'], $matches)) {
					setcookie("ucookie", $matches[1], 0, "/", $siteHost);
					$this->redirect($site, GlobalProperties::$URL_UPLOAD_DOMAIN, $file);
					return;
				}
				if (! isset($_COOKIE["ucookie"])) {
					$this->redirect($site, GlobalProperties::$URL_DOMAIN, $file);
					return;
				}
				
				$ucookie = DB_UcookiePeer::instance()->selectByPrimaryKey($_COOKIE["ucookie"]);
				
				if (! $ucookie || ! $ucookie->getOzoneSession() || ! $ucookie->getOzoneSession()->getOzoneUser()) {
					$this->redirect($site, GlobalProperties::$URL_DOMAIN, $file);
					return;
				}
				
				$user = $ucookie->getOzoneSession()->getOzoneUser();
				
				if ($this->userAllowed($user, $site, $file)) {
					
					if ($this->isCodeRequest($file)) {
						$this->serveCode($site, $file);
					} else {
						$this->serveFileWithMime($path);
					}
					return;
				}
			}
			
		} else {

			/* NOT UPLOAD DOMAIN, so it's *.wikidot.com or a custom domain */
			
			if ($this->publicArea($site, $file)) {
				
				$this->redirect($site, GlobalProperties::$URL_UPLOAD_DOMAIN, $file);
				return;
				
			} else {
				
				$runData->handleSessionStart();

				if ($this->userAllowed($runData->getUser(), $site, $file)) {
					
					$ucookie = new DB_Ucookie();
					$ucookie->generate($site, $runData->getSession());
					$ucookie->save();
					
					$this->redirect($site, GlobalProperties::$URL_UPLOAD_DOMAIN, $file, $ucookie->getUcookieId());
					return;
					
				}
			}
		}
		
		$this->forbidden();
		
	}
}
