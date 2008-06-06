<?php
/**
 * Zend Framework
 *
 * LICENSE
 *
 * This source file is subject to the new BSD license that is bundled
 * with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://framework.zend.com/license/new-bsd
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@zend.com so we can send you a copy immediately.
 *
 * @category   Zend
 * @package    Zend_View
 * @subpackage Helper
 * @copyright  Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @version    $Id: Partial.php 7086 2007-12-11 20:35:31Z matthew $
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */

/**
 * Helper for rendering a template fragment in its own variable scope.
 *
 * @package    Zend_View
 * @subpackage Helpers
 * @copyright  Copyright (c) 2005-2007 Zend Technologies USA Inc. (http://www.zend.com)
 * @license    http://framework.zend.com/license/new-bsd     New BSD License
 */
class Zend_View_Helper_Partial 
{
    /**
     * Instance of parent Zend_View object
     *
     * @var Zend_View_Abstract
     */
    public $view = null;

    /**
     * Renders a template fragment within a variable scope distinct from the
     * calling View object.
     *
     * If the $model is an array, it is passed to the view object's assign() 
     * method.
     *
     * If the $model is an object, it first checks to see if the object 
     * implements a 'toArray' method; if so, it passes the result of that 
     * method to to the view object's assign() method. Otherwise, the result of 
     * get_object_vars() is passed.
     *
     * @param  string $name Name of view script
     * @param  string|array $module If $model is empty, and $module is an array,
     *                              these are the variables to populate in the 
     *                              view. Otherwise, the module in which the 
     *                              partial resides
     * @param  array $model Variables to populate in the view
     * @return string 
     */
    public function partial($name, $module = null, $model = null)
    {
        $view = $this->cloneView();
        if ((null !== $module) && is_string($module)) {
            $moduleDir = Zend_Controller_Front::getInstance()->getControllerDirectory($module);
            if (null === $moduleDir) {
                require_once 'Zend/View/Helper/Partial/Exception.php';
                throw new Zend_View_Helper_Partial_Exception('Cannot render partial; module does not exist');
            }
            $viewsDir = dirname($moduleDir) . '/views';
            $view->addBasePath($viewsDir);
        } elseif ((null == $model) && (null !== $module) 
            && (is_array($module) || is_object($module))) 
        {
            $model = $module;
        } 

        if (!empty($model)) {
            if (is_array($model)) {
                $view->assign($model);
            } elseif (is_object($model)) {
                if (method_exists($model, 'toArray')) {
                    $view->assign($model->toArray());
                } else {
                    $view->assign(get_object_vars($model));
                }
            }
        }

        return $view->render($name);
    }

    /**
     * Set view object
     *
     * @param  Zend_View_Interface $view
     * @return Zend_View_Helper_Partial
     */
    public function setView(Zend_View_Interface $view)
    {
        $this->view = $view;
        return $this;
    }

    /**
     * Clone the current View
     *
     * @return Zend_View_Interface
     */
    public function cloneView()
    {
        $view = clone $this->view;
        $view->clearVars();
        return $view;
    }
}
