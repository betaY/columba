<?php
require("Conn.php");
require("MySQLDao.php");

$email=htmlentities($_POST["email"]);
$password=htmlentities($_POST["password"]);

$returnValue=array();

if (empty($email) || empty($password)) {
  $returnValue["status"]="error";
  $returnValue["message"]="Missing required field";
  echo json_decode($returnValue);
  return;
}
$secure_password=md5($password);

$dao=new MySQLDao();
$dao->openConnection();
$userDetails=$dao->getUserDetailsPassword($email,$secure_password);

if (!empty($userDetails)) {
  $returnValue["status"]="Success";
  $returnValue["message"]="User is registered";
  echo json_decode($returnValue);
} else {
  $returnValue["status"]="error";
  $returnValue["message"]="User is not found";
  echo json_encode($returnValue);
}

$dao->closeConnection();
?>
