<?php
$pageTitle = "Sign Up";
$nameTitle = "ICONMERCE";
include("inc/header.php");
include_once 'pdo/config.php';

if(isset($_POST['btn-register'])){
    $my_name = trim($_POST['name']);
    $my_username = trim($_POST['username']);
    $my_email = trim($_POST['email']);
    $my_password = trim($_POST['password']);

    if($my_name=="") {
        $error[] = "provide name !"; 
    } 
    else if($my_username=="") {
        $error[] = "provide username !";
    } 
    else if(!filter_var($my_email, FILTER_VALIDATE_EMAIL)) {
        $error[] = "Please enter a valid email";
    } 
    else if($my_password=="") {
        $error[] = "Please enter passwordl";
    } 
    else if(strlen($my_password) < 6) {
        $error[] = "Password must be at least 6 characters";
    } 
    else {
        try {
            $query = $DB_con->prepare("SELECT username,email FROM users WHERE username=:uname OR email=:umail");
            $query->execute(array(':uname'=>$my_username, ':umail'=>$my_email));
            $row=$query->fetch(PDO::FETCH_ASSOC);

            if($my_username==$row['username']){
                $error[] = "Sorry username taken !";
            } 
            else if($my_email==$row['email']) {
                $error[] = "Sorry email taken !";
            } 
            else {
                //if($user->register($my_name,$my_username,$my_email,$my_password)) { // echo 'SUCCESS!: name: '. $my_name . ' username: ' . $my_username . ' email: '.$my_email;
                    $user->register($my_name,$my_username,$my_email,$my_password);
                    //$user->redirect('login.php?joined=true');
                    echo "<script>";
					echo "window.location.href = './login.php?joined=true'";
					echo "</script>";
                //}
            }
        }
        catch (PDOException $e){
          echo $e->getMessage();
        }
    }
}
?>

<br>
<br>
<div class="container">
  <div class="row">
  	<div class="col-md-6">
        <div class="form-container">
          <form class="form-horizontal" method="post">
          <fieldset>
            <div id="legend">
              <legend class="">Register</legend>
            </div>

            <?php
              if(isset($error)){
                foreach($error as $error){
                  ?>
                  <div class="alert alert-danger">
                    <i class="glyphicon glyphicon-warning-sign"></i>&nbsp; <?php echo $error;?>
                  </div>
                  <?php
                }
              } else if(isset($_GET['joined'])){
                 ?>
                 <div class="alert alert-info">
                  <i class="glyphicon glyphicon-log-in"></i>&nbsp; 
                  Successfully registered <a href="login.php">login</a>
                 </div>
                 <?php
              }
            ?>

            <div class="form-group">
              <label class="control-label" for="name">Name</label>
              <div class="controls">
                <input type="text" id="name" name="name" placeholder="name" class="form-control input-lg" value="<?php if(isset($error)){echo $my_name;}?>" />
                <p class="help-block">Name can contain any letters or numbers, without spaces</p>
              </div>
            </div>

            <div class="form-group">
              <label class="control-label" for="username">Username</label>
              <div class="controls">
                <input type="text" id="username" name="username" placeholder="username" class="form-control input-lg" value="<?php if(isset($error)){echo $my_username;}?>"/>
                <p class="help-block">Username can contain any letters or numbers, without spaces</p>
              </div>
            </div>
         
            <div class="form-group">
              <label class="control-label" for="email">E-mail</label>
              <div class="controls">
                <input type="email" id="email" name="email" placeholder="email" class="form-control input-lg" value="<?php if(isset($error)){echo $my_email;}?>"/>
                <p class="help-block">Please provide your E-mail</p>
              </div>
            </div>
         
            <div class="form-group">
              <label class="control-label" for="password">Password</label>
              <div class="controls">
                <input type="password" id="password" name="password" placeholder="password" class="form-control input-lg" value="<?php if(isset($error)){echo $my_password;}?>"/>
                <p class="help-block">Password should be at least 6 characters</p>
              </div>
            </div>
         
            <div class="form-group">
              <label class="control-label" for="password_confirm">Password (Confirm)</label>
              <div class="controls">
                <input type="password" id="password_confirm" name="password_confirm" placeholder="confirm password" class="form-control input-lg" />
                <p class="help-block">Please confirm password</p>
              </div>
            </div>
         
         	<br>
            <div class="form-group">
              <!-- Button -->
              <div class="controls">
                <button type="submit" class="btn btn-success" name="btn-register" onclick="loadLogin()">Register</button>
              </div>
            </div>
          </fieldset>
        </form>
      </div>
    </div> 
  </div>
</div>
    </body>
</html>

