<?php
$pageTitle = "Unique Icons designed for all ages";
$nameTitle = "ICONMERCE";
include("inc/header.php");
?>

	<div id="myCarousel" class="carousel slide jumbotron">
        <div class="container">
    		<ol class="carousel-indicators">
    			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    			<li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="item active">
                    <h1>Iconmerce - icons made by fans for fans</h1>
                    <p class="lead">Find the best icons to customize your computer experience.</p>
                    <p class="btn-group">
                      <a class="btn btn-success btn-lg" href="#">Show me some icons</a>
                      <!--a class="btn btn-default btn-lg hidden-xs" href="#" >Text me the link</a-->
                    </p>
                </div>
                <div class="item">
                    <h1>Check out our most popular icons</h1>
                    <p class="lead">Browse our selection of top rated icons!</p>
                    <p>
                        <a class="btn btn-success btn-lg" href="#">Show me the hottest icons!</a>
                    </p>
                </div>
                <div class="item">
                    <h1>This just in! Our newest icons!</h1>
                    <p class="lead">Check out what's new!</p>
                    <p>
                        <a class="btn btn-success btn-lg" href="#">Show me the new icons!</a>
                    </p>
                </div>
            </div>
            <!-- Carousel controls -->
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="icon-prev"></span>
            </a>
            <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="icon-next"></span>
            </a>
        </div>
    </div>

    <script src="http://code.jquery.com/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>

</body>
</html>