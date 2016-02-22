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
	header('Location: index.php?action=exists&id' . $id . '&name=' . $name);
	//$user->redirect("/index.php?action=exists&id\"".$id."\"&name=\"".$name."\"");
}else{
	$_SESSION['cart_items'][$id]=$name;
	header('Location: index.php?action=added&id'.$id.'&name='.$name);
	//$user->redirect("index.php?action=added&id\"".$id."\"&name=\"".$name."\"");
}
?>