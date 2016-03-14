<?php 
$pageTitle = "Settings";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 

try {
	$query = $DB_con->prepare("SELECT * FROM users WHERE user_id=:userID LIMIT 1");
	$query->execute(array(':userID'=>$_SESSION['user_session']));
	$urow=$query->fetch(PDO::FETCH_ASSOC);
} catch (PDOException $e){
	echo $e->getMessage();
}
$option = isset($_GET['option']) ? $_GET['option'] : '1';

if(isset($_POST['btn-submit'])) {
	if($_POST['username'] != "") 
		$user->update($_SESSION['user_session'],$_POST['username'], "username", "users");
	if($_POST['email'] != "")
		$user->update($_SESSION['user_session'],$_POST['email'], "email", "users");
	if($_POST['password'] != "")
		$user->update($_SESSION['user_session'],$_POST['password'], "password", "users");

	echo "<script>";
	echo "window.location.href = './account.php?action=Successful'";
	echo "</script>";
}
?>

 <div class="container">

        <div class="row">
                <div class="col-md-3">
                <p class="lead">Settings</p>
                <div class="list-group">
                    <a href="account.php?option=1" class="list-group-item">User Information</a>
                    <a href="account.php?option=2" class="list-group-item">Edit Information</a>
                    <a href="account.php?option=3" class="list-group-item">View History</a>
                </div>
            </div>
            
            <div class="col-md-9">
                <div class="row">
               		<?php 
                			$action=isset($_GET['action'])?$_GET['action']:"";
                			if ($action=='Successful') {
                		 ?>
                		 <div class='alert alert-info'>
                		 	<strong>UPDATE </strong>
                		 	was successful!
                		 </div>
                		 <?php }?>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <div class="caption">
                                <h4>Name</h4>
                                <p><?php echo $urow['name']; ?></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <div class="caption">
                                <h4>username</h4>
                                <p><?php echo $urow['username']; ?></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 col-lg-4 col-md-4">
                        <div class="thumbnail">
                            <div class="caption">
                                <h4>email</h4>
                                <p><?php echo $urow['email']; ?></p>
                            </div>
                        </div>
                    </div>
					<?php if($option=='2') { ?>
					<form method="post">
						<!--<div class="col-sm-4 col-lg-4 col-md-4">
                        	<div class="thumbnail">
                            	<div class="caption">
                                	<h4>New Username</h4>
                                	
                                		<input type="text" class="form-control" name="username" placeholder="New username"></input>
                    				
                            	</div>
                       		</div>
                       </div>-->
                       <div class="col-sm-4 col-lg-4 col-md-4">
                        	<div class="thumbnail">
                            	<div class="caption">
                                	<h4>New email</h4>
                                	
                                		<input type="text" class="form-control" name="email" placeholder="New email" ></input>
                    				
                            	</div>
                        	</div>
                       </div>
                       <div class="col-sm-4 col-lg-4 col-md-4">
                       		<div class="thumbnail">
                            	<div class="caption">
                                	<h4>New password</h4>
                                	
                                		<input type="text" class="form-control" name="password" placeholder="New password" ></input>
                    				
                            	</div>
                        	</div>
                       </div>
                    		<button class="btn btn-lg btn-primary btn-block" type="submit" name="btn-submit">
                    		Submit changes</button>
                       </form> 
                    <?php } ?>  
                    <?php if ($option == '3') { 
                        $ids = "";
                        $purchQuery = "SELECT * FROM purchases WHERE user_id = ".$_SESSION['user_session'];
                        $purchStmt = $DB_con->prepare($purchQuery);
                        $purchStmt->execute();
                        while ($purchRow = $purchStmt->fetch(PDO::FETCH_ASSOC)) {
                            extract($purchRow);
                            $ids = $ids . $purchRow["item_id"] . ",";
                        } 
                        
                        /*foreach($_SESSION['cart_items'] as $id=>$value){
                            $ids = $ids . $id . ",";
                        }*/
                     
                        // remove the last comma
                        $ids = rtrim($ids, ',');


                        echo "<table class='table table-hover table-responsive table-bordered'>";
                     
                            // our table heading
                            echo "<tr>";
                                echo "<th class='textAlignLeft'>Product Name</th>";
                                echo "<th>Action</th>";
                            echo "</tr>";
                     
                            $query = "SELECT * FROM products WHERE item_id IN ({$ids}) ORDER BY item_name";
                            //$query = $DB_con->prepare("SELECT * FROM products WHERE item_id IN ({$ids}) ORDER BY item_name");

                            $stmt = $DB_con->prepare( $query );
                            $stmt->execute();
                     
                            while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
                                extract($row);
                                
                                $file = $row["item_location"];
                                $user->addPurchase($_SESSION['user_session'], $row["item_id"]);
                                echo "<tr>";
                                    echo "<td>{$row['item_name']}</td>";
                                    echo "<td>";
                                        echo "<a href='./img/{$file}' class='btn btn-success' download>";
                                            echo "<span class='glyphicon glyphicon-shopping-cart'></span> Download";
                                        echo "</a>";
                                    echo "</td>";
                                echo "</tr>";

                            }
                     
                        echo "</table>";
                    } ?>

                </div>
            </div>
        </div>

    </div>
<?php include("inc/footer.php");?>

