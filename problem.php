<?php
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

define('MAX_COMIC_STEPS', 10);

session_start();

require_once('libs/Smarty.class.php');

if (empty($_SESSION['comic_seed'])) $_SESSION['comic_seed'] = rand();
if (empty($_SESSION['comic_step'])) $_SESSION['comic_step'] = 0;
if (empty($_SESSION['questions_solved'])) $_SESSION['questions_solved'] = 0;
if (empty($_GET['type'])) $_GET['type'] = 'problem';
if (empty($_GET['randomseed'])) $_GET['randomseed'] = '1';
if (empty($_POST['userinput'])) $_POST['userinput'] = false;

$script_path = '/srv/http/fastmath/MathServer/server.py';

// call python script
ob_start();
system(sprintf("python2 %s %d %s %s", $script_path, escapeshellarg($_GET['randomseed']), escapeshellarg($_GET['type']), escapeshellarg($_POST['userinput'])));
$out = json_decode(ob_get_clean());
print_r($out);

// print out comic
// i.e. pass a seed to the comic generator script
$smarty->assign('comic', array('seed' => $_SESSION['comic_seed'], 'step' => $_SESSION['comic_step']));

// populate template


$smarty = new Smarty;

//$smarty->force_compile = true;
$smarty->debugging = true;
$smarty->caching = true;
$smarty->cache_lifetime = 120;

$smarty->assign("foo","bar");

$smarty->display('tpl/problem.tpl');

