<?php 
$pageTitle = "popular";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 

try {
    $query = $DB_con->prepare("SELECT DISTINCT p.item_id,p.item_name,p.item_price,p.item_desc,p.item_location, AVG(r.rating) as avg FROM products as p inner join reviews as r  on (p.item_id=r.item_id) GROUP BY p.item_id ORDER BY avg DESC");
$query->execute();

} catch (PDOException $e){
	echo $e->getMessage();
}

?>

 <div class="container">

        <div class="row">
            <div class="col-md-3">
                <p class="lead">Most Popular</p>
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
                <?php 
    	    		while($urow=$query->fetch(PDO::FETCH_ASSOC)){
				?>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src=<?php echo './img/'.$urow['item_location'];?> class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right"> <?php echo '$'.$urow['item_price']; ?> </h4>
                                <h4><a href=<?php echo 'item.php?id='.$urow['item_id'];?> >
                                	<?php echo $urow['item_name'];?>
                                	</a>
                                </h4><p><?php echo $urow['item_desc'];?></p>
                                <?php if($user->is_loggedin()){ ?>
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
                    <?php }?>
                </div>
            </div>
        </div>

    </div>

<?php 
include("inc/footer.php");
?>
