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
$smarty->cache_lifetime = 120;
$smarty->assign('error', NULL);

if (empty($_SESSION['comic_seed'])) $_SESSION['comic_seed'] = rand();
if (empty($_SESSION['comic_step'])) $_SESSION['comic_step'] = 0;
if (empty($_SESSION['questions_solved'])) $_SESSION['questions_solved'] = 0;
if (empty($_GET['type'])) $_GET['type'] = getRandomProblemType();
if (empty($_GET['randomseed'])) $_GET['randomseed'] = rand(0, 10000);
if (empty($_POST['userinput'])) $_POST['userinput'] = false;

$script_path = '/srv/http/fastmath/MathServer/server.py';

$fpath = '/srv/http/fastmath/tmp/'.time().'.xml';
$fh = fopen($fpath, 'w');
fwrite($fh, $_POST['userinput']);
fclose($fh);

// call python script
$command = sprintf("bash -c \"python2 %s --random-seed %s --problem-type %s --user-input %s\"",
        $script_path, escapeshellarg($_GET['randomseed']), escapeshellarg($_GET['type']), escapeshellarg($fpath));
$result = exec($command);
$out = json_decode($result);

if ($out->correct) {
    sleep(0.1);
    $_GET['randomseed'] = rand(0, 10000);
    $_GET['type'] = getRandomProblemType();
    $command = sprintf("bash -c \"python2 %s --random-seed %s --problem-type %s --user-input %s\"",
        $script_path, escapeshellarg($_GET['randomseed']), escapeshellarg($_GET['type']), escapeshellarg($fpath));
    $result = exec($command);
    $out = json_decode($result);
    $_SESSION['questions_solved']++;
} elseif ($_POST['userinput'] != false) {
    $smarty->assign('error', 'Incorrect response');
}

// print out comic
// i.e. pass a seed to the comic generator script
$smarty->assign('comic', array('seed' => $_SESSION['comic_seed'], 'step' => $_SESSION['comic_step']));
$smarty->assign('math', array(
    'question' => $out->latex_statement,
    'seed' => $_GET['randomseed'],
    'type' => $_GET['type']
));

$smarty->display('tpl/problem.tpl');

function getRandomProblemType() {
    $array = array(
        'axIntegration',
        'polynomialDifferentiation');
    $ind = array_rand($array);
    return $array[$ind];
}