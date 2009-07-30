<?php

class Wikidot_Form_Renderer extends Wikidot_Form {
    public function __construct($form) {
        $fields = $form->fields;
        $this->presets = $form->presets;
        $this->data = $form->data;
    
        foreach ($fields as $name => $field) {
            $this->fields[$name] = $field;
            $this->fields[$name]['editor'] = Wikidot_Form_Field::field($field);
        }
    }
    
	public static function fromYaml($yamlString, $dataYamlString = null) {
		$form = new self();
		$yaml = Wikidot_Yaml::load($yamlString);

        # relation between data type and field type
        $datatypes = array('text' => 'wiki', 'page' => 'wiki');
		
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
                $f['datatype'] = $datatypes[$f['type']];
                $f['name'] = $name;
				$form->fields[$name] = $f;
			}
			
		}

        if ($dataYamlString) {
            $data = Wikidot_Yaml::load($dataYamlString);
        } else {
            $data = array();
        }

        foreach ($form->fields as $name => $field) {
            if (isset($data[$name])) {
                $form->fields[$name]['value'] = $data[$name];
            } else {
                $form->fields[$name]['value'] = null;
            }
        }
        
		if (is_array($yaml['presets'])) {
			$form->presets = $yaml['presets'];
		}
		return $form;
	}

    public static function fromSource($source) {
        $m = array();
        preg_match(self::$FORM_REGEXP, $source, $m);
        if (count($m)) {
            return self::fromYaml($m[1]);
        } else {
            return null;
        }
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
