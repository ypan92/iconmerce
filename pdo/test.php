<?php
require_once 'config.php';
echo 'included config';

  try {
   // $user->register('Jesus Vivar', 'user', 'jvivar@calpoly.edu', 'pass');
    //$user->register('Yang Pan', 'user', 'ypan@calpoly.edu', 'pass');
    //$user->register('Ka Thong', 'user', 'kathong@calpoly.edu', 'pass');
    //$user->login('user', 'jvivar@calpoly.edu','pass');
    echo 'do nothing';
  }catch (PDOException $e){
    echo $e->getMessage();
  }

?> 