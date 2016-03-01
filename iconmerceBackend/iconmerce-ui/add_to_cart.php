<?php
$pageTitle = "Unique Icons designed for all ages";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 
include_once 'pdo/config.php';

$id = isset($_GET['id']) ? $_GET['id'] : "";
$name = isset($_GET['name']) ? $_GET['name'] : "";
$quantity = isset($_GET['quantity']) ? $_GET['quantity'] : "";

if(!isset($_SESSION['cart_items'])){
	$_SESSION['cart_items']=array();
}

if(array_key_exists($id,$_SESSION['cart_items'])) {
	//header('Location: /index.php?action=exists&id=' . $id . '&name=' . $name);
	echo "<script>";
	echo "window.location.href = './index.php?action=exists'";
	echo "</script>";
	//$user->redirect('index.php?action=exists');
}else{
	$_SESSION['cart_items'][$id]=$name;	
	echo "<script>";
	echo "window.location.href = './index.php?action=added'";
	echo "</script>";
	//$user->redirect('./index.php');
}
?>