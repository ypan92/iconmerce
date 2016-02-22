<?php

require 'vendor/autoload.php';
require 'plugins/NotORM.php';

$app = new \Slim\Slim();

$dbhost = 'iconmercedb.cxcch2tzx4mi.us-west-1.rds.amazonaws.com';
$dbuser = 'iconadmin';
$dbpass = 'ic0n3ntry';
$dbname = 'icondb';
$dbmethod = 'mysql:dbname=';

$dsn = $dbmethod.$dbname;
$pdo = new PDO("mysql:host=$dbhost;port=8889;dbname=$dbname", $dbuser, $dbpass);
$db = new NotORM($pdo);

$app->get('/', function() {
	echo 'ICONMERCE - RESTful Services';
});

$app->get('/users', function() use($app, $db) {
	$users = array();
	foreach ($db->users() as $user) {
		$users[] = array(
			'user_id' => $user['user_id'],
			'username' => $user['username'],
			'password' => $user['password'],
			'email' => $user['email']
		);
	}
	$app->response()->header("Content-Type", "application/json");
	echo json_encode($users, JSON_FORCE_OBJECT);
});

$app->get('/users/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$user = $db->users()->where('user_id', $id);
	if ($data = $user->fetch()) {
		echo json_encode(array (
			'user_id' => $data['user_id'],
			'username' => $data['username'],
			'password' => $data['password'],
			'email' => $data['email']
		));
	}
	else {
		echo json_encode(array (
			'status' => false,
			'message' => "User ID $id does not exist"
		));
	}
});

$app->get('/products', function() use($app, $db) {
	$products = array();
	foreach($db->products() as $product) {
		$products[] = array(
			'item_id' => $product['item_id'],
			'item_price' => $product['item_price'],
			'item_name' => $product['item_name'],
			'item_desc' => $product['item_desc'],
			'item_reviews' => $product['item_reviews'],
			'item_rating' => $product['item_rating'],
			'item_location' => $product['item_location']
		);
	}
	$app->response()->header("Content-Type", "application/json");
	echo json_encode($products, JSON_FORCE_OBJECT);
});

$app->get('/products/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$product = $db->products()->where('item_id', $id);
	if ($data = $product->fetch()) {
		echo json_encode(array (
			'item_id' => $data['item_id'],
			'item_price' => $data['item_price'],
			'item_name' => $data['item_name'],
			'item_desc' => $data['item_desc'],
			'item_reviews' => $data['item_reviews'],
			'item_rating' => $data['item_rating'],
			'item_location' => $data['item_location']
		));
	}
	else {
		echo json_encode(array (
			'status' => false,
			'message' => "Product ID $id does not exist"
		));
	}
});

$app->post('/user', function() use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$user = $app->request()->post();
	$result = $db->users->insert($user);
	echo json_encode(array('id' => $result['id']));
});

$app->post('/product', function() use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$product = $app->request()->post();
	$result = $db->products->insert($product);
	echo json_encode(array('id' => $result['id']));
});

$app->put('/user/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$user = $db->users()->where("user_id", $id);
	if ($user->fetch()) {
		$post = $app->request()->put();
		$result = $user->update($post);
		echo json_encode(array(
			"status" => (bool)$result,
			"message" => "User updated successfully"
		));
	}
	else {
		echo json_encode(array(
			"status" => false,
			"message" => "User id $id does not exist"
		));
	}
});

$app->put('/product/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$product = $db->products()->where("item_id", $id);
	if ($product->fetch()) {
		$post = $app->request()->put();
		$result = $product->update($post);
		echo json_encode(array(
			"status" => (bool)$result,
			"message" => "Product updated successfully"
		));
	}
	else {
		echo json_encode(array(
			"status" => false,
			"message" => "Product id $id does not exist"
		));
	}
});

$app->delete('/user/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$user = $db->users()->where('user_id', $id);
	if ($user->fetch()) {
		$result = $user->delete();
		echo json_encode(array(
			"status" => true,
			"message" => "User deleted successfully"
		));
	}
	else {
		echo json_encode(array(
			"status" => false,
			"message" => "User id $id does not exist"
		));
	}
});

$app->delete('/product/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$product = $db->products()->where('item_id', $id);
	if ($product->fetch()) {
		$result = $product->delete();
		echo json_encode(array(
			"status" => true,
			"message" => "Product deleted successfully"
		));
	}
	else {
		echo json_encode(array(
			"status" => true,
			"message" => "Product id $id does not exist"
		));
	}
});

$app->run();

