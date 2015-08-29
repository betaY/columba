<?php
require("Conn.php");
require("MySQLDao.php");

$email = htmlentities($_POST["email"]);
$password = htmlentities($_POST["password"]);

$returnValue=array();

if(empty($email) || empty($password)) {
  $returnValue["status"]="error";
  $returnValue["message"]="Miss requiered field";
  echo json_encode($returnValue);
  return;
}

$dao = new MySQLDao();
$dao->openConnection();
$userDetails=$dao->getUserDetails($email);

// echo json_encode($userDetails);

if(!empty($userDetails)) {
//  echo "<br>exist";
  $returnValue["status"]="error";
  $returnValue["message"]="User already exists";
  echo json_encode($returnValue);
  return;
}

$secure_password=md5($password);
//echo "<br>233333<br>$password";
$result=$dao->registerUser($email, $secure_password);

if($result) {
	//echo "<br>wwwwwwww";
  $returnValue["status"]="Success";
  $returnValue["message"]="User is registered";
  echo json_encode($returnValue);
  return;
}

$dao->closeConnection();

?>
