<?php
class USER {
	private $db;

	function __construct($DB_con){
		$this->db = $DB_con;
	}

	public function register($name, $username, $email, $pass) {
		try {
			$new_password = password_hash($pass, PASSWORD_DEFAULT);

			$query = $this->db->prepare("INSERT INTO users(username,password,name,email)
										VALUES(:uname, :upass, :tname, :uemail)");
			$query->bindparam(":uname", $username);
			$query->bindparam(":upass", $new_password);
			$query->bindparam(":tname", $name);
			$query->bindparam(":uemail", $email);
			$query->execute();
			return $query;
		} catch (PDOException $e){
			echo $e->getMessage();
		}
	}

	public function login($indentity, $password) {
		try {
			$query = $this->db->prepare("SELECT * FROM users WHERE email=:umail LIMIT 1");
			$query->execute(array(':umail'=>$indentity));
			$urow=$query->fetch(PDO::FETCH_ASSOC);

			if($query->rowCount() > 0){
				if(password_verify($password, $urow['password'])){
					$_SESSION['user_session'] = $urow['user_id'];
					$_SESSION['username'] = $urow['username'];
					return true;
				} else {
				  return false;
				}
			}

		} catch (PDOException $e){
			echo $e->getMessage();
		}
	}

	public function addReviewRating($user_id, $item_id, $rating, $review) {
		try {
			$date = date('Y-m-d H:i:s');
			echo $date;
			$addQuery = $this->db->prepare("INSERT INTO ReviewsRatings (user_id, item_id, rating, review, date) 
											VALUES(".$user_id.", ".$item_id.", ".$rating.", '".$review."', '".$date."')");
			$addQuery->execute();
		}
		catch (PDOException $e) {
			echo $e->getMessage();
		}
	}

	public function addRating($item, $id, $data){
		try{
			$update = $this->db->prepare("INSERT INTO reviews (user_id, item_id, rating)
										VALUES(:user, :item,:rating)");
			$update->bindparam(":user", $id);
			$update->bindparam(":item", $item);
			$update->bindparam(":rating", $data);
			$update->execute();
			} catch (PDOException $e){
				echo $e->getMessage();
			}
	}

	public function update($id, $up, $col, $table){
		try{
			$update = $this->db->prepare("UPDATE ".$table." SET ".$col."=:uname WHERE user_id=:userID");
			if ($col == "password") {
				$up = password_hash($up, PASSWORD_DEFAULT);
			}
			$update->bindparam(":uname", $up);
			$update->bindparam(":userID", $id);
			$update->execute();
		} catch (PDOException $e){
			echo $e->getMessage();
		}
	}

	public function addPurchase($usrId, $itmId) {
		try {
			$existCheck = $this->db->prepare("SELECT * FROM purchases WHERE user_id = ".$usrId." and item_id = ".$itmId);
			$existCheck->execute();
			$row = $existCheck->fetch(PDO::FETCH_ASSOC);
			if (!$row) {
				$update = $this->db->prepare("INSERT into purchases(user_id, item_id) VALUES(".$usrId.",".$itmId.")");
				$update->execute();
			}
		}
		catch (PDOException $e) {
			echo $e->getMessage();
		}
	}
	
	public function addComment($id, $comment, $item){
		try{
			$update = $this->db->prepare("INSERT INTO comments(user_id,comment,item_id)
										VALUES(:user, :come, :item)");
			$update->bindparam(":user", $id);
			$update->bindparam(":come", $comment);
			$update->bindparam(":item", $item);
			$update->execute();
		} catch (PDOException $e){
			echo $e->getMessage();
		}
	}

	public function is_loggedin() {
		if(isset($_SESSION['user_session'])){
			return true;
		}
	}

	public function redirect($url){
		header('Location: '.$url);
	}

	public function logout(){
		session_destroy();
		unset($_SESSION['user_session']);
		unset($_SESSION['username']);
		return true;
	}

}
?>