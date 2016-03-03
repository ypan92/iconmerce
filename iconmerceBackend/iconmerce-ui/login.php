<?php
$pageTitle = "Login";
$nameTitle = "ICONMERCE";
include("inc/header.php");
include_once 'pdo/config.php';

if(isset($_POST['btn-submit'])) {
  $my_indentity = trim($_POST['indentity']);
  $my_password = trim($_POST['password']);

  if($user->login($my_indentity, $my_password)) {
    //$user->redirect('index.php');
    echo "<script>";
	echo "window.location.href = './index.php'";
	echo "</script>";
  } else {
    $error[] = "Invalid username/email or password";
  }
}
?>

<br>
<br>
<div class="container">
    <div class="row">
        <!--div class="col-sm-6 col-md-4 col-md-offset-4"-->
        <div>
            <h1 class="text-center login-title">Sign in to continue to iconmerce</h1>
            <div class="account-wall">
                <!--<img class="profile-img" src="https://lh5.googleusercontent.com/-b0-k99FZlyE/AAAAAAAAAAI/AAAAAAAAAAA/eu7opA4byxI/photo.jpg?sz=120"
                    alt="">-->
                <img class="profile-img" src="./img/Logo.png"
                    alt="">
                <form class="form-signin" method="post">
                    <?php 
                      if(isset($error)){
                        foreach($error as $error) {
                        ?>
                            <div class="alert alert-danger">
                                <i class="glyphicon glyphicon-warning-sign"></i>&nbsp;
                                <?php echo $error;?> !
                            </div>
                        <?php
                        }
                      }
                    ?>
                <input type="text" class="form-control" name="indentity" placeholder="Email" required autofocus>
                <input type="password" class="form-control" name="password" placeholder="Password" required>
                <button class="btn btn-lg btn-primary btn-block" type="submit" name="btn-submit">
                    Sign in</button>
                <label class="checkbox pull-left">
                    <input type="checkbox" value="remember-me">
                    Remember me
                </label>
                <a href="#" class="pull-right need-help">Need help? </a><span class="clearfix"></span>
                </form>
            </div>
            <a href="signup.php" class="text-center new-account">Create an account </a>
        </div>
    </div>
</div>
</body>
</html>