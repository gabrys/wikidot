<?php

class Wikidot_Form {
	public $fields = array();
	public $presets = array();
	
	public static function fromYaml($yamlString) {
		$form = new self();
		$yaml = Wikidot_Yaml::load($yamlString);
		
		if (is_array($yaml['fields'])) {
			foreach ($yaml['fields'] as $name => $f) {
				if (isset($f['values'])) {
					if (is_string($f['values'])) {
						$f['default'] = $f['values'];
						unset($f['values']);
					} else if (is_array($f['values'])) {
						$f['type'] = 'select';
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
									if (! isset($first_value)) {
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
				if (isset($f['default']) && $f['type'] == 'select') {
					$def_val = $f['default'];
					if (isset($f['values'][$def_val])) {
						$f['default'] = $f['values'][$def_val];
					} elseif (! in_array($def_val, $f['values'])) {
						unset($f['default']);
					}
				}
				if (! is_string($f['default']) && ! is_numeric($f['default'])) {
					unset($f['default']);
				}
				if (! isset($f['default'])) {
					if ($first_value !== null) {
						$f['default'] = $first_value;
					} else {
						$f['default'] = '';
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
	
	public function computeValues($values) {
		$ret = array();
		foreach ($this->fields as $name => $field) {
			if (isset($values[$name]) && (is_string($name) || is_numeric($name))) {
				$value = $values[$name];
				$type = $field['type'];
				
				if ($type == 'select') { 
					if (isset($field['values'][$value])) {
						$ret[$name] = $field['values'][$value];
					}
				} elseif ($type == 'text') {
					$ret[$name] = $value;
				}
			}
			if (! isset($ret[$name])) {
				$ret[$name] = $field['default'];
			}
		}
		return $ret;
	}
}