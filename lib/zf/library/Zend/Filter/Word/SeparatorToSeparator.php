<?php

require_once 'Zend/Filter/PregReplace.php';

class Zend_Filter_Word_SeparatorToSeparator extends Zend_Filter_PregReplace
{

    protected $_searchSeparator = null;
    protected $_replacementSeparator = null;

    public function __construct($searchSeparator = ' ', $replacementSeparator = '-')
    {
        $this->setSearchSeparator($searchSeparator);
        $this->setReplacementSeparator($replacementSeparator);
    }

    public function setSearchSeparator($separator)
    {
        $this->_searchSeparator = $separator;
        return $this;
    }

    public function getSearchSeparator()
    {
        return $this->_searchSeparator;
    }

    public function setReplacementSeparator($separator)
    {
        $this->_replacementSeparator = $separator;
        return $this;
    }

    public function getReplacementSeparator()
    {
        return $this->_replacementSeparator;
    }

    public function filter($value)
    {
        return $this->_separatorToSeparatorFilter($value);
    }
    
    protected function _separatorToSeparatorFilter($value)
    {
        if ($this->_searchSeparator == null) {
            require_once 'Zend/Filter/Exception.php';
            throw new Zend_Filter_Exception('You must provide a search separator for this filter to work.');
        }

        $this->setMatchPattern('#' . preg_quote($this->_searchSeparator, '#') . '#');
        $this->setReplacement($this->_replacementSeparator);
        return parent::filter($value);
    }

}