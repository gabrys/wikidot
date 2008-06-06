<?php

require_once 'Zend/Filter/PregReplace.php';

abstract class Zend_Filter_Word_Separator_Abstract extends Zend_Filter_PregReplace
{

    protected $_separator = null;

    /**
     * Constructor
     * 
     * @param  string $separator Space by default
     * @return void
     */
    public function __construct($separator = ' ')
    {
        $this->setSeparator($separator);
    }
    
    public function setSeparator($separator)
    {
        if ($separator == null) {
            require_once 'Zend/Filter/Exception.php';
            throw new Zend_Filter_Exception('"' . $separator . '" is not a valid separator.');
        }
        $this->_separator = $separator;
        return $this;
    }
    
    public function getSeparator()
    {
        return $this->_separator;
    }

}