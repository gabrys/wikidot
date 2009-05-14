<?php

class Wikidot_Form {
	public $fields = array();
	public $presets = array();
	
	public static function fromYaml($yamlString) {
		$form = new self();
		$yaml = Wikidot_Yaml::load($yamlString);
		
		$first_value = null;
		
		if (is_array($yaml['fields'])) {
			foreach ($yaml['fields'] as $name => $f) {
				if (isset($f['values'])) {
					if (is_string($f['values'])) {
						$f['default'] = $f['values'];
						unset($f['values']);
					} else if (is_array($f['values'])) {
						$invalid_keys = array();
						foreach ($f['values'] as $key => $value) {
							if (! is_string($key) && ! is_numeric($key)) {
								$invalid_keys[] = $key;
							} else {
								if (! is_string($value) && ! is_numeric($value)) {
									$invalid_keys[] = $key;
								} else {
									if (empty($value)) {
										$f[$key] = $key;
									}
									if (empty($first_value)) {
										$first_value = $f[$key];
									}
								}
							}
						}
						foreach ($invalid_keys as $invalid_key) {
							unset($f['values'][$invalid_key]);
						}
					} else {
						unset($f['values']);
					}
				}
				if (! isset($f['type']) || ! is_string($f['type']) || empty($f['type'])) {
					$f['type'] == 'text';
					if (isset($f['values'])) {
						$f['type'] == 'select';
					}
				}
				if ($f['type'] == 'select' && (! isset($f['values']) || ! count($f['values']))) {
					$f['type'] = 'text';
				}
				if (! isset($f['default'])) {
					if ($first_value !== null) {
						$f['default'] = $first_value;
					} else {
						$f['default'] = $name;
					}
				}
				$form->fields[$name] = $f;
			}
			
		}
		if (is_array($yaml['presets'])) {
			$form->presets = $yaml['presets'];
		}
		return $form;
	}
}