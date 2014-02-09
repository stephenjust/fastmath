<?php
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

define('MAX_COMIC_STEPS', 10);

session_start();

require_once('libs/Smarty.class.php');

$smarty = new Smarty;

//$smarty->force_compile = true;
$smarty->caching = false;
$smarty->cache_lifetime = 120;

$smarty->assign("foo","bar");

$smarty->display('tpl/main.tpl');