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
	<link rel="stylesheet" href="css/shop-homepage.css" type="text/css">
	<link rel="stylesheet" href="css/style.css" type="text/css">
	<link href='https://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/script.js"></script>
</head>
<body>

	<div class="main-header">

		<div class="container clearfix">

			<h1 class="name"><a href="index.php"><img src="img/Logo.png" id="logo" alt="ICONMERCE"></a></h1>
			<ul class="main-nav">
				<li><a href="#">gallery</a></li>
				<li><a href="#">categories</a></li>
				<li><a href="#">popular</a></li>
				
				<?php 
					if($user->is_loggedin()) {
				?>
					<li><a href="#"><?php echo '<p>WELCOME '.$_SESSION['username'].'</p>' ?></a></li>
					<li><a href='index.php?logout=true'>logout</a></li>
				<?php 
					} else {
				?>
					<li><a href="signup.php">sign up</a></li>
				 	<li><a href="login.php">login</a></li>
				<?php 
					} 
				?>
			</ul>

		</div>

	</div>

	<div class="secondary-header">
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">ICONMERCE</a>
			</div>
			<div class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="#">Gallery</a></li>
					<li><a href="#">Categories</a></li>
					<li><a href="#">Popular</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="signup.php"><span class="glyphicon glyphicon-user"></span>  Sign Up</a></li>
					<li><a href="login.php"><span class="glyphicon glyphicon-log-in"></span>  Login</a></li>
				</ul>
			</div>
		</div>
	</div>
	</div>