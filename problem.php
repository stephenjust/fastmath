<?php
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

require_once('libs/Smarty.class.php');

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
// populate template


$smarty = new Smarty;

//$smarty->force_compile = true;
$smarty->debugging = true;
$smarty->caching = true;
$smarty->cache_lifetime = 120;

$smarty->assign("foo","bar");

$smarty->display('tpl/problem.tpl');

