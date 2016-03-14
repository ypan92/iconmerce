<?php
$pageTitle = "Download";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 
?>

<h2>Thank you for purchasing the following icons!</h2>
<p>Please select the icons below to download them.</p>

<?php

	$ids = "";
    foreach($_SESSION['cart_items'] as $id=>$value){
        $ids = $ids . $id . ",";
    }
 
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

    foreach($_SESSION['cart_items'] as $id=>$value){
        unset($_SESSION['cart_items'][$id]);
    }
?>
