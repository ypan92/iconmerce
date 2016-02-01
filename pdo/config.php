<?php

session_start();

$DB_host = "localhost";
$DB_user = "root";
$DB_pass = "root";
$DB_name = "iconmerce";

try
{
     $DB_con = new PDO("mysql:host=$DB_host;port=8889;dbname=$DB_name", $DB_user,$DB_pass);
     $DB_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch(PDOException $e) {
     echo $e->getMessage();
     die();
}
//echo 'about to include user';
include_once 'class.user.php';
$user = new USER($DB_con);
//echo 'SUCCESSFL: DATABASE ACCESS!';
?>