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
 * @version $Id$
 * @copyright Copyright (c) 2008, Wikidot Inc.
 * @license http://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License
 */

require_once('Zend/Http/Client.php');
require_once('Zend/XmlRpc/Client/FaultException.php');
require_once('Zend/Http/Client/Adapter/Exception.php');
require_once('Zend/Http/Response.php');

/**
 * The Wikidot PingBack class.
 * 
 * Use it, to ping external services, and process other services ping requests
 * using PingBackServer as a frontend to this 
 *
 */
class PingBack {
	
	/**
	 * HTML block elements that can surround link and thus be treated as a context of the link
	 *
	 * @var array
	 */
	private static $BLOCK_ELEMENTS = array("div", "p", "body", "ul", "ol", "td", "pre", "center");
	
	/**
	 * how many bytes we want in context before and after the link
	 *
	 * @var int
	 */
	private static $CONTEXT_BYTES = 200;
	
	/**
	 * Constructs the PingBack object.
	 *
	 * @throws PingBackException if the Wikidot URI is wrong
	 * @param string $externalURI external URI
	 * @param string $wikidotURI Wikidot URI
	 */
	public function __construct($externalURI, $wikidotURI) {
		
		if ($this->isValidWikidotURI($wikidotURI)) {
			$this->wikidotURI = $wikidotURI;
		} else {
			throw new PingBackException("The specified target URI cannot be used as a target", 33);	
		}
		$this->externalURI = $externalURI;
		
	}
	
	/**
	 * Pingback from Wikidot page (source URI) to external page (target URI)
	 *
	 * @throws PingBackException if pinging is not successfull
	 * @return string the endpoint return value
	 */
	public function ping() {
		try {
			
			$rpc = new Zend_XmlRpc_Client($this->getExternalPingBackURI());
			$srv = $rpc->getProxy('pingback');
			return $srv->ping($this->wikidotURI, $this->externalURI());
			
		} catch (Zend_Http_Client_Adapter_Exception $e) {
			throw new PingBackException("HTTP Error: " . $e->getMessage());
		} catch (Zend_Http_Client_Exception $e) {
			throw new PingBackException("HTTP Error: " . $e->getMessage());
		} catch (Zend_XmlRpc_Client_FaultException $e) {			
			throw new PingBackException("XMLRCP Error: " . $e->getMessage(), $e->getCode());
		} catch (Exception $e) {
			throw new PingBackException("Unknown Error: " . $e->getMessage());
		}
	}
	
	/**
	 * Process a pingback from external page (source URI) to Wikidot page (target URI)
	 * 
	 * Returns an array containing to keys: 'title' (with value of the page title)
	 * and 'context' which contains the context in which the link to Wikidot page appears
	 * 
	 * @throws PingBackException
	 * @return array array of title and the context of the link to Wikidot page
	 */
	public function pong() {
		$ret = array();
		
		$ret["title"] = $this->getExternalTitle();
		$ret["context"] = $this->getExternalContext();
		
		return $ret;
	}
	
	/**
	 * Wikidot URI. When pinging Wikidot, or pinging from a Wikidot site, this must be a Wikidot page URI 
	 *
	 * @var string
	 */
	private $wikidotURI = null;
	
	/**
	 * External URI. When pinging Wikidot, or pinging from a Wikidot site, this must be the other page URI 
	 *
	 * @var string
	 */
	private $externalURI = null;
	
	/**
	 * Gets external site's PingBack XMLRPC endpoint URI
	 * Checks for the X-Pingback header and if this fails,
	 * searches for <link rel="pingback"> in the HTML
	 *
	 * @return string
	 */
	private function getExternalPingBackURI() {
		$extPage = $this->getExternalPage();
		$pb_url = $extPage->getHeader("X-Pingback");
		try {
			if (! $pb_url) {
				$html = $this->getExternalPageAsSimpleXml();
				$pb_urlx = $html->xpath1($html, "//link[@rel='pingback'][1]");
				if (! $pb_urlx) {
					throw new Exception();
				}
				$pb_url = $pb_urlx["href"];
			}
			if (! $pb_url) {
				throw new Exception();
			}
		} catch (Exception $e) {
			throw new PingBackNotAvailableException("Site does not seem to support PingBack service");
		}
		return $pb_url;
	}
	
	/**
	 * Checks whether the supplied URI is a valid Wikidot URI
	 *
	 * @param string $uri
	 * @return bool true if the URI is a valid Wikidot URI
	 */
	private function isValidWikidotURI($uri) {
		/* TODO: validate */
		return true;
	}
	
	/**
	 * Fetches the title of the external page.
	 * If title is not set, the URI is used
	 *
	 * @return string
	 */
	public function getExternalTitle() {
		$xml = $this->getExternalPageAsSimpleXml();
		
		try {
			
			$titles = $xml->xpath('//head/title');
			if (count($titles) < 1) {
				throw new Exception();
			}
			$title = $titles[0];
			if (empty($title)) {
				throw new Exception();
			}
			
		} catch (Exception $e) {
			$title = $this->externalURI();
		}
		
		return $title;
	}
	
	/**
	 * Gets the context in which the link to Wikidot page appears on the external site
	 *
	 * @return string HTML with context of the page -- all tags are stripped, but the <a href> to us 
	 */
	public function getExternalContext() {
		
		$xml = $this->getExternalPageAsSimpleXml();
		
		$href = htmlspecialchars($this->wikidotURI);
		$path = "//body//a[@href=\"$href\"][1]";
		$link = $this->xpath1($xml, $path);
		
		if (! $link) {
			throw new PingBackException("The source URI does not contain a link to the target URI", 17);
		}
		
		$context = $link;
		
		// Searching for the smallest block element containing the link
		while (! in_array(strtolower($context->getName()), self::$BLOCK_ELEMENTS)) {
			$path .= "/..";
			$context = $this->xpath1($xml, $path);
		}
		
		// Expanding context
		$previous = $this->xpath1($xml, "$path/preceding-sibling::*[position()=1]");
		$next = $this->xpath1($xml, "$path/following-sibling::*[position()=1]");
		
		// Join this all
		$ret = "";
		if ($previous) {
			$ret = $previous->asXML();
		}
		$ret .= " " . $context->asXML() . " ";
		if ($next) {
			$ret .= " " . $next->asXML();
		}
		
		// Add more space
		$ret = preg_replace("|<([^/])|s", " <\\1", $ret);
		
		// Strip tags but "a"
		$ret = strip_tags($ret, "<a>");
		
		// Sanitize "a" and add class delete
		$ret = preg_replace("|<a[^>]*href=\"([^\"]*)\"[^>]*>([^<]*)</a>|s", "<a class=\"delete\" href=\"\\1\">\\2</a>", $ret);
		
		// Find THE "a" tag and add a pingback class to it
		$xml = new SimpleXMLElement("<context>$ret</context>");
		$node = $this->xpath1($xml, "//a[@href=\"" . htmlspecialchars($this->wikidotURI) . "\"][1]");
		if ($node) {
			$node["class"] = "pingback";
		}
		$ret = strip_tags($xml->asXML(), "<a>");
		
		// Delete any "a" with class delete
		$ret = preg_replace("|<a[^>]*class=\"delete\"[^>]*>([^<]*)</a>|s", "\\1", $ret);
		
		// Fine cut the context
		$ret = preg_replace('|.*(.{' . self::$CONTEXT_BYTES . '}<a)|s', "\\1", $ret);
		$ret = preg_replace('|(a>.{' . self::$CONTEXT_BYTES . '}).*|s', "\\1", $ret);
		
		// Cut to words
		$ret = preg_replace("|^[^\\s]*\\s|s", "", $ret);
		$ret = preg_replace("|\\s[^\\s]*$|s", "", $ret);
		
		return $ret;
	}
	
	/**
	 * Queries SimpleXMLElement with XPath and return the first result or null if found nothing
	 *
	 * @param SimpleXMLElement $dom SimpleXMLElement object to query
	 * @param string $xpath the query
	 * @return SimpleXMLElement | null resulting element 
	 */
	private function xpath1($dom, $xpath) {
		$res = $dom->xpath($xpath);
		if (count($res) < 1) {
			return null;
		}
		return $res[0];
	}
	
	/**
	 * Requests the URL unless already fetched
	 *
	 * @return Zend_Http_Response the HTTP response object
	 */
	private function getExternalPage() {
		if (! $this->externalPageSet) {
			try {
				$hc = new Zend_Http_Client($this->externalURI);
				$this->externalPage = $hc->request("GET");
				$this->externalPageSet = true;
				if ($this->externalPage->getStatus() != 200) {
					throw new PingBackException("Site does not exist");
				}
			} catch (Zend_Http_Client_Adapter_Exception $e) {
				throw new PingBackException("HTTP error: " . $e->getMessage());
			}
		}
		return $this->externalPage;
	}
	
	private $externalPageAsSimpleXml = null;
	private $externalPageAsSimpleXmlSet = false;
	
	/**
	 * Gets the SimpleXxmlElement of the HTML from the external URI
	 *
	 * @return SimpleXMLElement simple XML element of the external document
	 */
	private function getExternalPageAsSimpleXml() {
		
		if (! $this->externalPageAsSimpleXmlSet) {
			
			$html = $this->getExternalPage()->getBody();
			$dom = new DOMDocument();
			@$dom->loadHTML($html);
			
			$xml = @simplexml_import_dom($dom);
			$this->externalPageAsSimpleXml = $xml;
			$this->externalPageAsSimpleXmlSet = true;
		}
		
		return $this->externalPageAsSimpleXml;
	}
}
