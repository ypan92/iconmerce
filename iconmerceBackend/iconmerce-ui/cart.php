<?php
$pageTitle = "Cart";
$nameTitle = "ICONMERCE";
include("inc/header.php"); 
require_once('./config.php'); 

$action=isset($_GET['action'])?$_GET['action']:"";
$name=isset($_GET['name'])?$_GET['name']:"";

if(count($_SESSION['cart_items'])>0){
 
    // get the product ids
    $ids = "";
    foreach($_SESSION['cart_items'] as $id=>$value){
        $ids = $ids . $id . ",";
    }
 
    // remove the last comma
    $ids = rtrim($ids, ',');
 
    //start table
    echo "<table class='table table-hover table-responsive table-bordered'>";
 
        // our table heading
        echo "<tr>";
            echo "<th class='textAlignLeft'>Product Name</th>";
            echo "<th>Price (USD)</th>";
            echo "<th>Action</th>";
        echo "</tr>";
 
        $query = "SELECT * FROM products WHERE item_id IN ({$ids}) ORDER BY item_name";
 		//$query = $DB_con->prepare("SELECT * FROM products WHERE item_id IN ({$ids}) ORDER BY item_name");

        $stmt = $DB_con->prepare( $query );
        $stmt->execute();
 
        $total_price=0;
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)){
            extract($row);
 
            echo "<tr>";
                echo "<td>{$row['item_name']}</td>";
                echo "<td>&#36;{$row['item_price']}</td>";
                echo "<td>";
                    echo "<a href='remove_from_cart.php?id={$id}&name={$name}' class='btn btn-danger'>";
                        echo "<span class='glyphicon glyphicon-remove'></span> Remove from cart";
                    echo "</a>";
                echo "</td>";
            echo "</tr>";
 
            $total_price+=$row['item_price'];
        }
 
        echo "<tr>";
                echo "<td><b>Total</b></td>";
                echo "<td>&#36;{$total_price}</td>";
                echo "<td>";
                    echo "<a href='#' class='btn btn-success'>";
                        echo "<span class='glyphicon glyphicon-shopping-cart'></span> Checkout";
                    echo "</a>";
                    ?>
                    <form action="download.php" method="post">
                      <script src="https://checkout.stripe.com/checkout.js" class="stripe-button"
                              data-key="<?php echo $stripe['publishable_key']; ?>"
                              data-description="Buy these icons"
                              data-amount=<?php echo $total_price * 100; ?>
                              data-locale="auto"></script>
                    </form>
                    <?php
                echo "</td>";
            echo "</tr>";
 
    echo "</table>";
}
 
else{
    echo "<div class='alert alert-danger'>";
        echo "<strong>No products found</strong> in your cart!";
    echo "</div>";
}

?>

