<?php
include_once 'pdo/config.php';

if ($_GET['logout']) {
	$user->logout();
}
?>

<html>
<head>
	<title><?php echo $pageTitle; ?></title>
	<link rel="stylesheet" href="css/normalize.css" type="text/css">
	<link rel="stylesheet" href="css/bootstrap.min.css">
	<link rel="stylesheet" href="css/bootstrap-theme.min.css">
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link rel="stylesheet" href="css/shop-homepage.css" type="text/css">
	<!--link href='https://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'-->
</head>
<body>

	<div class="main-header">

		<div class="container clearfix">

			<h1 class="name"><a href="index.php"><?php echo $nameTitle ?></a></h1>
			<ul class="main-nav">
				<li><a href="#">gallery</a></li>
				<li><a href="#">categories</a></li>
				<li><a href="#">popular</a></li>
				<!--li><a href="#">new</a></li-->
				<li><a href="signup.php">sign up</a></li>
				<?php 
					if($user->is_loggedin()) {
				?>
					<li><a href="#"><?php echo '<p>WELCOME '.$_SESSION['username'].'</p>' ?></a></li>
					<li><a href='index.php?logout=true'>logout</a></li>
				<?php 
					} else {
				?>
				 	<li><a href="login.php">login</a></li>
				<?php 
					} 
				?>
			</ul>

		</div>

	</div>