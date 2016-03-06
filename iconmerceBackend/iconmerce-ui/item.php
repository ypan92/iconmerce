<?php
$pageTitle = "Unique Icons designed for all ages";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 

try {
    $query = $DB_con->prepare("SELECT * FROM products WHERE item_id=:item LIMIT 1");
    $query->execute(array(':item'=>$_GET['id']));
    $items=$query->fetch(PDO::FETCH_ASSOC);
    $item = './img/'.$items['item_location'];
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
	$user->addComment($_GET['id'], $_POST['comment']);
	echo "<script>";
	echo "window.location.href = ".'./item.php?id='.$id;
	echo "</script>";
}


 $rating1 = isset($_POST['1'])?1:"";
 $rating2 = isset($_POST['2'])?2:"";
 $rating3 = isset($_POST['3'])?3:"";
 $rating4 = isset($_POST['4'])?4:"";
 $rating5 = isset($_POST['5'])?5:"";
if($rating1 !=""){
	$user->addRating($items['item_id'], $_SESSION['user_session'],1);
}
if($rating2 !="") {
	$user->addRating($items['item_id'],$_SESSION['user_session'],2);
}
if($rating3 !="") {
	$user->addRating($items['item_id'],$_SESSION['user_session'],3);
}
if($rating4 !="") {
	$user->addRating($items['item_id'],$_SESSION['user_session'],4);
}

if($rating5 !="") {
	$user->addRating($items['item_id'],$_SESSION['user_session'],5);
}
?> 
    <!-- Page Content -->
    <div class="container">

        <div class="row">

            <div class="col-md-3">
                <p class="lead">Shop Name</p>
                <div class="list-group">
                    <a href="index.php" class="list-group-item active">Category 1</a>
                    <a href="popular.php" class="list-group-item">Category 2</a>
                    <a href="popular.php" class="list-group-item">Category 3</a>
                </div>
            </div>

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
                        <p class="pull-right">3 reviews</p>
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
	                            <button type="submit" name="1"><span class="glyphicon glyphicon-star-empty"></span></button>
	                    		<button type="submit" name="2"><span class="glyphicon glyphicon-star-empty"></span></button>
	                            <button type="submit" name="3"><span class="glyphicon glyphicon-star-empty"></span></button>
	                            <button type="submit" name="4"><span class="glyphicon glyphicon-star-empty"></span></button>
	                            <button type="submit" name="5"><span class="glyphicon glyphicon-star-empty"></span></button>
	                            <span class="pull-right"><button class="btn btn-success" name="review"> Leave a Review</button></span>
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
	                            <span class="pull-right">blank</span> <br>
	                            <textarea name="comment" rows="5" cols="100"></textarea> <br>
	                            <button class="btn btn-success" name="submit">submit</button>
	                        </div>
	                    </div>
	                    </form>
	                    <hr>
	                    <?php  } 
	                    	
							$getComment = $DB_con->prepare("SELECT * FROM comments");
							$getComment->execute();

							$Rated = $DB_con->prepare("SELECT * FROM reviews WHERE user_id=:id LIMIT 1");
							$Rated->execute(array(':id'=>$_SESSION['user_session']));
							$displayRating = $Rated->fetch(PDO::FETCH_ASSOC);

	                    	if($getComment->rowCount()>0){
	                    		while($comment = $getComment->fetch(PDO::FETCH_ASSOC)) {
	                    ?>
	                    <div class="row">
	                        <div class="col-md-12">
	                        <?php 
	                        	for ($x = 0; $x <= $displayRating['rating']; $x++) { ?>
	                        		<span class="glyphicon glyphicon-star"></span>
	                        <?php } 
	                        	for ($x = $displayRating['rating']+1; $x < 5; $x++) { ?>
	                        		<span class="glyphicon glyphicon-star-empty"></span>
	                        <?php } echo $info['username']; ?>
	                            <span class="pull-right">10 days ago</span>
	                            <p> <?php echo $comment['comment']; ?> </p>
	                        </div>
	                    </div>

	                    <hr>
	                    <?php } 

	                    }?>
	                    <div class="row">
	                        <div class="col-md-12">
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star-empty"></span>
	                            Anonymous
	                            <span class="pull-right">12 days ago</span>
	                            <p>I've alredy ordered another one!</p>
	                        </div>
	                    </div>

	                    <hr>

	                    <div class="row">
	                        <div class="col-md-12">
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star"></span>
	                            <span class="glyphicon glyphicon-star-empty"></span>
	                            Anonymous
	                            <span class="pull-right">15 days ago</span>
	                            <p>I've seen some better than this, but not at this price. I definitely recommend this item.</p>
	                        </div>
	                    </div>
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
                    <p>Copyright &copy; Your Website 2014</p>
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
