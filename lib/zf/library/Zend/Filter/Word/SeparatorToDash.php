<?php

require_once 'Zend/Filter/Word/SeparatorToSeparator.php';

class Zend_Filter_Word_SeparatorToDash extends Zend_Filter_Word_SeparatorToSeparator
{

    public function __construct($searchSeparator = ' ')
    {
        parent::__construct($searchSeparator, '-');
    }
    
}