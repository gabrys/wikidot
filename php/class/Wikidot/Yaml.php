<?php

require_once(WIKIDOT_ROOT . '/lib/spyc/spyc.php');

class Wikidot_Yaml {
	public static function load($string) {
		return Spyc::YAMLLoadString($string);
	}
}