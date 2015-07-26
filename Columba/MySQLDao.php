<?php

class MySQLDao {

	var $dbhost = null;
	var $dbuser = null;
	var $dbpass = null;
	var $conn = null;
	var $dbname = null;
	var $result = null;

	function _construct() {
		#$this->dbhost = Conn::$dbhost;
		#$this->dbuser = Conn::$dbuser;
		#$this->dbpass = Conn::$dbpass;
		#$this->dbname = Conn::$dbname;
		$this->dbhost = "beta.moe";
		$this->dbuser = "yudachi";
		$this->dbpass = "poi";
		$this->dbname = "columba";
	}
	
	public function openConnection() {
		$this->conn = new mysqli("beta.moe", "yudachi", "poi", "columba");

		if(mysqli_connect_errno())
			echo new Exception("Could not establish connection with database");
		#else 
		#	echo new Exception("success");
	}

	public function getConnection() {
		return $this->conn;
	}

	public function closeConnection() {
		if($this->conn != null) {
			$this->conn->close();
		}
	}

	public function getUserDetails($email) {
		$returnValue = array();
		$sql = "select * from user where user_email='" . $email . "'";
		$result = $this->conn->query($sql);

		if($result != null && (mysqli_num_rows($result) >= 1)) {
			$row = $result->fetch_array(MYSQL_ASSOC);
			if(!empty($row)) {
				$returnValue = $row;
			}
		}
		return $returnValue;
	}

	public function getUserDetailsWithPassword($email, $userPassword) {
		$returnValue = array();
		$sql = "select id, user_email from user where user_email='" .$email. "' and user_password='" .$user_password. "'";

		$result = $this->conn->query($sql);
		if($result != null && (mysqli_num_rows($result) >= 1)) {
			$row = $result->fetch_array(MYSQL_ASSOC);
			if(!empty($row)) {
				$returnValue = $row;
			}
		}
		return $returnValue;
	}

	public function registerUser($email, $password) {
		$sql = "insert into user set user_email=?, user_password=?";
		$statement = $this->conn->prepare($sql);

		if(!$statement) {
			throw new Exception($statement->error);
		}

		$statement->bind_param("ss", $email, $password);
		$returnValue = $statement->execute();
		return $returnValue;
	}
}
?>
