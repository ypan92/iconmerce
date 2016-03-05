<?php
require_once('./stripe/lib/Stripe.php');

$stripe = array(
  "secret_key"      => "sk_test_H5FlQjIq5m7Xn9W7nzkmjtWM",
  "publishable_key" => "pk_test_sTyxJi9t1kHFS8R27hByprv6"
);

\Stripe\Stripe::setApiKey($stripe['secret_key']);
?>