<?php

  try {
    $my_name = $_POST['name'];
    $my_username = $_POST['username'];
    $my_email = $_POST['email'];
    $my_password = $_POST['password'];

    //if($user->register($my_name,$my_username,$my_email,$my_password)) {
      echo 'SUCCESS!: name: '. $my_name . ' username: ' . $my_username . ' email: '.$my_email;
      //$user->redirect('login.php');
    //}
  }catch (PDOException $e){
    echo $e->getMessage();
  }
?>