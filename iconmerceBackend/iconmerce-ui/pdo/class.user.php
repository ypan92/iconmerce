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