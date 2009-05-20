<?php

class Wikidot_Form {
	public $fields = array();
	public $presets = array();
	
	public static function fromYaml($yamlString) {
		$form = new self();
		$yaml = Wikidot_Yaml::load($yamlString);
		
		if (is_array($yaml['fields'])) {
			foreach ($yaml['fields'] as $name => $f) {
				unset($first_value);
				if (isset($f['options']) && is_array($f['options'])) {
					$f['type'] = 'select';
					$invalid_keys = array();
					foreach ($f['options'] as $key => $option) {
						if (! is_string($key) && ! is_numeric($key)) {
							$invalid_keys[] = $key;
						} else {
							if (is_string($option) || is_numeric($option)) {
								$option = array('value' => $option);
							}
							if (! is_string($option['value']) && ! is_numeric($option['value'])) {
								$invalid_keys[] = $key;
							} else {
								if (!isset($option['label']) || (! is_string($option['label'] && ! is_numeric($option['label'])))) {
									$option['label'] = $key;
								}
								if (! isset($first_value)) {
									$first_value = $option['value'];
								}
							}
						}
					}
					foreach ($invalid_keys as $invalid_key) {
						unset($f['options'][$invalid_key]);
					}
				} else {
					unset($f['options']);
				}
				if (! isset($f['type']) || ! is_string($f['type']) || empty($f['type'])) {
					$f['type'] == 'text';
					if (isset($f['options'])) {
						$f['type'] == 'select';
					}
				}
				if ($f['type'] == 'select' && (! isset($f['options']) || ! count($f['options']))) {
					$f['type'] = 'text';
				}
				if (isset($f['default']) && $f['type'] == 'select') {
					$def_val = $f['default'];
					if (isset($f['options'][$def_val])) {
						$f['default'] = $f['options'][$def_val]['value'];
					} elseif (! in_array($def_val, $f['options'])) {
						unset($f['default']);
					}
				}
				if (! isset($f['default']) || (! is_string($f['default']) && ! is_numeric($f['default']))) {
					unset($f['default']);
				}
				if (! isset($f['default'])) {
					if (isset($first_value)) {
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
					if (isset($field['options'][$value])) {
						$ret[$name] = $field['options'][$value]['value'];
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