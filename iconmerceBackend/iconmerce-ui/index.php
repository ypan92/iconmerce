<?php
$pageTitle = "Unique Icons designed for all ages";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 
$login = $user->is_loggedin();

?>

<!-- Page Content -->
    <div class="container">

        <div class="row">

            <div class="col-md-3">
                <p class="lead">Gallary</p>
                <div class="list-group">
                    <a href="index.php" class="list-group-item">Gallery</a>
                    <a href="about.php" class="list-group-item">About</a>
                    <a href="popular.php" class="list-group-item">Popular</a>
                </div>
            </div>

            <div class="col-md-9">

                <div class="row carousel-holder">

                    <div class="col-md-12">
                        <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                            </ol>
                            <div class="carousel-inner">
                                <div class="item active">
                                    <!--<img class="slide-image" src="http://placehold.it/800x300" alt="">-->
                                    <div class="thumbnail carousel-thumbnail">
                                        <img src="./img/star.png" class="iconThumbnail" alt="">
                                        <div class="caption">
                                            <h4><a href="#">Gold Star</a>
                                            </h4>
                                            <p>Emphasize your favorite files with the gold star.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <!--<img class="slide-image" src="http://placehold.it/800x300" alt="">-->
                                    <div class="thumbnail carousel-thumbnail">
                                        <img src="./img/chest.png" class="iconThumbnail" alt="">
                                        <div class="caption">
                                            <h4><a href="item.php">Treasure</a>
                                            </h4>
                                            <p>Turn any treasured file into an actual treasure chest.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="item">
                                    <!--<img class="slide-image" src="http://placehold.it/800x300" alt="">-->
                                    <div class="thumbnail carousel-thumbnail">
                                        <img src="./img/charging_iconcopy.png" class="iconThumbnail" alt="">
                                        <div class="caption">
                                            <h4><a href="#">Charge</a>
                                            </h4>
                                            <p>Give your most important programs the charge symbol they deserve.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
                    </div>

                </div>

                <div class="row">
                	<div>
                		<<?php 
                			$action=isset($_GET['action'])?$_GET['action']:"";
                			if ($action=='added') {
                		 ?>
                		 <div class='alert alert-info'>
                		 	<strong><<?php  echo $_GET['name'];?> </strong>
                		 	was added to your cart!
                		 </div>
                		 <?php
                		 	}else if($action=='exists'){
                		 ?>
                		 <div class='alert alert-info'>
                		 	<strong><?php  echo $_GET['name'];?> </strong>
                		 	already exists in your cart!
                		 </div>
                		 <<?php } ?>
                	</div>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="./img/chest.png" class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right">$0.99</h4>
                                <h4><a href="item.php?item=Treasure&id=2">Treasure</a>
                                </h4>
                                <p>Turn any treasured file into an actual treasure chest.</p>

                                <div class="item_id">2</div>
                                <?php if($login){ ?>
	                                <a href="add_to_cart.php?id=2&name=Treasure" class="btn btn-primary">
	                                	<span class="glyphicon glyphicon-shopping-cart"> </span>Add to cart
	                                </a>
                                <?php } ?>
                            </div>
                            <div class="ratings">
                                <p class="pull-right">15 reviews</p>
                                <p>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="./img/star.png" class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right">$0.99</h4>
                                <h4><a href="item.php?item=GoldStar&id=1">Gold Star</a>
                                </h4>
                                <p>Emphasize your favorite files with the gold star.</p>
                                <?php if($login){ ?>
	                                <a href="add_to_cart.php?id=1&name=Star" class="btn btn-primary">
	                                    <span class="glyphicon glyphicon-shopping-cart"> </span>Add to cart
	                                </a>
	                            <?php } ?>    
                            </div>
                            <div class="ratings">
                                <p class="pull-right">12 reviews</p>
                                <p>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star-empty"></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="./img/charging_iconcopy.png" class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right">$0.99</h4>
                                <h4><a href="item.php?item=Charge&id=3">Charge</a>
                                </h4>
                                <p>Give your most important programs the charge symbol they deserve.</p>
	                                <?php if($login){ ?>
	                                <a href="add_to_cart.php?id=3&name=Charge" class="btn btn-primary">
	                                    <span class="glyphicon glyphicon-shopping-cart"> </span>Add to cart
	                                </a>
	                            <?php } ?>
                            </div>
                            <div class="ratings">
                                <p class="pull-right">31 reviews</p>
                                <p>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star-empty"></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="./img/exit_iconcopy.png" class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right">$0.99</h4>
                                <h4><a href="item.php?item=Exit&id=4">Exit</a>
                                </h4>
                                <p>Exit Icon.</p>
	                                <?php if($login){ ?>
	                                <a href="add_to_cart.php?id=4&name=Exit" class="btn btn-primary">
	                                    <span class="glyphicon glyphicon-shopping-cart"> </span>Add to cart
	                                </a>
	                             <?php } ?>
                            </div>
                            <div class="ratings">
                                <p class="pull-right">6 reviews</p>
                                <p>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star-empty"></span>
                                    <span class="glyphicon glyphicon-star-empty"></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src="./img/streetLights_iconcopy.png" class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right">$0.99</h4>
                                <h4><a href="item.php?item=StreetLight&id=5">Street Light</a>
                                </h4>
                                <p>Traffic Light Icon.</p>
	                            <?php if($login){ ?>
	                                <a href="add_to_cart.php?id=5&name=StreetLight" class="btn btn-primary">
	                                    <span class="glyphicon glyphicon-shopping-cart"> </span>Add to cart
	                                </a>
	                            <?php } ?>
                            </div>
                            <div class="ratings">
                                <p class="pull-right">18 reviews</p>
                                <p>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star"></span>
                                    <span class="glyphicon glyphicon-star-empty"></span>
                                </p>
                            </div>
                        </div>
                    </div>
<!--
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <h4><a href="#">Like this template?</a>
                        </h4>
                        <p>If you like this template, then check out <a target="_blank" href="http://maxoffsky.com/code-blog/laravel-shop-tutorial-1-building-a-review-system/">this tutorial</a> on how to build a working review system for your online store!</p>
                        <a class="btn btn-primary" target="_blank" href="http://maxoffsky.com/code-blog/laravel-shop-tutorial-1-building-a-review-system/">View Tutorial</a>
                    </div>-->

                </div>

            </div>

        </div>

    </div>

<?php 
include("inc/footer.php");
?>
