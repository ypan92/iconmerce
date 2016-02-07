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

$app->post('/user', function() use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$user = $app->request()->post();
	$result = $db->users->insert($user);
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

$app->delete('/user/:id', function($id) use($app, $db) {
	$app->response()->header("Content-Type", "application/json");
	$user = $db->cars()->where('user_id', $id);
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

$app->run();

