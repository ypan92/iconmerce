<?php
$pageTitle = "Unique Icons designed for all ages";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 
$login = $user->is_loggedin();

try {
    $query = $DB_con->prepare("SELECT * FROM products WHERE item_id=:item LIMIT 1");
    $query->execute(array(':item'=>$_GET['id']));
    $items=$query->fetch(PDO::FETCH_ASSOC);
    $item = './img/'.$items['item_location'];

    $reviewCount = $DB_con->prepare("SELECT COUNT(*) as count FROM ReviewsRatings WHERE item_id = ".$items['item_id']);
    $reviewCount->execute();
    $numReviews = $reviewCount->fetch(PDO::FETCH_ASSOC);

    $purchaseQuery = $DB_con->prepare("SELECT * FROM purchases WHERE item_id = ".$items['item_id']);
    $purchaseQuery->execute();
    $purchases = $purchaseQuery->fetch(PDO::FETCH_ASSOC);


} catch (PDOException $e){
    echo $e->getMessage();
}
$allow = "";
$owner = "";
$info = "";
if(isset($_POST['review'])){
	$allow='ALLOW';
}

if(isset($_POST['submit'])){
	$user->addReviewRating($_SESSION['user_session'], $items['item_id'], $_POST['rating'], $_POST['comment']);
	echo "<script>";
	echo "window.location.href = ".'./item.php?id='.$id;
	echo "</script>";
}

?> 
    <!-- Page Content -->
    <div class="container">

        <div class="row">

            <div class="col-md-9">

                <div class="thumbnail">
                    <img src=<?php echo $item;?> class="iconThumbnail" alt="">
                    <div class="caption-full">
                        <h4 class="pull-right"><?php echo '$'.$items['item_price']; ?></h4>
                        <h4><a href="#"><?php echo $items['item_name']; ?></a>
                        </h4>
                        <p>See more snippets like these online store reviews at <a target="_blank" href="http://bootsnipp.com">Bootsnipp - http://bootsnipp.com</a>.</p>
                        <p>Want to make these reviews work? Check out
                            <strong><a href="http://maxoffsky.com/code-blog/laravel-shop-tutorial-1-building-a-review-system/">this building a review system tutorial</a>
                            </strong>over at maxoffsky.com!</p>
                        <p>
                            <?php echo $items['item_desc'].'<br>'; ?>
                        Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum</p>
                    </div>
                    <div class="ratings">
                        <p class="pull-right"><?php echo $numReviews['count']." reviews"; ?></p>
                        <p>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star"></span>
                            <span class="glyphicon glyphicon-star-empty"></span>
                            4.0 stars
                        </p>
                    </div>
                </div>

                <div class="well">
                	<form method="post">
	                    <div class="row">
	                    	<?php if ($login) { ?>
	                        <span class="pull-right"><button class="btn btn-success" name="review"> Leave a Review</button></span>
	                        <?php } ?>
	                    </div>
	                </form>
	                    <hr>
	                    <?php
	                    	$owner = $DB_con->prepare("SELECT * FROM users WHERE user_id=:id LIMIT 1");
							$owner->execute(array(':id'=>$_SESSION['user_session']));
							$info=$owner->fetch(PDO::FETCH_ASSOC);
		                    if($allow =='ALLOW') {
	                    ?>
	                    <form method="post">
	                    <div class="row">
	                        <div class="col-md-12">
	                            <?php echo  $info['username'];?> 
	                            <span class="pull-right"></span> <br>
	                            <textarea name="comment" rows="5" cols="100"></textarea> <br>
	                            <input id="ratings-hidden" name="rating" type="hidden"> 
                                <div class="text-right">
		                            <div class="stars starrr" data-rating="0"></div>
		                            <a class="btn btn-danger btn-sm" href="#" id="close-review-box" style="display:none; margin-right: 10px;">
		                            <span class="glyphicon glyphicon-remove"></span>Cancel</a>
	                            <button class="btn btn-success" name="submit">submit</button>
                    			</div>
                    		</div>
	                    </div>
	                    </form>
	                    <hr>
	                    <?php  } 
	                    	
							$reviewRating = $DB_con->prepare("SELECT * FROM ReviewsRatings WHERE item_id = ".$items['item_id']
															 ." ORDER BY date desc");
							$reviewRating->execute();

	                    	if ($reviewRating->rowCount() > 0) {
	                    		while ($review = $reviewRating->fetch(PDO::FETCH_ASSOC)) {

	                    ?>
	                    <div class="row">
	                        <div class="col-md-12">
	                        <?php 
	                        	for ($x = 0; $x < $review['rating']; $x++) { ?>
	                        		<span class="glyphicon glyphicon-star"></span>
	                        <?php } 
	                        	for ($x = $review['rating']; $x < 5; $x++) { ?>
	                        		<span class="glyphicon glyphicon-star-empty"></span>
	                        <?php } echo $info['username']; ?>
	                            <span class="pull-right"><?php echo $review['date']; ?></span>
	                            <p> <?php echo $review['review']; ?> </p>
	                        </div>
	                    </div>

	                    <hr>
	                    <?php } 

	                    }?>

                    </form>

                </div>

            </div>

        </div>

    </div>
    <!-- /.container -->

    <div class="container">

        <hr>

        <!-- Footer -->
        <footer>
            <div class="row">
                <div class="col-lg-12">
                    <p>Copyright &copy; Iconmerce 2016</p>
                </div>
            </div>
        </footer>

    </div>
    <!-- /.container -->

    <!-- jQuery -->
    <script src="js/jquery.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="js/bootstrap.min.js"></script>

</body>

</html>
