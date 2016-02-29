<?php 
$pageTitle = "popular";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 

try {
	$query = $DB_con->prepare("SELECT * FROM products");
	$query->execute();
} catch (PDOException $e){
	echo $e->getMessage();
}
?>

 <div class="container">

        <div class="row">
                <div class="col-md-3">
                <p class="lead">ICONMERCE</p>
                <div class="list-group">
                    <a href="index.php" class="list-group-item">Gallery</a>
                    <a href="popular.php" class="list-group-item">Categories</a>
                    <a href="popular.php" class="list-group-item">Popular</a>
                </div>
            </div>
            
            <div class="col-md-9">
                <div class="row">
                <?php 
    	    		while($urow=$query->fetch(PDO::FETCH_ASSOC)){
				?>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <img src=<?php echo './img/'.$urow['item_location'];?> class="iconThumbnail" alt="">
                            <div class="caption">
                                <h4 class="pull-right">$0.99</h4>
                                <h4><a href=<?php echo 'item.php?item='.$urow['item_name'].'&id='.$urow['item_id'];?> >
                                	<?php 
                                		echo $urow['item_location'];?>
                                	</a>
                                </h4>
                                <p><?php echo $urow['item_desc'];?></p>
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
