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

$smarty->caching = false;
$smarty->assign('error', NULL);
$smarty->assign('response', NULL);


// print out comic
// i.e. pass a seed to the comic generator script
$smarty->assign('comic', array('seed' => $_SESSION['comic_seed'], 'step' => $_SESSION['comic_step']));
$smarty->assign('score', $_SESSION['questions_solved']);

$smarty->display('tpl/end.tpl');

